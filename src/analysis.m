% 加载数据
data = readtable('../data/AAPL_data.csv');
dates = datetime(data.Date, 'InputFormat', 'yyyy-MM-dd'); % 提取日期
closePrices = data.Close; % 提取收盘价

% 绘制时间序列
figure;
plot(dates, closePrices);
xlabel('Date');
ylabel('Close Price');
title('AAPL Closing Prices');
grid on;
