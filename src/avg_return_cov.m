% 定义数据文件夹路径
folderPath = 'C:\Users\Administrator\Documents\MATLAB\Portfolio_optimization\data\';

% 文件名列表
fileNames = {'AAPL_data.csv', '^GSPC_data.csv', 'AMZN_data.csv', 'GOOGL_data.csv', ...
             'JPM_data.csv', 'META_data.csv', 'MSFT_data.csv', 'NVDA_data.csv', ...
             'PG_data.csv', 'SPY_data.csv', 'TSLA_data.csv', 'V_data.csv'};

closePrices = []; % 初始化收盘价矩阵

for i = 1:length(fileNames)
    % 读取 CSV 文件，保留原始列标题
    filePath = fullfile(folderPath, fileNames{i});
    data = readtable(filePath, 'VariableNamingRule', 'preserve');
    
    % 确保列名与原始 CSV 文件一致，提取 'Adj Close' 列
    if ismember('Adj Close', data.Properties.VariableNames)
        adjClose = data.('Adj Close'); % 提取调整收盘价列
    else
        error(['"Adj Close" 列未在文件中找到: ', fileNames{i}]);
    end

    % 用前一个有效值填充缺失值
    adjClose = fillmissing(adjClose, 'previous'); 
    adjClose = fillmissing(adjClose, 'constant', 0); 

    % 将数据追加到矩阵中
    closePrices = [closePrices, adjClose];
end

% 计算对数收益率
logReturns = diff(log(closePrices));

% 去除所有含有 NaN 的行
logReturns(any(isnan(logReturns), 2), :) = [];

% 计算平均收益率和协方差矩阵
meanReturns = mean(logReturns);
covMatrix = cov(logReturns);

% 保存清洗后的数据
save('portfolio_data_cleaned.mat', 'meanReturns', 'covMatrix');
disp('清洗完成并保存数据至 portfolio_data_cleaned.mat');
