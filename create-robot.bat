@echo off
setlocal

:: Initialize flags
set "FLAG_SUCCESS=1"

:: Check if Python is installed
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Python is not installed. Please install Python before running this script.
    set "FLAG_SUCCESS=0"
    exit /b 1
)

if "%1"=="" (
    echo Please provide a project name, like 'create-robot <ProjectName>'.
    set "FLAG_SUCCESS=0"
    exit /b 1
)

set "PROJECT_NAME=%~1"

:: Debug - Display project name
echo Project name: %PROJECT_NAME%

:: Check if the project folder already exists
if exist "%PROJECT_NAME%" (
    echo Error: Project "%PROJECT_NAME%" already exists. Please delete the existing project manually or use a different project name.
    set "FLAG_SUCCESS=0"
    exit /b 1
)

:: Create the main project directory
echo Building new project...
mkdir "%PROJECT_NAME%"
if %ERRORLEVEL% NEQ 0 (
    echo Failed to create project directory.
    set "FLAG_SUCCESS=0"
    exit /b 1
)

:: Create subdirectories
mkdir "%PROJECT_NAME%\configs"
mkdir "%PROJECT_NAME%\data"
mkdir "%PROJECT_NAME%\keywords"
mkdir "%PROJECT_NAME%\libraries"
mkdir "%PROJECT_NAME%\logs"
mkdir "%PROJECT_NAME%\reports"
mkdir "%PROJECT_NAME%\resources\locators"
mkdir "%PROJECT_NAME%\resources\variables"
mkdir "%PROJECT_NAME%\results"
mkdir "%PROJECT_NAME%\testcases"
mkdir "%PROJECT_NAME%\tools"
if %ERRORLEVEL% NEQ 0 (
    echo Failed to create subdirectories.
    set "FLAG_SUCCESS=0"
    exit /b 1
)

:: Create sample files with initial content
echo # Configuration files > "%PROJECT_NAME%\configs\config.yaml"
echo # Test data files > "%PROJECT_NAME%\data\test_data.csv"
echo # Initialize the keywords module > "%PROJECT_NAME%\keywords\__init__.py"
echo # Web-specific keywords. Can use .robot or .resource files as well. > "%PROJECT_NAME%\keywords\web_keywords.py"
echo # Initialize the libraries module > "%PROJECT_NAME%\libraries\__init__.py"
echo # Common utility functions > "%PROJECT_NAME%\libraries\common.py"
echo # Web element locators > "%PROJECT_NAME%\resources\locators\web_locators.py"
echo # Common variables > "%PROJECT_NAME%\resources\variables\common_vars.py"
echo # Project dependencies > "%PROJECT_NAME%\requirements.txt"
echo # Project documentation > "%PROJECT_NAME%\README.md"

echo from datetime import datetime > "%PROJECT_NAME%\run_tests.py"
echo import robot >> "%PROJECT_NAME%\run_tests.py"
echo. >> "%PROJECT_NAME%\run_tests.py"
echo curr_time = datetime.now().strftime('%%Y%%m%%d%%I%%M%%S') >> "%PROJECT_NAME%\run_tests.py"
echo. >> "%PROJECT_NAME%\run_tests.py"
echo def run_robot_tests(): >> "%PROJECT_NAME%\run_tests.py"
echo     robot.run("./testcases", report=f"./reports/{curr_time}_report.html", output=f"./results/{curr_time}_result.xml", log=f"./logs/{curr_time}_log.html") >> "%PROJECT_NAME%\run_tests.py"
echo. >> "%PROJECT_NAME%\run_tests.py"
echo def main(): >> "%PROJECT_NAME%\run_tests.py"
echo     run_robot_tests() >> "%PROJECT_NAME%\run_tests.py"
echo. >> "%PROJECT_NAME%\run_tests.py"
echo if __name__ == "__main__": >> "%PROJECT_NAME%\run_tests.py"
echo     main() >> "%PROJECT_NAME%\run_tests.py"
if %ERRORLEVEL% NEQ 0 (
    echo Failed to create sample files.
    set "FLAG_SUCCESS=0"
    exit /b 1
)

