# Portfolio Optimization

This repository contains MATLAB code for portfolio optimization. The project explores asset allocation strategies, minimizing risk while maximizing return based on financial data.

## Features
- Efficient Frontier Calculation
- Risk-Reward Optimization
- Visualizations of Portfolio Metrics

## How to Use
1. Clone the repository:
   ```bash
   git clone https://github.com/Scropion0111/efficient-frontier.git


Execution Order Summary:
Fetch Data (Python): Run fetch_data.py to download raw stock data into the data folder.
Clean Data (MATLAB): Run clean_data.m to prepare the data for analysis.
Calculate Returns and Covariance (MATLAB):
Run avg_return_cov.m to calculate average returns.
Run check_return_cov.m to compute the covariance matrix.
Optimize Portfolio (MATLAB):
Run portfolio_optimization.m to find the optimal portfolio allocations.
Visualize Efficient Frontier (MATLAB):
Run efficient_frontier.m to generate and plot the Efficient Frontier.
Validate Results (MATLAB):
Run max_sharpe_ratio_contain_norisks.m to review and validate the optimization results.
Folder Structure Overview:
data/: Contains raw CSV data files for individual stocks.
results/: Stores processed results (e.g., portfolio_results.csv).
src/: Contains MATLAB scripts for data cleaning, analysis, and optimization.
