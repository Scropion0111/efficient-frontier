% 读取所有 CSV 文件并清洗数据
fileNames = {'AAPL_data.csv', '^GSPC_data.csv', 'AMZN_data.csv', 'GOOGL_data.csv', ...
             'JPM_data.csv', 'META_data.csv', 'MSFT_data.csv', 'NVDA_data.csv', ...
             'PG_data.csv', 'SPY_data.csv', 'TSLA_data.csv', 'V_data.csv'};

closePrices = []; % 初始化收盘价矩阵
for i = 1:length(fileNames)
    % 读取文件
    data = readtable(['C:\Users\Administrator\Documents\MATLAB\Portfolio_optimization\data\', fileNames{i}]);
    
    % 检查并清理缺失值
    data.AdjClose = fillmissing(data.AdjClose, 'previous'); % 用前一个有效值填充缺失值
    data.AdjClose = fillmissing(data.AdjClose, 'constant', 0); % 再将剩余缺失值填充为 0

    % 追加到矩阵中
    closePrices = [closePrices, data.AdjClose];
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
