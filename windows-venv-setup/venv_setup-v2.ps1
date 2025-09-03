# venv_setup-v2.ps1

Write-Host "Checking if Python is installed..."
try {
    python -V
} catch {
    Write-Host "Python is not installed or not in PATH. Exiting." -ForegroundColor Red
    exit 1
}

Write-Host "Creating a virtual environment named .venv..."
try {
    python -m venv .venv
    Write-Host "Virtual environment created successfully." -ForegroundColor Green
} catch {
    Write-Host "Failed to create virtual environment." -ForegroundColor Red
    exit 1
}

Write-Host "Activating the virtual environment..."
try {
    .\.venv\Scripts\Activate
    Write-Host "Virtual environment activated." -ForegroundColor Green
} catch {
    Write-Host "Failed to activate the virtual environment." -ForegroundColor Red
    exit 1
}

Write-Host "Checking Python version inside venv..."
try {
    python -V
} catch {
    Write-Host "Failed to check Python version." -ForegroundColor Red
}

Write-Host "Checking pip version inside venv..."
try {
    python -m pip --version
} catch {
    Write-Host "Failed to check pip version." -ForegroundColor Red
}

Write-Host "Listing installed packages (should be minimal)..."
try {
    pip list
} catch {
    Write-Host "Failed to list installed packages." -ForegroundColor Red
}

Write-Host "Upgrading pip, setuptools, and wheel..."
try {
    python -m pip install --upgrade pip setuptools wheel
    Write-Host "Pip, setuptools, and wheel upgraded." -ForegroundColor Green
} catch {
    Write-Host "Failed to upgrade pip, setuptools, or wheel." -ForegroundColor Red
}

Write-Host "Verifying installed packages after upgrade..."
try {
    pip list
} catch {
    Write-Host "Failed to list installed packages after upgrade." -ForegroundColor Red
}

Write-Host "Checking for requirements.txt..."
if (Test-Path "requirements.txt") {
    Write-Host "requirements.txt found. Installing dependencies..."
    try {
        pip install -r requirements.txt
        Write-Host "Dependencies installed successfully." -ForegroundColor Green
    } catch {
        Write-Host "Failed to install dependencies from requirements.txt." -ForegroundColor Red
    }
} else {
    Write-Host "No requirements.txt found. Creating an empty one..."
    try {
        New-Item -Path "requirements.txt" -ItemType "File" -Force | Out-Null
        Write-Host "Empty requirements.txt created. Add your dependencies here." -ForegroundColor Yellow
    } catch {
        Write-Host "Failed to create requirements.txt." -ForegroundColor Red
    }
}

Write-Host "Virtual environment setup complete!" -ForegroundColor Green
