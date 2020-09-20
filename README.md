# Ember LMS

A modern Learning Management System built with Flutter, supporting both web and mobile platforms (iOS/Android). Ember enables educational institutions to manage courses, assignments, and facilitate student-teacher interactions.

🔗 [Live Demo](https://ember-11eb1.web.app/#/)

## Features

### Current Features

- Cross-platform support (Web, iOS, Android)
- User authentication and role management
- Course management and enrollment
- Assignment submission and grading
- Real-time discussion boards
- File sharing and lecture notes
- Basic analytics and reporting
- School announcements

### Planned Features

- Video calls integration
- Advanced analytics dashboard
- Offline mode
- Push notifications
- Quiz/exam builder
- Automated grading system
- Calendar integration

## Technology Stack

### Frontend

- Flutter for cross-platform development
- Material Design components

### Backend (Firebase)

- Cloud Firestore: Database
- Cloud Functions: Serverless operations
- Firebase Auth: User authentication
- Cloud Storage: File management
- Firebase Hosting: Web deployment

## Getting Started

### Prerequisites

- Flutter SDK (2.0.0 or higher)
- Firebase CLI tools
- For iOS:
  - Xcode 13+
  - CocoaPods
- For Android:
  - Android Studio
  - Android SDK
- For Web:
  - Chrome

### Installation

1. Clone the repository:

```bash
git clone https://github.com/yacobalemneh/ember.git
cd ember
```

2. Install dependencies:

```bash
flutter pub get
```

### Firebase Setup

1. Create a Firebase project in [Firebase Console](https://console.firebase.google.com/)
2. Enable required services:

   - Authentication
   - Cloud Firestore
   - Cloud Storage
   - Cloud Functions

3. Configure platforms:
   - iOS: Download `GoogleService-Info.plist` and place in

Runner

- Android: Download `google-services.json` and place in

app

- Web: Copy

index.html.template

to

index.html

and update Firebase config

> Note: Firebase configuration files are gitignored for security.

### Running the Application

```bash
# Mobile development
flutter run

# Web development
flutter run -d chrome

# Production builds
flutter build ios
flutter build apk
flutter build web
```

## Project Structure

```
lib/
├── screens/         # UI screens
├── widgets/         # Reusable components
├── models/         # Data models
├── services/       # Firebase services
├── utils/         # Helper functions
└── main.dart      # Entry point

# Gitignored Firebase Config Files
ios/Runner/GoogleService-Info.plist
android/app/google-services.json
web/index.html
web/index.html.prod
```

## Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## License

MIT License - see LICENSE file
