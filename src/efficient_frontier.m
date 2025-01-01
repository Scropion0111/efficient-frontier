load('portfolio_data_cleaned.mat'); % 包含 meanReturns 和 covMatrix

% 数据清洗
meanReturns(isnan(meanReturns) | isinf(meanReturns)) = 0; % 清洗均值收益率
covMatrix(isnan(covMatrix) | isinf(covMatrix)) = 0; % 清洗协方差矩阵

% 确保资产数量一致
numAssets = size(covMatrix, 1); % 获取资产数量
numPoints = 10000; % 模拟组合的数量

% 生成随机权重
weights = rand(numPoints, numAssets); % 随机生成权重
weights = weights ./ sum(weights, 2); % 归一化权重

% 初始化变量
portfolioReturns = zeros(1, numPoints);
portfolioRisks = zeros(1, numPoints);

% 计算组合收益率和风险
for i = 1:numPoints
    w = weights(i, :);
    portfolioReturns(i) = dot(w, meanReturns); % 组合收益率
    portfolioRisks(i) = sqrt(w * covMatrix * w'); % 组合风险
end

% 绘制有效前沿
figure;
scatter(portfolioRisks, portfolioReturns, 10, 'filled'); % 使用散点图绘制所有组合
xlabel('Portfolio Risk (Standard Deviation)');
ylabel('Portfolio Return');
title('Efficient Frontier');
grid on;