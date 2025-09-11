# BrewCart ☕

A Flutter coffee ordering app with Firebase authentication and Firestore data storage.

## Features

- **User Authentication**: Email/password signup and login with Firebase Auth
- **User Profiles**: Store and display user data (username, email, timestamps) in Firestore
- **Modern UI**: Clean interface with Lottie animations and Material Design
- **State Management**: BLoC pattern for authentication flow

## Tech Stack

- **Framework**: Flutter
- **Backend**: Firebase (Auth + Firestore)
- **State Management**: BLoC
- **Animations**: Lottie
- **Architecture**: Clean separation with models, screens, and BLoCs

## Project Structure

```
lib/
├── app/                 # App configuration and routing
├── bloc/               # State management (AuthBloc)
├── models/             # Data models (UserData)
├── screens/            # UI screens (Auth, Home, Splash)
└── widgets/            # Reusable UI components
```

## Getting Started

### Prerequisites

- Flutter SDK (latest stable)
- Firebase project with Auth and Firestore enabled
- Android Studio / VS Code

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd my_coffee_app
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Firebase Setup**

   - Add your `google-services.json` to `android/app/`
   - Configure Firebase options in `lib/firebase_options.dart`

4. **Run the app**
   ```bash
   flutter run
   ```

## Firebase Configuration

### Collections Structure

**Users Collection** (`users/{uid}`)

```json
{
  "username": "string",
  "email": "string",
  "createdAt": "timestamp",
  "updatedAt": "timestamp"
}
```

### Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{uid} {
      allow read, update: if request.auth != null && request.auth.uid == uid;
      allow create: if request.auth != null && request.resource.id == request.auth.uid;
    }
  }
}
```

## Key Components

- **AuthBloc**: Handles signup/login with Firestore user data creation
- **HomeScreen**: Displays user greeting with Firestore data fetching
- **UserData Model**: Maps Firestore documents to Dart objects

## Development

### Adding New Features

1. Create models in `lib/models/`
2. Add BLoCs in `lib/bloc/` for state management
3. Build screens in `lib/screens/`
4. Update routing in `lib/app/router/`

### Code Style

- Follow Flutter/Dart conventions
- Use BLoC for state management
- Keep UI and business logic separated
- Add proper error handling for Firebase operations

## License

This project is licensed under the MIT License.
