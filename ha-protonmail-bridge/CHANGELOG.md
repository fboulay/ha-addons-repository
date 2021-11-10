# Changelog

## 1.4.0

### 🚀 Improvements

- Add translations for the configuration options. Available languages
  are french and english.

### 🐛 Bug fixes

- Fix the docker build. The go dependency was not available anymore.
- The addon is working fine again. A custom git repository is used to 
  make it work on ARM architectures.

### ✅ Misc updates

- Config file is now is yaml format.

## 1.3.4

THIS ADDON DOES NOT WORK ANYMORE, read carefully the explanation below.

### ✅ Misc

- The ProtonMail server does not support anymore the ProtonMail Bridge 
  with the version 1.4.5. Thus this addon does not work anymore. I am
  working on a new working version. For now an error message is 
  displayed in the log file.

## 1.3.3

### 🚀 Improvements

- Update base docker image to 3.14
- Improve security rating to 6
  
### 🐛 Bug fixes

- Fix typo in logs
  
## 1.3.2

### 📚 Documentation

- Instructions on how to add the addon repository were wrong. The
  URL is now fixed.
  
## 1.3.1

### 🐛 Bug fixes

- Fix Dockerfile. The multi-stage build was not working as expected
  for building multi-arch images

### 📚 Documentation

- Improved and fixed documentation

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

### ✅ Misc updates
