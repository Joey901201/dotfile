# Dotfile

This repository contains my dotfile for quickly setting up my development environment.  

---

## Usage  

### **1. Using `curl` to Install Directly**  
```bash
curl -sL https://raw.githubusercontent.com/Joey901201/dotfile/main/bootstrap.sh | bash
```

---

### **2. Custom Installation Path**  
By default, the dotfile will be installed in `~/dev_env/dotfile`.  
To change the installation location, set the `DEV_ENV` environment variable before running the script:  
```bash
export DEV_ENV=/your/custom/path
curl -sL https://raw.githubusercontent.com/Joey901201/dotfile/main/bootstrap.sh | bash
```

If `DEV_ENV` is already set, the script will prompt you to keep the existing value or overwrite it with the default.  

---

## Notes  
- This script is designed for Linux environments with `apt` package manager (e.g., Ubuntu/Debian).  
- Make sure you have sudo privileges.

