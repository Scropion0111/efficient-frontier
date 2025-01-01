##  help you to fetch the data  from  python script
*-
import yfinance as yf
import pandas as pd

# symbols
symbols = ['AAPL', 'MSFT', 'GOOGL', 'AMZN', 'TSLA', 'META', 'NVDA', 'JPM', 'V', 'PG']

#  install  lastest 20 years  data
data = yf.download(symbols, start="2000-01-01", end="2024-01-01", group_by="ticker")

# save as CSV file
for symbol in symbols:
    symbol_data = data[symbol]
    symbol_data.to_csv(f"data/{symbol}_data.csv")

print("fetch data succuessfully ")
