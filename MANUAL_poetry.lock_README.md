# 🎓 **POETRY BEGINNER'S TRAINING MANUAL**
## Complete Guide from Zero to Poetry Expert

> **📝 IMPORTANT:** This template's default scripts use pip for simplicity. This manual is for users who want to learn Poetry for professional development workflows.

---

## **🤔 What is Poetry and Why Should I Care?**

### **Poetry in Simple Terms**
Poetry is like a **smart assistant** for managing Python packages that:
- 📦 Installs packages for you
- 🔒 Remembers EXACT versions that work
- 🏗️ Creates isolated environments 
- 📋 Keeps track of what you need vs what you're testing

### **Real-World Analogy: Building a House**
- **pip** = Buying materials as needed ("give me some nails")
- **Poetry** = Complete blueprint + supplier contracts ("exactly 2.5-inch galvanized nails from Home Depot, ordered Jan 15, 2024")

**Result:** With Poetry, you can rebuild the EXACT same house anywhere!

---

## **📚 LESSON 1: Understanding the Files**

### **pyproject.toml - Your Shopping List**
```toml
[project]
dependencies = [
    "requests>=2.25.0",  # "I need requests, version 2.25 or newer"
    "pandas>=1.3.0",     # "I need pandas, version 1.3 or newer"
]
```
**Translation:** "I need these packages, any recent version is fine"

### **poetry.lock - Your Exact Receipt**
```toml
[[package]]
name = "requests"
version = "2.32.4"    # EXACTLY this version
category = "main"
description = "Python HTTP for Humans."

[[package]]
name = "pandas"
version = "2.3.1"     # EXACTLY this version
category = "main" 
description = "Powerful data structures for data analysis, time series, and statistics."
```
**Translation:** "I got exactly these versions and they work perfectly together"

### **Why Both Files?**
- **pyproject.toml** = What you want (flexible)
- **poetry.lock** = What actually works (exact)

---

## **📋 LESSON 2: Setting Up Poetry (First Time Only)**

### **Step 2.1: Check if Poetry is Already Installed**
**Copy and paste this:**
```powershell
poetry --version
```

**If you see a version number:** ✅ Skip to Lesson 3  
**If you see an error:** ⬇️ Continue with installation

### **Step 2.2: Install Poetry (Recommended Method)**
**Copy and paste this entire command:**
```powershell
(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | python -
```

**What this does:**
- Downloads the official Poetry installer
- Installs Poetry in an isolated location
- Avoids conflicts with your Python packages

### **Step 2.3: Restart Your Terminal**
Close and reopen your terminal (or VS Code) to refresh the PATH.

### **Step 2.4: Verify Installation**
**Copy and paste this:**
```powershell
poetry --version
```
You should see something like `Poetry (version 1.8.3)`

### **Step 2.5: Configure Poetry (Optional but Recommended)**
**Copy and paste these one by one:**
```powershell
# Create virtual environments inside project folders (easier to find)
poetry config virtualenvs.in-project true

# Show configuration
poetry config --list
```

---

## **🚀 LESSON 3: Your First Poetry Project**

### **Step 3.1: Navigate to Your Cloned Template**
```powershell
cd path\to\your\Web-Portfolios-Assistant
```

### **Step 3.2: Check What Poetry Sees**
**Copy and paste this:**
```powershell
poetry show
```

**What you'll see:**
- List of currently installed packages
- Or "No dependencies to install" if starting fresh

### **Step 3.3: Install Everything from poetry.lock**
**Copy and paste this:**
```powershell
poetry install
```

**What happens:**
- Poetry reads poetry.lock
- Downloads EXACT versions listed there
- Creates a virtual environment (.venv folder)
- Installs everything into that environment

**Success indicators:**
- No error messages
- Sees "Installing dependencies from lock file"
- Final message like "Installing the current project"

---

## **🔧 LESSON 4: Daily Poetry Commands**

### **4.1 Activating Your Poetry Environment**

**Method 1: Poetry Shell (Recommended for beginners)**
```powershell
poetry shell
```
**Success indicator:** Your prompt changes to show `(Web-Portfolios-Assistant-py3.x)`

**Method 2: Run Commands Individually**
```powershell
poetry run python --version
poetry run python src/main.py
poetry run pip list
```

### **4.2 Installing New Packages**

**Add a production package:**
```powershell
poetry add requests
```

**Add a development-only package:**
```powershell
poetry add --group dev pytest
```

**Add a package with specific version:**
```powershell
poetry add "pandas>=2.0.0,<3.0.0"
```

