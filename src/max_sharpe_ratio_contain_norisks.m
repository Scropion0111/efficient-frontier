% 加载数据
load('portfolio_data_cleaned.mat'); % 包含 meanReturns 和 covMatrix

% 数据检查与修复
meanReturns(isnan(meanReturns) | isinf(meanReturns)) = 0; % 修复收益率中的 NaN 和 Inf
covMatrix(isnan(covMatrix) | isinf(covMatrix)) = 0; % 修复协方差矩阵中的 NaN 和 Inf
if min(eig(covMatrix)) <= 0
    covMatrix = covMatrix + eye(size(covMatrix)) * 1e-6; % 确保正定性
end

% 参数设置
numAssets = length(meanReturns); % 资产数量
riskFreeRate = 0.0005; % 无风险收益率

% 定义优化问题
f = zeros(numAssets, 1); % 不直接最大化收益，需要通过约束间接最大化夏普比率
Aeq = ones(1, numAssets); % 权重总和为1
beq = 1;
lb = zeros(numAssets, 1); % 权重下界为0
ub = ones(numAssets, 1); % 权重上界为1

% 定义目标函数（最大化夏普比率的负数）
objective = @(w) -((dot(w, meanReturns) - riskFreeRate) / ...
    max(sqrt(w' * covMatrix * w), 1e-10)); % 防止除以零

% 优化初始点
initWeights = ones(numAssets, 1) / numAssets; % 初始点：等权重
options = optimoptions('fmincon', 'Algorithm', 'sqp', 'Display', 'iter'); % 使用sqp算法
[wOptimal, fval] = fmincon(objective, initWeights, [], [], Aeq, beq, lb, ub, [], options);

% 结果
optimalReturn = dot(wOptimal, meanReturns); % 最优组合的期望收益率
optimalRisk = sqrt(wOptimal' * covMatrix * wOptimal); % 最优组合的风险
optimalSharpe = (optimalReturn - riskFreeRate) / optimalRisk; % 最优夏普比率

% 打印结果
disp('最优投资组合权重:');
disp(wOptimal);
disp(['最优夏普比率: ', num2str(optimalSharpe)]);
disp(['最优投资组合收益率: ', num2str(optimalReturn)]);
disp(['最优投资组合风险: ', num2str(optimalRisk)]);

% 绘制有效前沿及最优点
numPortfolios = 10000; % 随机生成的组合数量
weights = rand(numPortfolios, numAssets);
weights = weights ./ sum(weights, 2);

portfolioReturns = weights * meanReturns';
portfolioRisks = sqrt(sum((weights * covMatrix) .* weights, 2));
sharpeRatios = (portfolioReturns - riskFreeRate) ./ portfolioRisks;

figure;
scatter(portfolioRisks, portfolioReturns, 10, sharpeRatios, 'filled');
colorbar;
xlabel('Portfolio Risk (Standard Deviation)');
ylabel('Portfolio Return');
title('Efficient Frontier with Sharpe Ratio');
hold on;
scatter(optimalRisk, optimalReturn, 100, 'r', 'filled'); % 绘制最优点
legend('Portfolios', 'Optimal Portfolio');
grid on;
