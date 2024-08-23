# Simple Kanban Application

This Kanban application provides an intuitive interface for managing tasks with the following features:

- Task Navigation: Use arrows on each task to move between sections.
- Task Removal: Click the 'x' button to remove a task, which will then be listed under the Closed Tasks tab.
- Timer Integration: Starting and stopping the timer will record the task's duration. When you remove the task, this duration data will be saved and listed in the Closed Tasks section.
- Local Storage: Data operations for closed tasks (read and write) are managed locally due to limited API endpoints provided by Todoist.
- Section Updates: Updates to the sectionId of a task are restricted by the available API endpoints.
- Unit Tests: Unit tests can be found in the /test folder. Additional tests for remaining parts can be implemented upon request.
- CI/CD Integration: This is an area I am new to but am eager to learn and implement in the near future.
- Design: The application is designed with fundamental requirements in mind and can be further upgraded and polished.

## Screenshots
Screenshots of the application can be found in the /pictures folder. These images provide a visual overview of the application's interface and features.

## Getting Started
To use the application:
1. Configuration:

- Insert your personal authentication token into the api_service.
- Create a project on Todoist environment and replace the hardcoded taskViewModel projectID with your project ID.
- Add sections to your Todoist project (e.g., To Do, In Progress, Done).

2. Running the Application:

- Ensure you are in the project directory.
- Execute flutter run in the terminal.

The application has been developed and tested with a focus on web compatibility, featuring responsive design to ensure functionality on mobile devices.

I hope you find the application useful.