**Real example - add a web scraping library:**
```powershell
poetry add beautifulsoup4
```

### **4.3 Removing Packages**
```powershell
poetry remove beautifulsoup4
```

### **4.4 Updating Packages**

**Update all packages to latest compatible versions:**
```powershell
poetry update
```

**Update just one package:**
```powershell
poetry update pandas
```

**Check what would be updated (without actually updating):**
```powershell
poetry show --outdated
```

---

## **📋 LESSON 5: Understanding What Poetry Does**

### **5.1 Before and After Adding a Package**

**Before adding requests:**
```powershell
poetry show
# Shows current packages
```

**Add requests:**
```powershell
poetry add requests
```

**After adding requests:**
```powershell
poetry show
# Now shows requests + all its dependencies
```

**Check what changed in files:**
- pyproject.toml gets `requests = "^2.32.4"` added
- poetry.lock gets 50+ lines detailing exact versions

### **5.2 The Dependency Tree**
```powershell
poetry show --tree
```

**Example output:**
```
requests 2.32.4 Python HTTP for Humans.
├── certifi >=2017.4.17
├── charset-normalizer >=2,<4
├── idna >=2.5,<4
└── urllib3 >=1.21.1,<3
```

**Translation:** "requests needs these 4 other packages to work"

---

## **🎯 LESSON 6: Poetry vs Template Scripts**

### **6.1 Template Scripts (What You've Been Using)**

**Installing dependencies:**
```powershell
.\scripts\install_dependencies.ps1
```
**What it does:** Uses pip, gets "latest compatible versions"

**Poetry equivalent:**
```powershell
poetry install
```
**What it does:** Uses poetry.lock, gets "exact recorded versions"

### **6.2 Adding New Dependencies**

**Template script way:**
```powershell
pip install new-package
.\scripts\sync_environment.ps1  # Updates pyproject.toml
```

**Poetry way:**
```powershell
poetry add new-package  # Updates both pyproject.toml AND poetry.lock
```

### **6.3 Which Should You Use?**

**Keep using template scripts if:**
- ✅ You're learning Python
- ✅ Working alone on simple projects  
- ✅ Don't need exact reproducibility

**Switch to Poetry if:**
- 🎯 Working with a team
- 🎯 Deploying to production servers
- 🎯 Need guaranteed identical environments
- 🎯 Managing complex dependency relationships

---

## **🔍 LESSON 7: Practical Examples**

### **Example 1: Adding Data Science Packages**
```powershell
# Add data science stack
poetry add pandas numpy matplotlib seaborn

# Add development tools  
poetry add --group dev jupyter notebook

# Check what was installed
poetry show
```

### **Example 2: Web Development Stack**
```powershell
# Add web framework
poetry add fastapi uvicorn

# Add database tools
poetry add sqlalchemy psycopg2-binary

# Add testing tools
poetry add --group dev pytest pytest-asyncio
```

### **Example 3: Sharing Your Project**
```powershell
# Generate requirements.txt for pip users
poetry export -f requirements.txt --output requirements.txt

# Generate dev requirements
poetry export --group dev -f requirements.txt --output requirements-dev.txt
```

---

## **🚨 LESSON 8: Troubleshooting Common Issues**

### **8.1 "Poetry not found" Error**
**Problem:** Terminal doesn't recognize `poetry` command
**Solution:**
```powershell
# Reinstall Poetry
(Invoke-WebRequest -Uri https://install.python-poetry.org -UseBasicParsing).Content | python -

# Restart terminal
# Try again
poetry --version
```

### **8.2 Virtual Environment Issues**
**Problem:** Packages not found or wrong Python version
**Solution:**
```powershell
# Check which Python Poetry is using
poetry env info

# Remove current environment
poetry env remove python

# Recreate with correct Python version
poetry env use python3.11  # or your preferred version
poetry install
```

### **8.3 Lock File Conflicts**
**Problem:** poetry.lock appears corrupted or conflicts
**Solution:**
```powershell
# Delete lock file and regenerate
Remove-Item poetry.lock
poetry install
```

### **8.4 Dependency Conflicts**
**Problem:** Package A needs version 1.x but Package B needs 2.x
**Solution:**
```powershell
# Check what's conflicting
poetry show --tree

# Try updating everything
poetry update

# If still conflicts, may need to remove one package
poetry remove problematic-package
```

---

## **📊 LESSON 9: Poetry Commands Quick Reference**

