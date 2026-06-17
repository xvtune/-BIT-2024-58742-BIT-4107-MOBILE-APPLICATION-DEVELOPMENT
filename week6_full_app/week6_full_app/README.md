# Week 6 - Full App (Login + Student Management + Event Handling)

This project combines work from Weeks 1-5 into a single functional Flutter app.

## Features
- **Login Screen** — validates email/password against registered accounts
- **Sign Up Screen** — register a new account (stored in-memory)
- **Student Management Tab** — view and add student records (CRUD demo from Week 5)
- **Event Handling Tab** — counter button demonstrating event handling (Week 4)

## Default Test Account
- Email: `admin@uni.com`
- Password: `123456`

## How to Run
```
flutter pub get
flutter run
```

## Project Structure
```
week6_full_app/
├── lib/
│   └── main.dart       <- all app code
└── pubspec.yaml
```

## Notes
This app uses in-memory storage only (no real backend/database connection).
Data resets each time the app restarts.
