# Energy Consumption Forecasting with Feature Selection and Explainable Machine Learning

An experimental reimplementation of a feature selection and interpretable machine learning framework for energy consumption forecasting.

## Overview

This project explores energy consumption forecasting by combining feature selection techniques, machine learning models, Bayesian hyperparameter optimization, and SHAP-based model interpretation.

The implementation is based on the framework proposed by Eskandari et al. (2024), applied to the Appliances Energy Prediction dataset.

**Important:** This project uses a different dataset from the original paper. It is a methodological reimplementation, not a direct reproduction of the original numerical results.

## Research Reference

Eskandari, H. et al. (2024).

*Innovative framework for accurate and transparent forecasting of energy consumption: A fusion of feature selection and interpretable machine learning.*

Applied Energy, 366, 123314.

DOI: https://doi.org/10.1016/j.apenergy.2024.123314

## Dataset

- Dataset: Appliances Energy Prediction
- Source: UCI Machine Learning Repository
- Observations: 19,735
- Sampling interval: 10 minutes
- Prediction target: `Appliances(t+1)`
- Forecast horizon: 10 minutes

Dataset: https://archive.ics.uci.edu/dataset/374/appliances+energy+prediction

## Methodology

### Feature Selection

- mRMR
- Random Forest
- RReliefF
- F-test
- Ensemble Filter (S1)
- SIFE Wrapper (S2)
- Hybrid Ensemble Filter-Wrapper (S1S2)

### Forecasting Models

- LASSO
- SVR-Linear
- SVR-RBF
- Gaussian Process Regression (GPR)
- LSBoost

### Explainability

- SHAP PermutationExplainer

### Additional Experiments

- Lag Feature Ablation
- Gaussian Noise Robustness

## Selected Experimental Results

The best RMSE among the 20 evaluated configurations was obtained by S1 + LSBoost:

| Metric | Result |
|---|---:|
| RMSE | 61.2240 |
| MAE | 26.5439 |
| R² | 0.5477 |
| Selected features | 10 |

Removing `Appliances_t` from the selected S1 feature subset increased RMSE by approximately 40.41%.

Under Gaussian noise with standard deviation 0.05, 0.10, and 0.20 in the scaled input space, RMSE increased by approximately 20.67%, 50.80%, and 103.62%, respectively.

These results are specific to the KAG dataset and the implemented experimental configuration.

## Repository Structure

```text
predictive-analytics/
├── data/
│   └── raw/
├── notebooks/
├── README.md
├── README_VSCODE.md
├── requirements.txt
└── outputs/
```

## Reproducibility

Python 3.11 is used for the experimental environment.

Install dependencies:

```bash
python -m pip install -r requirements.txt
```

Open the notebook in Jupyter or VS Code and select the appropriate Python kernel.

See `README_VSCODE.md` for additional Windows setup instructions.

## Implementation Notes

Some components are Python reimplementations or approximations of the MATLAB methods described in the original paper. In particular, the SIFE implementation approximates fuzzy granulation using Jaccard-based diversity, while GPR, LSBoost, Bayesian optimization, and SHAP use Python library implementations.

Consequently, the numerical results should not be interpreted as exact replications of the original MATLAB experiments.

## License and Attribution

The original research belongs to its respective authors. Dataset attribution and usage should follow the UCI dataset license.

This repository is maintained as an academic research project.
