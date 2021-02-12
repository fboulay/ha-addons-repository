# Changelog

## 1.3.0

### 🚀 Improvements

- The addon is now running using S6 overlay.
- Check in `run.sh` if all mandatory parameters are present.
- Set versions explicitly in Dockerfile for packages installed with `apk`
- Add hadolint check in Github Action

### 🐛 Bug fixes

- Github Action to update Docker Hub description is now working

## 1.2.2

### 🚀 Improvements

- Github action now update the Docker Hub description when pushing
  a new image.
- Add Shellcheck on every push.

## 1.2.1

### 🐛 Bug fixes

- Github action to publish to Docker Hub is now working
  
## 1.2.0

### 🚀 Improvements

- Add a security check on the ProtonMail password against the HaveIBeenPwned
  database. If the password is not safe, a warning is displayed in the logs.
- Support amd64 architecture
- Automatically push docker image to Docker Hub when a PR is merged on main

### 🐛 Bug fixes

- The addon can sometimes start to late and the SMTP integration does not manage
  to communicate with it. Changed the startup option to `system`.

### 📚 Documentation

- Add badges about supported architecture
- Add badge about supported licence
- Add labels in the Dockerfile
  
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