### **Environment Commands**
| Command | What It Does | When to Use |
|---------|-------------|-------------|
| `poetry shell` | Activate virtual environment | Start working on project |
| `poetry env info` | Show environment details | Debug environment issues |
| `poetry env list` | List all environments | See what environments exist |

### **Package Commands**
| Command | What It Does | When to Use |
|---------|-------------|-------------|
| `poetry install` | Install all dependencies | First setup, after git pull |
| `poetry add pkg` | Add new package | Need new functionality |
| `poetry remove pkg` | Remove package | No longer need it |
| `poetry update` | Update all packages | Monthly maintenance |

### **Information Commands**
| Command | What It Does | When to Use |
|---------|-------------|-------------|
| `poetry show` | List installed packages | See what's installed |
| `poetry show --tree` | Show dependency relationships | Understand dependencies |
| `poetry show --outdated` | Show packages with updates | Before updating |

---

## **💡 LESSON 10: Best Practices**

### **10.1 Daily Workflow with Poetry**
```powershell
# Start of day
cd your-project
poetry shell

# Work on code...

# Add new package if needed
poetry add new-package

# Run your code
poetry run python src/main.py

# Run tests
poetry run pytest

# End of day - commit changes
# git add pyproject.toml poetry.lock
# git commit -m "Added new-package dependency"
```

### **10.2 Team Collaboration**
```powershell
# When you pull changes from git
git pull
poetry install  # Install any new dependencies

# Before pushing your changes
poetry show    # Review what's installed
# git add pyproject.toml poetry.lock
# git commit -m "Updated dependencies"
```

### **10.3 File Management**
- ✅ **Commit to git:** pyproject.toml, poetry.lock
- ❌ **Don't commit:** .venv/ folder (too large)
- ✅ **Keep updated:** Run `poetry update` monthly
- ❌ **Don't edit manually:** Let Poetry manage poetry.lock

---

## **🎯 LESSON 11: Migration from Template Scripts**

### **If You Decide to Switch to Poetry**

**Step 1: Backup Current Setup**
```powershell
# Create backup of current state
cp pyproject.toml pyproject.toml.backup
```

**Step 2: Let Poetry Take Over**
```powershell
# Poetry reads your existing pyproject.toml
poetry install
```

**Step 3: Test Everything Still Works**
```powershell
poetry run python src/main.py
poetry run pytest
```

**Step 4: Stop Using Template Scripts**
- Instead of `.\scripts\install_dependencies.ps1` → use `poetry install`
- Instead of `.\scripts\sync_environment.ps1` → use `poetry add package-name`

**Step 5: Update Your Workflow**
Use Poetry commands from this manual going forward.

---

## **📋 LESSON 12: When NOT to Use Poetry**

### **Stick with Template Scripts When:**
- 🎯 **Learning Python** - Keep things simple
- 🎯 **Quick prototypes** - Don't need reproducibility  
- 🎯 **Corporate restrictions** - Poetry not approved
- 🎯 **CI/CD limitations** - Existing pipelines use pip
- 🎯 **Simple projects** - Single developer, no deployment

### **Use Poetry When:**
- 🚀 **Team development** - Multiple developers
- 🚀 **Production deployment** - Need exact environments
- 🚀 **Complex dependencies** - Many packages with conflicts
- 🚀 **Professional projects** - Industry standard approach
- 🚀 **Long-term maintenance** - Project will evolve over time

---

## **🎉 Congratulations! You're Now a Poetry Beginner!**

### **What You've Learned:**
✅ What Poetry is and why it exists  
✅ How to install and configure Poetry  
✅ How to use Poetry in your daily workflow  
✅ How Poetry compares to the template scripts  
✅ When to use Poetry vs pip  
✅ How to troubleshoot common issues  
✅ Best practices for team collaboration  

### **Next Steps:**
1. **Practice:** Try adding and removing packages with Poetry
2. **Experiment:** Create a small test project using Poetry
3. **Decide:** Choose Poetry or template scripts for your real projects
4. **Learn more:** Check Poetry documentation at https://python-poetry.org/

### **Remember:**
- Both approaches (Poetry and template scripts) are valid
- Choose the one that fits your needs and experience level
- You can always switch later as your projects grow more complex

**Happy coding with your new Poetry knowledge!** 🐍✨

---

## **📞 Need More Help?**

- **Poetry Documentation:** https://python-poetry.org/docs/
- **Template Script Issues:** Check `scripts\README.md`
- **Python Environment Problems:** Verify Python 3.11+ installation
- **Team Setup Questions:** Use this manual as your training guide

**You now have the knowledge to make informed decisions about Python dependency management!** 🎓
