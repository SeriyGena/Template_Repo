# Template Conversion Script
# ========================
# Run this ONCE after cloning the template from GitHub
# This script converts template files to project files and configures your workspace
# 
# Usage: .\scripts\change_from_template_to_project.ps1 -ProjectName "MyProject"
#
# Requirements:
# - Run from project root directory
# - PowerShell 5.1+ or PowerShell Core
# - Template files (*_minimal) must exist

param(
    [Parameter(Mandatory=$true, HelpMessage="Project name (letters, numbers, underscore, hyphen only)")]
    [string]$ProjectName,
    
    [Parameter(Mandatory=$false, HelpMessage="Author full name")]
    [string]$AuthorName = "Your Name",
    
    [Parameter(Mandatory=$false, HelpMessage="Author email address")]
    [string]$AuthorEmail = "your.email@example.com",
    
    [Parameter(Mandatory=$false, HelpMessage="Project description")]
    [string]$Description = ""
)

# Display banner
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  Python Project Template Converter v1.0" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Converting template to project: $ProjectName" -ForegroundColor Green
Write-Host "Author: $AuthorName <$AuthorEmail>" -ForegroundColor Yellow
if ($Description) {
    Write-Host "Description: $Description" -ForegroundColor Yellow
}
Write-Host ""

# Validate project name
if ($ProjectName -notmatch '^[a-zA-Z][a-zA-Z0-9_-]*$') {
    Write-Host "ERROR: Project name must:" -ForegroundColor Red
    Write-Host "  - Start with a letter" -ForegroundColor Red
    Write-Host "  - Contain only letters, numbers, underscore, or hyphen" -ForegroundColor Red
    Write-Host "  - Example: MyProject, my_project, project-1" -ForegroundColor Red
    exit 1
}

# Validate we're in the right directory
if (-not (Test-Path "pyproject.toml") -or -not (Test-Path "scripts")) {
    Write-Host "ERROR: Please run this script from the project root directory." -ForegroundColor Red
    Write-Host "Expected files: pyproject.toml, scripts/ folder" -ForegroundColor Red
    exit 1
}

# Check if template files exist
$templateFiles = @(
    "scripts\install_dependencies_minimal.ps1",
    "scripts\sync_environment_minimal.ps1",
    "src\__init___minimal.py",
    "src\main_minimal.py"
)

$missingFiles = @()
foreach ($file in $templateFiles) {
    if (-not (Test-Path $file)) {
        $missingFiles += $file
    }
}

if ($missingFiles.Count -gt 0) {
    Write-Host "WARNING: Some template files are missing:" -ForegroundColor Yellow
    foreach ($file in $missingFiles) {
        Write-Host "  - $file" -ForegroundColor Yellow
    }
    $continue = Read-Host "Continue anyway? (y/n)"
    if ($continue -ne "y" -and $continue -ne "Y") {
        Write-Host "Conversion cancelled." -ForegroundColor Yellow
        exit 0
    }
}

Write-Host "STEP 1: Converting script files..." -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan

# Convert script files with better error handling
$scriptConversions = @{
    "scripts\install_dependencies_minimal.ps1" = "scripts\install_dependencies.ps1"
    "scripts\sync_environment_minimal.ps1" = "scripts\sync_environment.ps1"
}

