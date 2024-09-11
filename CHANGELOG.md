# Changelog

## 0.1.2
- **Feature**: Added a code of conduct. 
- **Feature**: Added Changelog


## 0.1.1
- **Refactor**: Replaced "Pass2U" with "Pass2u" for better consistency. 
- **Bugfix**: Fixed version number to ensure proper release management. 
- **Bugfix**: Fixed comments for code clarity. 
- **Bugfix**: Fixed connection original error, improving reliability. 


## 0.1.0
- **Initial Release**: 
    - Added project setup, including gem version, client, configuration, module, rakefile, and specs.
    - Added custom error handling and error messages for better debugging.
    - Added CI integration for automated testing.
    - Added documentation with license and readme files.
- **Improvement**: Updated response code check for more accurate error reporting.
- **Improvement**: Updated LICENSE and other documentation files. 
- **Refactor**: Updated `spec_helper`, `Gemfile.lock`, and readme files to reflect the current setup.
- **Dependency Removal**: Removed `HTTParty` dependency and replaced it with `Net::HTTP` to reduce external dependencies.
- **Test Improvement**: Enforced "expect" in specs for improved testing consistency.
