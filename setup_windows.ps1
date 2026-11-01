$ErrorActionPreference = "Stop"

Write-Host "=== Energy forecasting: Windows environment setup ===" -ForegroundColor Cyan

$pythonLauncher = Get-Command py -ErrorAction SilentlyContinue
if ($pythonLauncher) {
    & py -3.11 --version
    if ($LASTEXITCODE -ne 0) {
        throw "Python 3.11 was not found. Install Python 3.11 (64-bit) and run this script again."
    }
    if (-not (Test-Path ".venv\Scripts\python.exe")) {
        & py -3.11 -m venv .venv
    }
} else {
    $pythonCommand = Get-Command python -ErrorAction SilentlyContinue
    if (-not $pythonCommand) {
        throw "Python was not found. Install Python 3.11 (64-bit), then reopen VS Code."
    }
    $pyVersion = & python -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')"
    if ($pyVersion -ne "3.11") {
        throw "Python 3.11 is required by this reproducible environment. Detected: $pyVersion"
    }
    if (-not (Test-Path ".venv\Scripts\python.exe")) {
        & python -m venv .venv
    }
}

$venvPython = ".venv\Scripts\python.exe"
& $venvPython -m pip install --upgrade pip
& $venvPython -m pip install -r requirements.txt
& $venvPython -m ipykernel install --user --name energy-forecasting --display-name "Python 3.11 (energy-forecasting)"

Write-Host ""
Write-Host "Setup complete." -ForegroundColor Green
Write-Host "Open notebooks\energy_forecasting_reproduction_ABC.ipynb in VS Code."
Write-Host "Select kernel: Python 3.11 (energy-forecasting)."
Write-Host "The project virtual environment is .venv."
