# Windows Virtual Environment Setup (PowerShell)

This folder provides **two PowerShell scripts** to set up a Python virtual environment on Windows.  
Choose the one that best suits your needs.

---

## 📌 venv_setup-v1.ps1 (Basic)

The **beginner-friendly version**.  
Runs the main steps without error handling or extra checks.

### What it does
- Creates a virtual environment `.venv`
- Activates it
- Shows Python and pip versions
- Lists installed packages
- Upgrades `pip`, `setuptools`, and `wheel`
- Displays updated package list

### Usage
```powershell
.\venv_setup-v1.ps1
````

---

## 📌 venv\_setup-v2.ps1 (Advanced)

The **safer version** with error handling and requirements.txt management.

### What it does

* Checks if Python is installed
* Creates and activates `.venv`
* Shows Python and pip versions
* Lists installed packages
* Upgrades `pip`, `setuptools`, and `wheel`
* Verifies installed packages
* **Checks for `requirements.txt`:**

  * If it exists → installs dependencies
  * If it does not exist → creates an empty `requirements.txt`

> **If it exists, it will find it, and if it doesn't, it will make it.**

### Usage

```powershell
.\venv_setup-v2.ps1
```

---

## 🛠 Requirements

* Windows with **PowerShell**
* **Python** installed and added to PATH

---

## 📂 Files

* `venv_setup-v1.ps1` → Simple version for quick setup
* `venv_setup-v2.ps1` → Advanced version with error handling and requirements.txt support
* `README.md` → Instructions for using the scripts on Windows

---
