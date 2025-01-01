% 找到最大收益的组合
[maxReturn, maxReturnIdx] = max(portfolioReturns); % 最大收益及其索引
maxReturnRisk = portfolioRisks(maxReturnIdx); % 最大收益组合的风险
maxReturnWeights = weights(maxReturnIdx, :); % 最大收益组合的权重

% 打印最大收益组合的信息
disp('最大收益组合:');
disp(['收益率: ', num2str(maxReturn)]);
disp(['风险: ', num2str(maxReturnRisk)]);
disp('权重: ');
disp(maxReturnWeights);

% 找到最优组合（最高夏普比率）
sharpeRatios = (portfolioReturns - riskFreeRate) ./ portfolioRisks; % 计算所有组合的夏普比率
[maxSharpe, maxSharpeIdx] = max(sharpeRatios); % 最高夏普比率及其索引
optimalReturn = portfolioReturns(maxSharpeIdx); % 最优组合的收益率
optimalRisk = portfolioRisks(maxSharpeIdx); % 最优组合的风险
optimalWeights = weights(maxSharpeIdx, :); % 最优组合的权重

% 打印最优组合的信息
disp('最优组合（最高夏普比率）:');
disp(['夏普比率: ', num2str(maxSharpe)]);
disp(['收益率: ', num2str(optimalReturn)]);
disp(['风险: ', num2str(optimalRisk)]);
disp('权重: ');
disp(optimalWeights);

% 绘制有效前沿
figure;
scatter(portfolioRisks, portfolioReturns, 10, sharpeRatios, 'filled'); % 用夏普比率绘制散点
colorbar;
xlabel('Portfolio Risk (Standard Deviation)');
ylabel('Portfolio Return');
title('Efficient Frontier with Sharpe Ratio');
grid on;

% 标注最大收益和最优组合
hold on;
scatter(maxReturnRisk, maxReturn, 100, 'g', 'filled'); % 标注最大收益组合
scatter(optimalRisk, optimalReturn, 100, 'r', 'filled'); % 标注最优组合
legend('Portfolios', 'Max Return Po5rtfolio', 'Optimal Sharpe Portfolio');
