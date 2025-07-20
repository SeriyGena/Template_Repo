# Install dependencies from pyproject.toml
# Works with both Poetry and pip
# Run from project root: .\scripts\install_dependencies.ps1

Write-Host "Installing dependencies from pyproject.toml..."

# Check if pyproject.toml exists
if (-not (Test-Path "pyproject.toml")) {
    Write-Host "Error: pyproject.toml not found in current directory."
    exit 1
}

# Check Python version
$pythonVersion = & python --version 2>&1
if ($pythonVersion -match "Python (\d+)\.(\d+)") {
    $major = [int]$matches[1]
    $minor = [int]$matches[2]
    if ($major -lt 3 -or ($major -eq 3 -and $minor -lt 11)) {
        Write-Host "Error: Python 3.11+ required. Current: $pythonVersion"
        exit 1
    }
} else {
    Write-Host "Error: Could not determine Python version."
    exit 1
}

# Try Poetry first, fallback to pip
$usePoetry = $false
try {
    poetry --version | Out-Null
    $usePoetry = $true
    Write-Host "Using Poetry for dependency management..."
} catch {
    Write-Host "Poetry not found. Using pip..."
}

if ($usePoetry) {
    # Use Poetry
    Write-Host "Installing with Poetry..."
    poetry install
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Dependencies installed successfully with Poetry."
    } else {
        Write-Host "❌ Poetry install failed."
        exit 1
    }
} else {
    # Use pip with pyproject.toml
    Write-Host "Installing with pip..."
    python -m pip install -e .
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Dependencies installed successfully with pip."
    } else {
        Write-Host "❌ Pip install failed."
        exit 1
    }
    
    # Install dev dependencies if available
    Write-Host "Installing dev dependencies..."
    python -m pip install -e ".[dev]" 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Dev dependencies installed."
    } else {
        Write-Host "ℹ️  No dev dependencies or install failed."
    }
}
