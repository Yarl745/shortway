# ShortWay App

## Description

ShortWay is a Flutter application designed to demonstrate field pathfinding functionality. Utilizing a combination of technologies such as Flutter, Dio for networking, and MobX for state management, Shortway allows users to input a base API URL to fetch field data and calculate the shortest paths.

## Getting Started

To run this project, use the following command to watch for file changes and regenerate necessary files automatically:

```shell
dart run build_runner watch --delete-conflicting-outputs
```

## Setup
Ensure you have Flutter SDK installed with version `>=3.3.1 <4.0.0`. Before running the project, add the necessary dependencies in your `pubspec.yaml`.

## Running the App
Initialize and run the app with the main entry file `main.dart`. The application has been structured with a clean architecture approach, dividing its logic into `data`, `domain`, and `presentation` layers, and making use of `router` for navigation.

## Features
- Fetching field data from API.
- Pathfinding algorithms to determine shortest routes.
- State management with MobX and Provider.
- Dependency injection with GetIt for service location.

## Important Files and Directories
- `lib/core`: Core functionality and utilities.
- `lib/data`: Data handling layers, including data sources and models.
- `lib/domain`: Business logic and entities.
- `lib/presentation`: UI components, view models, and pages.
- `lib/router`: Navigation and routing definitions.

## Widgets and View Models
Each screen and its corresponding logic is encapsulated within the `presentation` layer, ensuring separation of concerns and maintainability.

## Conclusion
Shortway is a modular and well-structured application showcasing modern Flutter development practices with a focus on clean architecture.

For more details, please refer to individual Dart files within the project structure.