foreach ($oldFile in $scriptConversions.Keys) {
    $newFile = $scriptConversions[$oldFile]
    if (Test-Path $oldFile) {
        try {
            # Remove existing file if it exists
            if (Test-Path $newFile) {
                Remove-Item $newFile -Force
            }
            # Use Copy-Item instead of Rename-Item for better reliability
            Copy-Item $oldFile $newFile -Force
            Write-Host "  SUCCESS: $oldFile -> $newFile" -ForegroundColor Green
        }
        catch {
            Write-Host "  ERROR: Failed to convert $oldFile" -ForegroundColor Red
            Write-Host "    $_" -ForegroundColor Red
        }
    } else {
        Write-Host "  SKIP: $oldFile (not found)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "STEP 2: Converting source files..." -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan

# Convert source files
$sourceConversions = @{
    "src\__init___minimal.py" = "src\__init__.py"
    "src\main_minimal.py" = "src\main.py"
}

foreach ($oldFile in $sourceConversions.Keys) {
    $newFile = $sourceConversions[$oldFile]
    if (Test-Path $oldFile) {
        try {
            if (Test-Path $newFile) {
                Remove-Item $newFile -Force
            }
            Copy-Item $oldFile $newFile -Force
            Write-Host "  SUCCESS: $oldFile -> $newFile" -ForegroundColor Green
        }
        catch {
            Write-Host "  ERROR: Failed to convert $oldFile" -ForegroundColor Red
            Write-Host "    $_" -ForegroundColor Red
        }
    } else {
        Write-Host "  SKIP: $oldFile (not found)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "STEP 3: Converting configuration files..." -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# Convert main configuration files
$configConversions = @{
    "pyproject_minimal.toml" = "pyproject.toml"
    "README_TEMPLATE.md" = "README.md"
    ".gitignore_minimal" = ".gitignore"
}

foreach ($oldFile in $configConversions.Keys) {
    $newFile = $configConversions[$oldFile]
    if (Test-Path $oldFile) {
        try {
            if (Test-Path $newFile) {
                Remove-Item $newFile -Force
            }
            Copy-Item $oldFile $newFile -Force
            Write-Host "  SUCCESS: $oldFile -> $newFile" -ForegroundColor Green
        }
        catch {
            Write-Host "  ERROR: Failed to convert $oldFile" -ForegroundColor Red
            Write-Host "    $_" -ForegroundColor Red
        }
    } else {
        Write-Host "  SKIP: $oldFile (not found)" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "STEP 4: Converting VS Code configuration..." -ForegroundColor Cyan
Write-Host "===========================================" -ForegroundColor Cyan

# Convert VS Code files
$vscodeConversions = @{
    ".vscode\extensions_minimal.json" = ".vscode\extensions.json"
    ".vscode\launch_minimal.json" = ".vscode\launch.json"
    ".vscode\settings_minimal.json" = ".vscode\settings.json"
}

foreach ($oldFile in $vscodeConversions.Keys) {
    $newFile = $vscodeConversions[$oldFile]
    if (Test-Path $oldFile) {
        try {
            if (Test-Path $newFile) {
                Remove-Item $newFile -Force
            }
            Copy-Item $oldFile $newFile -Force
            Write-Host "  SUCCESS: $oldFile -> $newFile" -ForegroundColor Green
        }
        catch {
            Write-Host "  ERROR: Failed to convert $oldFile" -ForegroundColor Red
            Write-Host "    $_" -ForegroundColor Red
        }
    } else {
        Write-Host "  SKIP: $oldFile (not found)" -ForegroundColor Yellow
    }
}

# Convert Copilot configuration
if (Test-Path ".copilot\promts_minimal.md") {
    try {
        if (Test-Path ".copilot\promts.md") {
            Remove-Item ".copilot\promts.md" -Force
        }
        Copy-Item ".copilot\promts_minimal.md" ".copilot\promts.md" -Force
        Write-Host "  SUCCESS: .copilot\promts_minimal.md -> .copilot\promts.md" -ForegroundColor Green
    }
    catch {
        Write-Host "  ERROR: Failed to convert Copilot prompts" -ForegroundColor Red
        Write-Host "    $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "STEP 5: Updating project metadata..." -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan

# Update pyproject.toml with project details
if (Test-Path "pyproject.toml") {
    try {
        $content = Get-Content "pyproject.toml" -Raw -Encoding UTF8
        
        # Update project name (convert to lowercase for Python package naming)
        $pythonName = $ProjectName.ToLower() -replace '[^a-z0-9_]', '_'
        $content = $content -replace 'name = "project_template"', "name = `"$pythonName`""
        
        # Update description if provided
        if ($Description) {
            $content = $content -replace 'description = "Minimal Python project template"', "description = `"$Description`""
        }
        
        # Update author info
        $content = $content -replace 'name = "Your Name"', "name = `"$AuthorName`""
        $content = $content -replace 'email = "your.email@example.com"', "email = `"$AuthorEmail`""
        
        $content | Set-Content "pyproject.toml" -NoNewline -Encoding UTF8
        Write-Host "  SUCCESS: Updated pyproject.toml" -ForegroundColor Green
        Write-Host "    - Project name: $pythonName" -ForegroundColor Gray
        Write-Host "    - Author: $AuthorName <$AuthorEmail>" -ForegroundColor Gray
        if ($Description) {
            Write-Host "    - Description: $Description" -ForegroundColor Gray
        }
    }
    catch {
        Write-Host "  ERROR: Failed to update pyproject.toml" -ForegroundColor Red
        Write-Host "    $_" -ForegroundColor Red
    }
}

# Update __init__.py with project details
if (Test-Path "src\__init__.py") {
    try {
        $content = Get-Content "src\__init__.py" -Raw -Encoding UTF8
        
        # Update author info
        $content = $content -replace '__author__ = "Your Name"', "__author__ = `"$AuthorName`""
        $content = $content -replace '__email__ = "your.email@example.com"', "__email__ = `"$AuthorEmail`""
        
        # Update description if provided
        if ($Description) {
            $content = $content -replace 'Minimal Python Project Template', $Description
        }
        
        $content | Set-Content "src\__init__.py" -NoNewline -Encoding UTF8
        Write-Host "  SUCCESS: Updated src\__init__.py" -ForegroundColor Green
    }
    catch {
        Write-Host "  ERROR: Failed to update src\__init__.py" -ForegroundColor Red
        Write-Host "    $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "STEP 6: Cleaning up template files..." -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

# Remove template-specific files (optional step)
$templateCleanup = @(
    "scripts\change_from_template_to_project.ps1"  # This script itself
)

Write-Host "  INFO: Template cleanup files:" -ForegroundColor Yellow
foreach ($file in $templateCleanup) {
    Write-Host "    - $file" -ForegroundColor Yellow
}

$cleanup = Read-Host "Remove template conversion script? (y/n) [recommended: y]"
if ($cleanup -eq "y" -or $cleanup -eq "Y") {
    foreach ($file in $templateCleanup) {
        if (Test-Path $file) {
            try {
                Remove-Item $file -Force
                Write-Host "  SUCCESS: Removed $file" -ForegroundColor Green
            }
            catch {
                Write-Host "  ERROR: Failed to remove $file" -ForegroundColor Red
                Write-Host "    $_" -ForegroundColor Red
            }
        }
    }
} else {
    Write-Host "  SKIP: Keeping template files for future use" -ForegroundColor Yellow
}

# Final summary
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  TEMPLATE CONVERSION COMPLETED!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Project Details:" -ForegroundColor Yellow
Write-Host "  Name: $ProjectName" -ForegroundColor White
Write-Host "  Python Package: $($ProjectName.ToLower() -replace '[^a-z0-9_]', '_')" -ForegroundColor White
Write-Host "  Author: $AuthorName <$AuthorEmail>" -ForegroundColor White
if ($Description) {
    Write-Host "  Description: $Description" -ForegroundColor White
}
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "  1. Reload VS Code to apply new settings and extensions" -ForegroundColor White
Write-Host "  2. Install dependencies: .\scripts\install_dependencies.ps1" -ForegroundColor White
Write-Host "  3. Review and customize src\main.py for your project" -ForegroundColor White
Write-Host "  4. Start coding in the src\ directory" -ForegroundColor White
Write-Host "  5. Use .\scripts\sync_environment.ps1 to add new packages" -ForegroundColor White
Write-Host ""
Write-Host "Happy coding with $ProjectName!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
