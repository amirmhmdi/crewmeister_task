<p align="center">
  <img src="https://crewmeister.com/images/logo_crewmeister_without_text.svg" alt="Crewmeister Logo" />
</p>

# 🚀 Crewmeister Absence Manager - Flutter Coding Challenge

Welcome to my implementation of the **Crewmeister Absence Manager** coding challenge. This project was developed using **Clean Architecture**, the **BLoC** state management pattern, and **GetIt** for dependency injection. The application fulfills all requirements and includes additional bonus features for an enhanced user experience.

## Features

### Core Features
- **Absence List**:
  - Displays the first 10 absences with pagination.
  - Shows a total count of absences.
  - Includes detailed information for each absence:
    - Member Name
    - Type of Absence
    - Period
    - Member Note (if available)
    - Status (`Requested`, `Confirmed`, `Rejected`)
    - Admitter Note (if available)
- **Filtering**:
  - Filter absences by type.
  - Filter absences by date.
- **States**:
  - Loading State: Shows a loader while fetching data.
  - Error State: Displays an error message if data fetching fails.
  - Empty State: Informs the user if no results match the filter criteria.

### Bonus Features
- **.ics File Generation**:
  - Generate and send `.ics` files for absences.
  - Integrated with **Google Sign-In** to send files via email.
- **Wireframe-Driven Development**:
  - Started with designing wireframes to ensure a clear and consistent UI.

## Technical Details

### Architecture
- **Clean Architecture**: Ensures scalability, maintainability, and separation of concerns.
- **BLoC State Management**: Manages app state predictably and efficiently.
- **GetIt**: Simplifies dependency injection for better modularity.

### Testing
- Comprehensive unit tests for all testable parts of the application.
- **BLoC Tests**: Validate state transitions and event handling.

### API Integration
- Data is fetched via HTTP requests from JSON files hosted on Git.
- The `http` package was used for API communication.
