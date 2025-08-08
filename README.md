# Virtual Environment (venv) 

**Overview**  
This README explains everything you need to know about Python virtual environments using the built-in `venv` module: what a venv is, why to use it, how to create/activate/use it on **Windows** and **macOS / Linux**, how `pip` behaves inside a venv, dependency management, common pitfalls, and troubleshooting.

---

# Table of contents

* [About venv](#about-venv)  
* [Why use venv](#why-use-venv)  
* [Prerequisites](#prerequisites)  
* [Windows step-by-step](#windows-step-by-step)  
* [macOS and Linux step-by-step](#macos-and-linux-step-by-step)  
* [Commands summary](#commands-summary)  
* [How pip works inside a venv](#how-pip-works-inside-a-venv)  
* [Saving and restoring dependencies](#saving-and-restoring-dependencies)  
* [Using venv with VS Code](#using-venv-with-vs-code)  
* [Deactivate and delete venv](#deactivate-and-delete-venv)  
* [Common pitfalls and troubleshooting](#common-pitfalls-and-troubleshooting)  
* [Best practices](#best-practices)  
* [Git ignore example](#git-ignore-example)  
* [References](#references)  
* [Credits](#credits)

---

# About venv

`venv` is the built-in Python module (Python 3.3+) to create lightweight virtual environments. A venv provides an isolated Python interpreter and a separate `site-packages` folder so project dependencies do not conflict with each other or with the system Python.

---

# Why use venv

- Keep project dependencies separated and reproducible.  
- Avoid polluting system Python.  
- Test multiple dependency versions safely.  
- Make deployments and CI setups predictable.

---

# Prerequisites

- Python 3.6+ is recommended. Check your Python version:

```bash
python --version
# or, if your system uses `python3`:
python3 --version
````

* `pip` comes bundled with modern Python. To update pip:

```bash
python -m pip install --upgrade pip setuptools wheel
```

Use `python3` if your system requires it.

---

# Windows step-by-step

Open PowerShell, Command Prompt, or VS Code integrated terminal. Run these commands inside your project folder.

```powershell
# Create a virtual environment named .venv
python -m venv .venv

# Activate the venv (PowerShell)
.\.venv\Scripts\Activate

# or in Command Prompt (cmd)
.\.venv\Scripts\activate.bat

# Confirm Python and pip point to venv
python -V
python -m pip --version

# List installed packages (initially minimal)
pip list

# Upgrade pip inside venv (recommended)
python -m pip install --upgrade pip setuptools wheel

# Install packages (example)
python -m pip install django
python -m pip install flask

# Verify installed packages
pip list

# Freeze dependencies
pip freeze > requirements.txt

# When done, deactivate
deactivate
```

**PowerShell note:** If activating a script is blocked, run once as administrator:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

---

# macOS and Linux step-by-step

Open Terminal and run the commands inside your project folder.

```bash
# Create the virtual environment (.venv is recommended)
python3 -m venv .venv   # or `python -m venv .venv` depending on your system

# Activate the venv
source .venv/bin/activate

# Confirm Python and pip point to venv
python -V
python -m pip --version

# List installed packages (initially minimal)
pip list

# Upgrade pip inside venv
python -m pip install --upgrade pip setuptools wheel

# Install packages (example)
python -m pip install django
python -m pip install flask

# Verify installed packages
pip list

# Freeze dependencies
pip freeze > requirements.txt

# When done, deactivate
deactivate
```

---

# Commands summary

* Create venv:

  ```bash
  python -m venv .venv
  ```

  (Use `python3` if your system maps `python` to Python 2.)

* Activate:

  * PowerShell (Windows): `.\.venv\Scripts\Activate`
  * CMD (Windows): `.\.venv\Scripts\activate.bat`
  * macOS / Linux: `source .venv/bin/activate`

* Install packages (inside venv):

  ```bash
  python -m pip install <package>
  ```

* Save dependencies:

  ```bash
  pip freeze > requirements.txt
  ```

* Restore dependencies:

  ```bash
  python -m pip install -r requirements.txt
  ```

* Deactivate:

  ```bash
  deactivate
  ```

---

# How pip works inside a venv

* After activation, `python` and `pip` refer to the venv's executables.
* Packages install into `.venv/Lib/site-packages/` on Windows or `.venv/lib/pythonX.Y/site-packages/` on macOS/Linux.
* To avoid ambiguity, prefer `python -m pip install ...` so the pip used belongs to the same interpreter.

---

# Saving and restoring dependencies

* Save current environment:

  ```bash
  pip freeze > requirements.txt
  ```

* Recreate on another machine:

  ```bash
  python -m venv .venv
  .\.venv\Scripts\activate   # or source .venv/bin/activate on macOS / Linux
  python -m pip install -r requirements.txt
  ```

**Note:** `pip freeze` pins exact versions. This is good for reproducibility. For advanced dependency management consider tools like `pip-tools`, `poetry` or `pipenv` (outside scope of this file).

---

# Using venv with VS Code

1. Open the project folder in VS Code.
2. Press `Ctrl+Shift+P` → **Python: Select Interpreter** → choose the `.venv` interpreter.
3. Recommended workspace setting (`.vscode/settings.json`):

```json
{
  "python.defaultInterpreterPath": ".venv\\Scripts\\python.exe",
  "python.terminal.activateEnvironment": true
}
```

On macOS/Linux, use `.venv/bin/python` for `python.defaultInterpreterPath`. VS Code will then auto-activate the environment in the integrated terminal.

---

# Deactivate and delete venv

* Deactivate:

  ```bash
  deactivate
  ```

* Delete the virtual environment folder when you no longer need it:

  * macOS / Linux:

    ```bash
    rm -rf .venv
    ```
  * Windows (PowerShell):

    ```powershell
    Remove-Item -Recurse -Force .venv
    ```

Do not delete unless you no longer need the environment or you have `requirements.txt`.

---

# Common pitfalls and troubleshooting

* **Installed packages in the wrong environment**
  Always activate the venv before running `pip install`. Use `python -m pip` to be sure.

* **Multiple Python versions**
  Use `python3` explicitly on systems where `python` maps to Python 2.x.

* **PowerShell activation blocked**
  Set execution policy for current user:

  ```powershell
  Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
  ```

* **CLI scripts not found**
  Command-line entry points for installed packages live in `.venv/Scripts/` (Windows) or `.venv/bin/` (macOS/Linux). Ensure the venv is activated.

* **Accidentally committed .venv to Git**
  Add `.venv/` to `.gitignore` and remove the folder from the repository history if needed.

---

# Best practices

* Use `.venv` as the folder name so editors and tools auto-detect it.
* Do not commit the venv folder to source control. Use `requirements.txt` instead.
* Use `python -m pip` for installs to avoid ambiguity.
* One venv per project (do not reuse for unrelated projects).
* Pin versions with `pip freeze` for reproducible environments.
* For production or deterministic builds, consider lockfile-based tools (`pip-tools`, `poetry`) when appropriate.

---

# Git ignore example

Add this to `.gitignore`:

```
# Virtual environment
.venv/
venv/
env/

# Python caches
__pycache__/
*.pyc
```

---

# References

* Python `venv` — standard library documentation: [https://docs.python.org/3/library/venv.html](https://docs.python.org/3/library/venv.html)
* Python tutorial — venv section: [https://docs.python.org/3/tutorial/venv.html](https://docs.python.org/3/tutorial/venv.html)
* Packaging guide — installing with pip and virtual environments: [https://packaging.python.org/en/latest/guides/installing-using-pip-and-virtual-environments/](https://packaging.python.org/en/latest/guides/installing-using-pip-and-virtual-environments/)
* pip documentation: [https://pip.pypa.io/](https://pip.pypa.io/)

---

# Credits

Created by **Ayan Memon**  
GitHub: [https://github.com/AyanMemon296](https://github.com/AyanMemon296)  
YouTube: [https://www.youtube.com/@ayanmemon2926](https://www.youtube.com/@ayanmemon2926)  
LinkedIn: [https://www.linkedin.com/in/ayanmemon296/](https://www.linkedin.com/in/ayanmemon296/)  

---
