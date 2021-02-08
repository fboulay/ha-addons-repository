# Changelog

## 1.2.0

### 🚀 Improvements

- Add a security check on the ProtonMail password against the HaveIBeenPwned
  database. If the password is not safe, a warning is displayed in the logs.
- Support amd64 architecture
### 🐛 Bug fixes

- The addon can sometimes start to late and the SMTP integration does not manage
  to communicate with it. Changed the startup option to `system`.

### 📚 Documentation

- Add badges about supported architecture
- Add badge about supported licence
## 1.1.0

### 🚀 Improvements

- Expects scripts are now wrapped in their own files
- `run.sh` entrypoint is more clever, and now calls only needed scripts
- ProtonMail Bridge output is hidden. Only relevant information is
   displayed. This is thanks to expect scripts.
- Add a `debug.sh` file which is used only when developing to interact
  with expect scripts.
- Logs are using utility functions from bashio. The date format displays
  the current date and has a millisecond resolution.

## 1.0.0

- First working version
  
## 0.0.1

- First non working version

## Categories

### 🚀 Improvements

### 🐛 Bug fixes

### 📚 Documentation

### 🠝 Dependency updates
