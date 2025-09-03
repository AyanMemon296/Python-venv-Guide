# venv_setup-v1.ps1

Write-Host "Creating a virtual environment named .venv..."
python -m venv .venv

Write-Host "Activating the virtual environment..."
.\.venv\Scripts\Activate

Write-Host "Checking Python version inside venv..."
python -V

Write-Host "Checking pip version inside venv..."
python -m pip --version

Write-Host "Listing installed packages (should be minimal)..."
pip list

Write-Host "Upgrading pip, setuptools, and wheel..."
python -m pip install --upgrade pip setuptools wheel

Write-Host "Verifying installed packages after upgrade..."
pip list

Write-Host "Virtual environment setup complete!"
