# Energy Forecasting Reproduction — Visual Studio Code

## 1. Project contents

```text
energy_forecasting_vscode/
├── data/raw/KAG_energydata_complete.csv
├── notebooks/energy_forecasting_reproduction_ABC.ipynb
├── outputs/quick/
├── outputs/paper/
├── backups/
├── .vscode/settings.json
├── .vscode/extensions.json
├── requirements.txt
├── setup_windows.ps1
├── .gitignore
└── README_VSCODE.md
```

The notebook is a standalone Python/Jupyter project. It does not use Google Drive, Colab mounts, or prior notebook files. The dataset is included at `data/raw/KAG_energydata_complete.csv`.

## 2. Required software

- Windows 10/11, 64-bit.
- Python 3.11.9, 64-bit (the pinned package set targets Python 3.11).
- Visual Studio Code (VS Code), not Visual Studio Community/2022.
- VS Code extensions published by Microsoft: **Python** and **Jupyter**.

Official installation pages:
- Python 3.11.9 (Windows 64-bit installer): https://www.python.org/downloads/release/python-3119/
- VS Code: https://code.visualstudio.com/Download
- Python in VS Code: https://code.visualstudio.com/docs/languages/python
- Jupyter notebooks in VS Code: https://code.visualstudio.com/docs/datascience/jupyter-notebooks

The dependency versions are pinned in `requirements.txt` to create a compatible, reproducible Python 3.11 environment. They are not intended to represent the newest release of every library.

## 3. First-time setup

1. Install Python 3.11.9 (64-bit) from the release page above. Choose **Windows installer (64-bit)**. In the installer, enable **Add python.exe to PATH** and the Python Launcher if those options are shown. Python.org identifies 3.11.9 as the last 3.11 release with the traditional Windows installer; newer 3.11 security releases are source-only. This project pins libraries for a reproducible local coursework environment.
2. Install Visual Studio Code.
3. Open VS Code → Extensions (`Ctrl+Shift+X`). Install **Python** and **Jupyter** from Microsoft.
4. Extract this project ZIP to a normal local folder, for example `D:\energy_forecasting_vscode`. Avoid placing the project inside a temporary Downloads folder or a cloud-synced folder that may pause file writes.
5. In VS Code, choose **File → Open Folder...** and open `energy_forecasting_vscode`.
6. Choose **Terminal → New Terminal**. The terminal should open at the project root.
7. Run the setup script in PowerShell:

```powershell
powershell -ExecutionPolicy Bypass -File .\setup_windows.ps1
```

The script creates `.venv`, installs the pinned libraries, and registers a Jupyter kernel. It does not change the machine-wide PowerShell execution policy.

## 4. Open and run the notebook

1. In the VS Code Explorer, open `notebooks/energy_forecasting_reproduction_ABC.ipynb`.
2. Select the kernel in the upper-right notebook toolbar: **Python 3.11 (energy-forecasting)**. If it is not listed, use `Ctrl+Shift+P` → **Python: Select Interpreter** and choose `.venv\Scripts\python.exe`, then reopen the notebook.
3. Run the notebook in order using **Run All**. The first code cells check the installed environment and the CSV path.
4. The notebook initially uses `EXPERIMENT_MODE = "quick"`. This mode is for checking the end-to-end pipeline and must not be used as the final research result.
5. After `quick` finishes and the output has been checked, change the configuration cell to `EXPERIMENT_MODE = "paper"`, restart the kernel, and run all cells from the beginning.

The CSV path is fixed relative to the project root: `data/raw/KAG_energydata_complete.csv`. Do not move the CSV unless `DATA_PATH` is also changed. Save notebook edits with `Ctrl+S`; the local `outputs` and `backups` folders are independent of Google Drive.

## 5. Output, recovery, and storage

- `outputs/quick/`: smoke-test artifacts.
- `outputs/paper/`: formal experimental artifacts.
- `outputs/<mode>/artifacts/feature_selection/`: `S1`, `S2`, `S1S2` selections and histories.
- `outputs/<mode>/artifacts/models/`: fitted estimators and metadata.
- `outputs/<mode>/artifacts/metrics/`: model metrics and prediction files.
- `outputs/<mode>/figures/`: charts and SHAP summary plots.
- `outputs/<mode>/reports/`: tables, feature importance, SHAP importance and run manifest.
- `backups/`: ZIP backup of the run output, created by the final notebook cell.

The notebook stores data fingerprints and experiment metadata with checkpoints. After an interruption, reopen VS Code, select the same kernel, and run all cells from the top. Matching Bayesian Optimization, `SIFE`, and fitted-model checkpoints can be reused; changed data, estimator parameters, feature subsets, experiment mode, or notebook revision invalidate the corresponding checkpoint.

Keep the computer powered on and make sure the local disk has adequate free space during `paper`. The five Bayesian searches and the ten `SIFE` tracks can be CPU-intensive. A GPU is not required by this notebook. The code uses deterministic temporal subsampling caps for the computationally expensive wrapper, Bayesian search and `SVR` steps; these dataset-specific adaptations are recorded in the experiment manifest and are not settings from the original paper.

## 6. Notebook organization: A → B → C

- **A — Data and Feature Selection:** data quality, `Outlier Analysis`, supervised time-series construction, chronological split, `Ensemble filter`, `SIFE`, `S2`, `S1S2`, and feature-subset validation.
- **B — Diagnostics and statistics:** descriptive statistics, target/feature distributions, time-series diagnostics, Pearson coefficients and two-sided significance tests.
- **C — Forecasting and interpretation:** `Bayesian Optimization`, five paper models, supplementary baselines, evaluation, plots, and branch-wise `SHAP`.

The notebook starts in `quick` mode. This is intentional: the mode should be used to validate the local environment before changing the configuration to `paper`.

## 7. Important methodological notes

This is a **method reproduction on the KAG energy dataset**, not a replication of the original UK national monthly dataset or its numerical results. The KAG target is `Appliances(t+1)` at a 10-minute horizon. The notebook retains the paper's broad framework—four base feature-selection methods, three feature-selection tracks, five regression models, Bayesian hyperparameter search, evaluation metrics, and SHAP—but clearly records implementation differences, including the Python `SIFE` port, equal-weight Ensemble Filter aggregation, scikit-learn mappings, and permutation-based SHAP.

`Outlier Analysis` is retained. By default, outliers are detected and summarized but not deleted. Enabling row deletion triggers a second timestamp-regularity check so the one-step label cannot silently change from 10 minutes to a longer interval.

## 8. GitHub

The `.gitignore` excludes the raw CSV, generated outputs, backups and `.venv`. Keep the dataset and generated artifacts locally; commit the notebook, README, setup script and requirements file. Confirm that the dataset's license and course rules allow redistribution before adding raw data to a public repository.
