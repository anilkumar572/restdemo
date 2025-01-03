# Bucket List App

## Overview
The Bucket List App is a Flutter-based mobile application that allows users to manage their bucket list items. Users can view, add, and interact with items on their bucket list, providing a simple yet effective way to keep track of their goals and aspirations.

## Features
- **Fetch Data:** Retrieve bucket list items from a remote Firebase database.
- **Add Items:** Add new bucket list items with attributes such as name, image, and cost.
- **Mark as Completed:** Filter and display only the uncompleted items.
- **Error Handling:** Gracefully handles data-fetching errors with retry functionality.
- **Pull to Refresh:** Update the bucket list by pulling down on the screen.
- **Detailed View:** Navigate to a detailed view of each bucket list item.

## Technology Stack
- **Flutter:** UI Framework
- **Dio:** HTTP client for API requests
- **Firebase:** Backend for storing bucket list items

## Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart 2.0+
- Firebase project with a Realtime Database setup

## Setup Instructions
1. Clone the repository:
   ```bash
   git clone https://github.com/anilkumar572/restdemo.git
   ```
2. Navigate to the project directory:
   ```bash
   cd bucketlist-app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Configure Firebase:
   - Add your `google-services.json` file for Android in `android/app`.
   - Add your `GoogleService-Info.plist` file for iOS in `ios/Runner`.
5. Run the application:
   ```bash
   flutter run
   ```

## File Structure
```
lib/
|-- main.dart            # Entry point of the app
|-- screens/
|   |-- main_screen.dart  # Main screen displaying bucket list
|   |-- add_item.dart     # Screen for adding new items
|   |-- view_bucketitem.dart # Detailed view of a bucket list item
|-- widgets/             # Reusable UI components
```

## API
The app interacts with a Firebase Realtime Database. Example structure:
```json
[
  {
    "name": "Visit Paris",
    "image": "https://example.com/paris.jpg",
    "cost": 2000,
    "completed": false
  },
  {
    "name": "Skydiving",
    "image": "https://example.com/skydiving.jpg",
    "cost": 300,
    "completed": true
  }
]
```



## Contributing
Contributions are welcome! Please fork the repository and create a pull request with detailed information about your changes.

## License
This project is licensed under the MIT License. See the `LICENSE` file for more details.

## Contact
For any queries or issues, please contact anilgithubd@gmail.com.

