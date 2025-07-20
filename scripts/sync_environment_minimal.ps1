# Sync current environment packages to pyproject.toml
# Works with both Poetry and pip
# Run from project root: .\scripts\sync_environment_minimal.ps1

Write-Host "Syncing environment packages to pyproject.toml..."

# Check if pyproject.toml exists
if (-not (Test-Path "pyproject.toml")) {
    Write-Host "Error: pyproject.toml not found in current directory."
    exit 1
}

# Get current packages
Write-Host "Scanning current environment..."
$installedPackages = python -m pip list --format=freeze | Where-Object { 
    $_ -notmatch "^pip" -and 
    $_ -notmatch "^setuptools" -and 
    $_ -notmatch "^wheel" -and
    $_ -notmatch "^poetry" -and
    $_ -ne ""
}

if (-not $installedPackages) {
    Write-Host "No packages found in environment."
    exit 0
}

Write-Host "Found packages:"
$installedPackages | ForEach-Object { Write-Host "  - $_" }

$confirm = Read-Host "Add these packages to pyproject.toml? (y/n)"
if ($confirm -ne "y" -and $confirm -ne "Y") {
    Write-Host "Cancelled."
    exit 0
}

# Check for Poetry
$usePoetry = $false
try {
    poetry --version | Out-Null
    $usePoetry = $true
} catch {
    # Poetry not available
}

if ($usePoetry) {
    # Use Poetry to add packages
    Write-Host "Using Poetry to add packages..."
    foreach ($package in $installedPackages) {
        $packageName = ($package -split "==")[0]
        Write-Host "Adding: $packageName"
        poetry add $packageName
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Warning: Failed to add $packageName"
        }
    }
} else {
    # Manual update of pyproject.toml
    Write-Host "Updating pyproject.toml manually..."
    
    # Read current pyproject.toml
    $content = Get-Content "pyproject.toml" -Raw
    
    # Extract package names and versions
    $dependencies = @()
    foreach ($package in $installedPackages) {
        $parts = $package -split "=="
        $name = $parts[0]
        $version = $parts[1]
        $dependencies += "`"$name>=$version`""
    }
    
    # Update dependencies section
    $dependencyString = $dependencies -join ",`n    "
    
    if ($content -match '(?s)dependencies\s*=\s*\[(.*?)\]') {
        $newDeps = "dependencies = [`n    $dependencyString`n]"
        $content = $content -replace '(?s)dependencies\s*=\s*\[.*?\]', $newDeps
    } else {
        Write-Host "Could not find dependencies section in pyproject.toml"
        exit 1
    }
    
    # Write back to file
    $content | Set-Content "pyproject.toml" -NoNewline
}

Write-Host "✅ Environment sync completed!"
Write-Host "💡 Run .\scripts\install_dependencies.ps1 to install in a fresh environment."
