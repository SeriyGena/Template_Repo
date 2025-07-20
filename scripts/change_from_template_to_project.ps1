# Script to convert template files to project files
# Run this ONCE after cloning the template from GitHub
# This script will rename *_minimal files and update project configuration
# Run from project root: .\scripts\change_from_template_to_project.ps1

param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectName,
    
    [Parameter(Mandatory=$false)]
    [string]$AuthorName = "Your Name",
    
    [Parameter(Mandatory=$false)]
    [string]$AuthorEmail = "your.email@example.com",
    
    [Parameter(Mandatory=$false)]
    [string]$Description = ""
)

Write-Host "🚀 Converting template to project: $ProjectName" -ForegroundColor Green
Write-Host "Author: $AuthorName <$AuthorEmail>"

# Validate project name
if ($ProjectName -notmatch '^[a-zA-Z][a-zA-Z0-9_-]*$') {
    Write-Host "❌ Error: Project name must start with a letter and contain only letters, numbers, underscore, or hyphen." -ForegroundColor Red
    exit 1
}

# Check if we're in the right directory
if (-not (Test-Path "pyproject.toml") -or -not (Test-Path "scripts")) {
    Write-Host "❌ Error: Please run this script from the project root directory." -ForegroundColor Red
    exit 1
}

# Check if conversion already done
if (-not (Test-Path "scripts\sync_environment_minimal.ps1")) {
    Write-Host "⚠️  Template appears to already be converted or files are missing." -ForegroundColor Yellow
    $continue = Read-Host "Continue anyway? (y/n)"
    if ($continue -ne "y" -and $continue -ne "Y") {
        Write-Host "Cancelled."
        exit 0
    }
}

Write-Host ""
Write-Host "📁 Step 1: Renaming template files..." -ForegroundColor Cyan

# Rename script files
$scriptRenames = @{
    "scripts\install_dependencies_minimal.ps1" = "scripts\install_dependencies.ps1"
    "scripts\sync_environment_minimal.ps1" = "scripts\sync_environment.ps1"
}

foreach ($oldFile in $scriptRenames.Keys) {
    $newFile = $scriptRenames[$oldFile]
    if (Test-Path $oldFile) {
        if (Test-Path $newFile) {
            Remove-Item $newFile -Force
        }
        Rename-Item $oldFile $newFile
        Write-Host "  ✅ $oldFile → $newFile"
    } else {
        Write-Host "  ⚠️  $oldFile not found"
    }
}

# Rename source files
$srcRenames = @{
    "src\__init___minimal.py" = "src\__init__.py"
    "src\main_minimal.py" = "src\main.py"
}

foreach ($oldFile in $srcRenames.Keys) {
    $newFile = $srcRenames[$oldFile]
    if (Test-Path $oldFile) {
        if (Test-Path $newFile) {
            Remove-Item $newFile -Force
        }
        Rename-Item $oldFile $newFile
        Write-Host "  ✅ $oldFile → $newFile"
    } else {
        Write-Host "  ⚠️  $oldFile not found"
    }
}

# Replace pyproject.toml with minimal version
if (Test-Path "pyproject_minimal.toml") {
    Remove-Item "pyproject.toml" -Force -ErrorAction SilentlyContinue
    Rename-Item "pyproject_minimal.toml" "pyproject.toml"
    Write-Host "  ✅ pyproject_minimal.toml → pyproject.toml"
}

# Replace README
if (Test-Path "README_TEMPLATE.md") {
    Remove-Item "README.md" -Force -ErrorAction SilentlyContinue
    Rename-Item "README_TEMPLATE.md" "README.md"
    Write-Host "  ✅ README_TEMPLATE.md → README.md"
}

# Replace .gitignore
if (Test-Path ".gitignore_minimal") {
    Remove-Item ".gitignore" -Force -ErrorAction SilentlyContinue
    Rename-Item ".gitignore_minimal" ".gitignore"
    Write-Host "  ✅ .gitignore_minimal → .gitignore"
}

