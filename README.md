# Energy Forecasting Paper Reproduction

Notebook: `energy_forecasting_paper_reproduction.ipynb`

## Open in Google Colab
1. Upload the notebook to Google Drive or open it in Google Colab.
2. Run cells top-to-bottom.
3. Mount Drive when prompted.
4. Upload `KAG_energydata_complete.csv` when prompted, unless it already exists in the new Drive project folder.
5. Run `EXPERIMENT_MODE="quick"` once to verify the pipeline. Then change to `"paper"`, restart runtime and run all cells for the final run.

## Important method notes
- The notebook uses the user's 10-minute dataset, not the paper's UK monthly dataset.
- Forecast target: `Appliances(t+1)` (one 10-minute step ahead).
- It uses `RReliefF` for the continuous regression target.
- `SIFE` is a transparent Python port based on published description, not the original MATLAB source implementation.
- `GPR` and `LSBoost` are scikit-learn mappings, not exact MATLAB estimator replicas.
- Do not compare absolute RMSE/MAPE values with the paper's Table 7 because dataset/frequency/units differ.

## Persistence
All outputs are saved under `MyDrive/energy_forecasting_reproduction/`. A ZIP backup is generated at the end of the run.

## Suggested GitHub layout
```text
energy-forecasting-reproduction/
├── notebooks/energy_forecasting_paper_reproduction.ipynb
├── README.md
├── .gitignore
└── results/  # only aggregated outputs/plots; do not commit private raw data
```
Do not push the raw CSV unless its license and sharing rights permit it.