:: Create the robot test file with the given content
echo *** Settings *** > "%PROJECT_NAME%\testcases\web_tests.robot"
echo Documentation           This is a sample test file >> "%PROJECT_NAME%\testcases\web_tests.robot"
echo Library           SeleniumLibrary >> "%PROJECT_NAME%\testcases\web_tests.robot"
echo Library           ../keywords/web_keywords.py >> "%PROJECT_NAME%\testcases\web_tests.robot"
echo Variables         ../resources/variables/common_vars.py >> "%PROJECT_NAME%\testcases\web_tests.robot"
echo. >> "%PROJECT_NAME%\testcases\web_tests.robot"
echo. >> "%PROJECT_NAME%\testcases\web_tests.robot"
echo *** Test Cases *** >> "%PROJECT_NAME%\testcases\web_tests.robot"
echo. >> "%PROJECT_NAME%\testcases\web_tests.robot"
echo. >> "%PROJECT_NAME%\testcases\web_tests.robot"
if %ERRORLEVEL% NEQ 0 (
    echo Failed to create sample robot test file.
    set "FLAG_SUCCESS=0"
    exit /b 1
)

:: Create a sample variables file
echo # Sample variables > "%PROJECT_NAME%\resources\variables\common_vars.py"
echo URL = "http://example.com/login" > "%PROJECT_NAME%\resources\variables\common_vars.py"
echo BROWSER = "chrome" >> "%PROJECT_NAME%\resources\variables\common_vars.py"
echo USERNAME = "your_username" >> "%PROJECT_NAME%\resources\variables\common_vars.py"
echo PASSWORD = "your_password" >> "%PROJECT_NAME%\resources\variables\common_vars.py"
if %ERRORLEVEL% NEQ 0 (
    echo Failed to create sample variables file.
    set "FLAG_SUCCESS=0"
    exit /b 1
)

:: Add required libraries to requirements.txt
echo robotframework > "%PROJECT_NAME%\requirements.txt"
echo robotframework-seleniumlibrary >> "%PROJECT_NAME%\requirements.txt"
echo robotframework-selenium2library >> "%PROJECT_NAME%\requirements.txt"
echo robotframework-requests >> "%PROJECT_NAME%\requirements.txt"
echo robotframework-sshlibrary >> "%PROJECT_NAME%\requirements.txt"
echo robotframework-databaselibrary >> "%PROJECT_NAME%\requirements.txt"
echo robotframework-appiumlibrary >> "%PROJECT_NAME%\requirements.txt"
if %ERRORLEVEL% NEQ 0 (
    echo Failed to write requirements to requirements.txt.
    set "FLAG_SUCCESS=0"
    exit /b 1
)

:: Create a virtual environment
cd "%PROJECT_NAME%"
python -m venv .venv
if %ERRORLEVEL% NEQ 0 (
    echo Failed to create virtual environment.
    set "FLAG_SUCCESS=0"
	exit /b 1
)

:: Activate the virtual environment
call .venv\Scripts\activate
if %ERRORLEVEL% NEQ 0 (
    echo Failed to activate virtual environment.
    set "FLAG_SUCCESS=0"
	exit /b 1
)

:: Install required libraries and handle errors
pip install -r requirements.txt
if %ERRORLEVEL% NEQ 0 (
    echo Error occurred while installing the libraries. Please check the error messages above.
    set "FLAG_SUCCESS=0"
)

:: Print success message with check mark if all flags are true
if "%FLAG_SUCCESS%"=="1" (
    echo Project "%PROJECT_NAME%" created successfully.
) else (
    echo Project creation failed as some steps failed. Please check the error messages above.
)

endlocal
