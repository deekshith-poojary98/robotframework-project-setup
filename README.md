# Robot Framework Project Setup

This repository provides a batch file for setting up a new Robot Framework project. By running the batch file with a project name, all necessary directories, files, and virtual environment will be created automatically.

## Getting Started

### Prerequisites

- **Python**: Ensure that Python is installed on your system. You can download Python from [python.org](https://www.python.org/).

## Setup
### Clone the Repository
Clone this repository to your local machine:
    ```
    git clone https://github.com/yourusername/your-repo.git
    cd your-repo
    ```

## Create a New Project
- Open a command prompt.
- Navigate to the directory where the batch file (create-robot.bat) is located.
- Run the batch file with the desired project name:
```
create-robot.bat <projectname>
```
Replace <projectname> with your desired project name.


## Project Structure

The project is organized as follows:
```
<projectname>/
│
├── configs/
│ └── config.yaml
│
├── data/
│ └── test_data.csv
│
├── keywords/
│ ├── init.py
│ └── web_keywords.py
│
├── libraries/
│ ├── init.py
│ └── common.py
│
├── logs/
│
├── reports/
│
├── resources/
│ ├── locators/
│ │ └── web_locators.py
│ └── variables/
│ └── common_vars.py
│
├── results/
│
├── testcases/
│ └── web_tests.robot
│
├── tools/
│
├── requirements.txt
├── README.md
└── run_tests.py
```
## What the Batch File Does
- **Checks for Python Installation**: Ensures Python is installed on your system.
- **Checks for Existing Project**: If a project with the same name already exists, it will ask you to delete the project manually or use different name.
- **Creates Project Structure**: Generates directories and sample files for a Robot Framework project.
- **Sets Up Virtual Environment**: Installs the required libraries into a virtual environment.
- **Configures Project**: Adds initial configuration, sample files, and required dependencies.


## Troubleshooting
- **Error during project setup**: Ensure you have Python installed and try running the batch file again.
- **Missing virtual environment**: Check if the virtual environment was created and activated properly.
- For further assistance, please refer to the [Robot Framework documentation](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html).

## License
This project is licensed under the MIT License - see the LICENSE file for details.
