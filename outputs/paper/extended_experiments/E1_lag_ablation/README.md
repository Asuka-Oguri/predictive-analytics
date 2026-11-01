# E1 - Lag Feature Ablation

This experiment evaluates the contribution of the lag feature `Appliances_t` to the forecasting performance of the S1-LSBoost model.

## Files

- `lag_ablation_predictions.csv`: Model predictions.
- `lag_ablation_results.csv`: Evaluation results.
- `lag_ablation_rmse.png`: RMSE comparison figure.

## Experimental setup

The experiment compares the original S1-LSBoost model using 10 selected features with a No-Lag variant using 9 features after removing `Appliances_t`.

Note: Feature selection is not rerun in this experiment.