# Replace VS Code extensions
if (Test-Path ".vscode\extensions_minimal.json") {
    Remove-Item ".vscode\extensions.json" -Force -ErrorAction SilentlyContinue
    Rename-Item ".vscode\extensions_minimal.json" ".vscode\extensions.json"
    Write-Host "  ✅ .vscode\extensions_minimal.json → .vscode\extensions.json"
}

# Replace VS Code launch configuration
if (Test-Path ".vscode\launch_minimal.json") {
    Remove-Item ".vscode\launch.json" -Force -ErrorAction SilentlyContinue
    Rename-Item ".vscode\launch_minimal.json" ".vscode\launch.json"
    Write-Host "  ✅ .vscode\launch_minimal.json → .vscode\launch.json"
}

# Replace VS Code settings
if (Test-Path ".vscode\settings_minimal.json") {
    Remove-Item ".vscode\settings.json" -Force -ErrorAction SilentlyContinue
    Rename-Item ".vscode\settings_minimal.json" ".vscode\settings.json"
    Write-Host "  ✅ .vscode\settings_minimal.json → .vscode\settings.json"
}

# Replace Copilot prompts
if (Test-Path ".copilot\promts_minimal.md") {
    Remove-Item ".copilot\promts.md" -Force -ErrorAction SilentlyContinue
    Rename-Item ".copilot\promts_minimal.md" ".copilot\promts.md"
    Write-Host "  ✅ .copilot\promts_minimal.md → .copilot\promts.md"
}

Write-Host ""
Write-Host "📝 Step 2: Updating project configuration..." -ForegroundColor Cyan

# Update pyproject.toml with project details
if (Test-Path "pyproject.toml") {
    $content = Get-Content "pyproject.toml" -Raw
    
    # Update project name
    $content = $content -replace 'name = "project_template"', "name = `"$($ProjectName.ToLower())`""
    
    # Update description if provided
    if ($Description) {
        $content = $content -replace 'description = "Minimal Python project template"', "description = `"$Description`""
    }
    
    # Update author info
    $content = $content -replace 'name = "Your Name"', "name = `"$AuthorName`""
    $content = $content -replace 'email = "your.email@example.com"', "email = `"$AuthorEmail`""
    
    $content | Set-Content "pyproject.toml" -NoNewline
    Write-Host "  ✅ Updated pyproject.toml with project details"
}

# Update __init__.py with project details
if (Test-Path "src\__init__.py") {
    $content = Get-Content "src\__init__.py" -Raw
    
    # Update author info
    $content = $content -replace '__author__ = "Your Name"', "__author__ = `"$AuthorName`""
    $content = $content -replace '__email__ = "your.email@example.com"', "__email__ = `"$AuthorEmail`""
    
    # Update description if provided
    if ($Description) {
        $content = $content -replace 'Minimal Python Project Template', $Description
    }
    
    $content | Set-Content "src\__init__.py" -NoNewline
    Write-Host "  ✅ Updated src\__init__.py with project details"
}

Write-Host ""
Write-Host "🗑️  Step 3: Cleaning up template files..." -ForegroundColor Cyan

# Remove template-specific files
$filesToRemove = @(
    "scripts\change_from_template_to_project.ps1"  # This script itself
)

foreach ($file in $filesToRemove) {
    if (Test-Path $file) {
        Remove-Item $file -Force
        Write-Host "  ✅ Removed $file"
    }
}

Write-Host ""
Write-Host "🎉 Template conversion complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📋 Next steps:" -ForegroundColor Yellow
Write-Host "  1. Review and customize src\main.py for your project needs"
Write-Host "  2. Install dependencies: .\scripts\install_dependencies.ps1"
Write-Host "  3. Start coding in the src\ directory"
Write-Host "  4. Add packages: .\scripts\sync_environment.ps1"
Write-Host ""
Write-Host "🚀 Happy coding with $ProjectName!" -ForegroundColor Green
