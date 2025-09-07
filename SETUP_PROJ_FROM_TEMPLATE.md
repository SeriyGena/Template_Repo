# 🚀 **POST-CLONE SETUP GUIDE FOR BEGINNERS**

> **📝 INFO: This guide assumes you have already cloned the template repository. If you haven't done this yet, run:**
> ```powershell
> git clone https://github.com/SeriyGena/Web-Portfolios-Assistant.git my-new-project
> cd my-new-project
> ```

---

## **🎯 What This Guide Will Help You Do**

After cloning the template, this guide will help you:
1. ✅ Set up a Python virtual environment (.venv) 
2. ✅ Convert the template into your personal project
3. ✅ Install all necessary dependencies  
4. ✅ Configure VS Code for professional development
5. ✅ Resolve common setup issues

**Time needed: 5-10 minutes**

---

## **📋 STEP 1: One-Time Prerequisites**

Before starting, make sure you have these installed on your computer:

### **1.1 Python 3.11 or Higher**
**Copy and paste this into your terminal to check:**
```powershell
python --version
```
You should see something like `Python 3.11.x` or higher. If not:
- Download from: https://www.python.org/downloads/
- Install Python 3.11 or newer
- Restart your terminal

### **1.2 Enable PowerShell Script Execution (One-time setup)**
**Copy and paste this into your terminal:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```
- Type `Y` and press Enter if prompted
- This allows running the project setup scripts
- **Note:** This setting is preserved after PC reboot

### **1.3 Install VS Code Extensions (Optional but Recommended)**
**Copy and paste this into your terminal:**
```powershell
Get-Content .vscode\extensions.json | ConvertFrom-Json | ForEach-Object { $_.recommendations | ForEach-Object { code --install-extension $_ } }
```
This installs 11 essential extensions for Python development.

---

## **📦 STEP 2: Create Python Virtual Environment**

### **2.1 Check Available Python Versions**
**Copy and paste this:**
```powershell
py -0
```
This shows all Python versions installed on your computer.

### **2.2 Create Virtual Environment with Your Preferred Version**
**Replace `3.13` with your preferred version and copy:**
```powershell
py -3.13 -m venv .venv
```
**Examples for different versions:**
- For Python 3.11: `py -3.11 -m venv .venv`
- For Python 3.12: `py -3.12 -m venv .venv`  
- For Python 3.13: `py -3.13 -m venv .venv`

### **2.3 Activate the Virtual Environment**
**Copy and paste this:**
```powershell
.venv\Scripts\Activate
```
**Success indicator:** Your terminal prompt should now show `(.venv)` at the beginning.

---

## **⚙️ STEP 3: Convert Template to Your Project**

### **3.1 Run the Conversion Script**
**Replace "my-project-name" with your actual project name and copy:**
```powershell
.\scripts\change_from_template_to_project.ps1 -ProjectName "my-project-name"
```

**Real example:**
```powershell
.\scripts\change_from_template_to_project.ps1 -ProjectName "Web-Portfolios-Assistant"
```

**What this does:**
- Replaces template placeholders with your project name
- Updates author information in pyproject.toml
- Creates VS Code workspace file
- Personalizes all template files

---

## **📥 STEP 4: Install Project Dependencies**

### **4.1 Install All Dependencies in Development Mode**
**Copy and paste this (make sure .venv is activated):**
```powershell
pip install -e .[dev]
```

**Important notes:**
- The space between `-e` and `.[dev]` is required
- The dot (.) refers to the current directory
- `[dev]` includes both production and development packages

### **4.2 Common Issues and Solutions**

**If you see "authors must be object" error:**
The pyproject.toml file should be automatically fixed during conversion. If not:
```powershell
# The authors line should look like this:
# authors = [{name = "Your Name", email = "your.email@example.com"}]
# not like this:
# authors = ["Your Name <your.email@example.com>"]
```

**If you see dependency conflicts with dulwich/findpython:**
```powershell
pip install --upgrade dulwich findpython
```

**If Poetry conflicts appear:**
You can ignore them if using pip, or upgrade Poetry:
```powershell
pip uninstall poetry
(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | python -
```

---

## **🔍 STEP 5: Verify Installation**

### **5.1 Check That Everything Works**
**Copy and paste these commands one by one:**

```powershell
# Check Python version in virtual environment
python --version

# Check if your project is installed
pip list | findstr shared-utilities

# Test import (should not show errors)
python -c "import src; print('Project setup successful!')"
```

### **5.2 Open in VS Code**
**Copy and paste this:**
```powershell
code .
```

---

## **🐍 Quick Reference: Virtual Environment Commands**

**Activate virtual environment:**
```powershell
.venv\Scripts\Activate
```

**Deactivate virtual environment:**
```powershell
deactivate
```

**Check if you're in virtual environment:**
Look for `(.venv)` at the start of your terminal prompt.

**Recreate virtual environment if needed:**
```powershell
Remove-Item -Recurse -Force .venv
py -3.13 -m venv .venv
.venv\Scripts\Activate
pip install -e .[dev]
```

---

## **🚨 Troubleshooting Common Issues**

### **PowerShell Execution Policy Error**
**Error:** "cannot be loaded because running scripts is disabled"
**Solution:**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### **Python Version Issues**
**Error:** Dependencies not installing or "requires Python >=3.11"
**Solution:**
1. Check your Python version: `python --version`
2. If below 3.11, download from https://www.python.org/downloads/
3. Recreate .venv with newer Python version

### **Virtual Environment Not Working**
**Error:** Commands not found or pip installing globally
**Solution:**
1. Make sure you see `(.venv)` in your terminal prompt
2. If not, run: `.venv\Scripts\Activate`
3. If still not working, recreate .venv (see Quick Reference above)

### **Dependencies Not Installing**
**Error:** Various pip or dependency errors
**Solution:**
```powershell
# Make sure you're in the right directory
Get-Location  # Should show your project folder

# Make sure .venv is activated
.venv\Scripts\Activate

# Try upgrading pip first
python -m pip install --upgrade pip

# Then install your project
pip install -e .[dev]
```

### **VS Code Not Recognizing Python Environment**
**Issue:** VS Code using wrong Python interpreter
**Solution:**
1. Press `Ctrl+Shift+P`
2. Type "Python: Select Interpreter"
3. Choose the one in your `.venv\Scripts\python.exe`

---

## **📁 What You'll Have After Setup**

```
🌟 YOUR_PROJECT/
├── .venv/                       # Your isolated Python environment
├── src/
│   ├── __init__.py              # Your project package
│   └── main.py                  # Your main entry point
├── test/
│   ├── __init__.py              # Test package
│   └── test_your_project.py     # Your project tests
├── scripts/
│   ├── change_from_template_to_project.ps1  # Conversion script (used once)
│   ├── install_dependencies.ps1             # Dependency installer
│   └── sync_environment.ps1                 # Environment checker
├── .vscode/
│   ├── extensions.json          # 11 essential extensions
│   ├── launch.json              # 8 debug configurations
│   └── settings.json            # Production settings
├── your_project.code-workspace  # VS Code workspace
├── pyproject.toml               # Your project configuration
├── README.md                    # Your project documentation
├── .gitignore                   # Python gitignore
└── LICENSE                      # MIT License
```

---

## **🔄 Daily Development Workflow**

### **Starting Work Each Day**
```powershell
# Navigate to your project
cd path\to\your\project

# Activate virtual environment
.venv\Scripts\Activate

# Open VS Code
code .
```

### **Adding New Dependencies**
```powershell
# Install new package
pip install new-package

# Add to project configuration (optional but recommended)
.\scripts\sync_environment.ps1
```

### **Testing & Quality Checks**
```powershell
# Run tests
python -m pytest

# Format code
python -m black src/ test/

# Check code quality
python -m flake8 src/ test/

# Type checking
python -m mypy src/
```

---

## **🎉 Success! You Now Have:**

✅ **Isolated Python environment** (.venv with your chosen Python version)  
✅ **Professional development setup** (VS Code + extensions)  
✅ **Your personalized project** (converted from template)  
✅ **All dependencies installed** (production + development tools)  
✅ **Quality tools configured** (Black, Flake8, MyPy, pytest)  
✅ **Ready-to-use project structure** 

**Start coding immediately - your professional Python development environment is ready!** 🎉

---

## **📞 Need More Help?**

- **Script Details**: Check `scripts\README.md` for detailed script documentation
- **VS Code Problems**: Press `F1` and type "Python: Select Interpreter"
- **Python Issues**: Verify Python 3.11+ installation at https://www.python.org/downloads/
- **Dependency Issues**: Make sure `.venv` is activated and try upgrading pip

**Happy coding with your new professional Python development environment!** 🐍✨
