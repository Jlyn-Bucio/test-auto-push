@echo off
echo === Initialize ===
echo [WARNING] Make sure you have changes in your local repo before running this script.
echo [WARNING] Make sure you have deleted the .git folder in your local repo before running this script.

set /p auth=Login? (Y/n): 

if /I "%auth%"=="y" goto login
if /I "%auth%"=="n" goto main

:login
set /p username=Enter your Git user name: 
git config --global user.name "%username%"

set /p email=Enter your Git email: 
git config --global user.email "%email%"

:main
set /p url=Enter your repo URL: 
set /p commit_message=Enter your commit message: 

echo.
echo Initializing Git repository...
git init

echo.
echo Adding all files to Git...
git add .

echo.
echo Making initial commit...
git commit -m "%commit_message%"
if errorlevel 1 (
    echo Error: Failed to make initial commit.
    pause
    exit /b %errorlevel%
)

echo.
echo Adding repo URL to remote origin...
git remote add origin "%url%"

echo.
echo Changing branch to main...
git branch -M main
if errorlevel 1 (
    echo Error: Failed to change branch to main.
    pause
    exit /b %errorlevel%
)

echo.
echo Pushing to remote repository...
git push -u origin main
if errorlevel 1 (
    echo Error: Failed to push to remote repository.
    pause
    exit /b %errorlevel%
)

echo.
echo Repo Initialized Successfully! Refresh the page to see the changes.
pause
