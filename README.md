# BIT4107 - Mobile Application Development

Flutter projects developed throughout the BIT4107 unit.

**Student:** ____________________________  
**Reg No:** BIT-2024-58742  
**Programme:** Bachelor of Science in Information Technology  

---

## Projects

### Week 1 - Hello World
Basic Flutter app demonstrating environment setup, PATH configuration, and app structure. Customised with a blue theme, changed app title, background colour, and font size.

```
cd week1_hello_world
flutter pub get
flutter run
```

---

### Week 2 - Student Management App
Three-screen app with Login, Registration, and Dashboard. Demonstrates navigation between screens, form input handling, and stateful widgets.

```
cd week2_student_app
flutter pub get
flutter run
```

---

### Week 3 - UI Prototype
Full 5-screen prototype including Splash, Login, Register, Dashboard, and Student Profile. Demonstrates UI/UX design principles and multi-screen navigation.

```
cd week3_ui_prototype
flutter pub get
flutter run
```

---

### Week 4 - Event Handling
Demonstrates event-driven programming in Flutter. Features include button tap events (increment/decrement counter), text input submission, dark mode toggle switch, brightness slider, and gesture detection (tap, double-tap, long-press).

```
cd week4_event_handling
flutter pub get
flutter run
```

---

### Week 5 - Data Management
Full CRUD operations — Create, Read, Update, Delete student records with live search and filtering. Data managed in-memory using Flutter state management.

```
cd week5_data_management
flutter pub get
flutter run
```

---

### Week 6 - Networking
Demonstrates mobile networking concepts including client-server architecture analysis, REST API integration, and JSON data handling. Uses the Frankfurter open exchange rate API (no key required) for live currency conversion.

```
cd week6_networking
flutter pub get
flutter run
```

**API Used:** [Frankfurter Exchange Rate API](https://api.frankfurter.dev)  
**Endpoint:** `GET https://api.frankfurter.dev/latest?base=USD&symbols=KES,EUR,GBP`

---

### Week 7 - Data Storage & SQLite Database
Student Attendance Management System with full SQLite database integration. Features student registration, daily attendance marking (Present/Absent/Late), and attendance report generation. Implements relational database design with foreign key relationships and password hashing.

```
cd week7_student_attendance
flutter pub get
flutter run
```

**Dependencies:**
- `sqflite ^2.3.2` — SQLite database
- `path ^1.9.0` — database path resolution
- `intl ^0.19.0` — date formatting

**Database Schema:**
```
students (student_id PK, name, course, year_of_study, phone_number, password_hash)
attendance (attendance_id PK, student_id FK, date, status, unit_code)
```

---

## Tech Stack

| Tool | Version | Purpose |
|------|---------|---------|
| Flutter | 3.44.0 | Mobile framework |
| Dart | 3.12.0 | Programming language |
| VS Code | Latest | Code editor |
| Android Studio | Latest | Emulator & SDK |
| SQLite (sqflite) | 2.3.2 | Local database (Week 7) |

---

## How to Run Any Project

1. Clone or download this repository
2. Navigate into the week folder: `cd week7_student_attendance`
3. Install dependencies: `flutter pub get`
4. Start an emulator or connect a device
5. Run the app: `flutter run`

---

## Repository Structure

```
BIT4107/
├── week1_hello_world/
├── week2_student_app/
├── week3_ui_prototype/
├── week4_event_handling/
├── week5_data_management/
├── week6_networking/
├── week7_student_attendance/
│   ├── lib/
│   │   ├── models/
│   │   │   ├── student.dart
│   │   │   └── attendance.dart
│   │   ├── screens/
│   │   │   ├── home_screen.dart
│   │   │   ├── add_student_screen.dart
│   │   │   ├── attendance_screen.dart
│   │   │   └── report_screen.dart
│   │   ├── database_helper.dart
│   │   └── main.dart
│   └── pubspec.yaml
└── README.md
```
