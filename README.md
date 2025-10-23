SpaceHub - Co-working Space Booking Platform

<p align="center">
<img src="Admin_App/assets/app_logo.png" alt="SpaceHub Logo" width="150"/>
</p>

<p align="center">
<strong>Find. Book. Work.</strong>
</p>

<p align="center">
SpaceHub is a comprehensive mobile platform built with Flutter, designed to streamline the discovery and booking of co-working spaces in Bangladesh. It connects users seeking flexible workspaces with space owners, facilitated by an administrative backend, ensuring a seamless experience for everyone involved.
</p>

<!-- Optional Badges (Add URLs if available) -->

<!-- <p align="center">
<a href="#"><img src="https://www.google.com/search?q=https://img.shields.io/badge/Flutter-3.x-blue%3Flogo%3Dflutter" alt="Flutter Version"></a>
<a href="#"><img src="https://www.google.com/search?q=https://img.shields.io/badge/License-MIT-green" alt="License"></a>
<a href="#"><img src="https://www.google.com/search?q=https://img.shields.io/github/stars/your-username/spacehub%3Fstyle%3Dsocial" alt="GitHub stars"></a>
</p> -->

Overview

Finding and booking suitable co-working spaces can be challenging. SpaceHub addresses this by providing an intuitive mobile interface for users to search, view details, and reserve spaces that meet their needs. Simultaneously, it offers tools for space owners and administrators (via the Admin App) to manage listings, bookings, and platform operations efficiently.

Key Actors & Roles

User (via User App): Individuals looking for co-working spaces. They can:

Register/Login (Email/Password, Google, Facebook).

Search & Filter spaces (location, category, facilities).

View space details, photos, pricing, amenities, and map location.

Book spaces for specific dates and times.

Manage their profile and booking history.

Add favorite spaces.

Make payments using various methods (bKash, Nagad, Cards).

Provide feedback and report issues.

Co-working Space Owner (via Admin App): Property owners listing their spaces. They can:

Add and manage space listings (details, photos, pricing, facilities).

View and manage incoming booking requests.

Track earnings and generate reports/bills.

Respond to user feedback and reported issues for their spaces.

Platform Admin (via Admin App): Oversees the entire platform. They can:

Manage user accounts and space owner accounts.

Approve/reject new space listings.

Monitor platform activity and analytics (Dashboard).

Handle escalated issues and disputes.

Ensure overall platform health and smooth operation.

Features

User App (User_App)

Authentication: Secure Sign-up, Login (Email/Password, Google, Facebook), Password Reset.

Space Discovery:

Home screen with recommendations and categories (Private, Office, Space).

Advanced search with filtering options.

Interactive map view displaying nearby spaces.

Booking System:

Detailed space view with image carousel, facilities list, pricing, and reviews.

Calendar and time selection interface.

Secure booking confirmation.

Payment Integration: Supports local MFS (bKash, Nagad) and international cards (Visa, MasterCard, Amex).

User Profile Management:

Edit personal details.

View booking history (Upcoming, Completed, Cancelled).

Manage saved payment methods.

Manage favorite spaces.

Real-time Notifications: For booking status updates.

Offline Handling: Basic support using connectivity checks.

Admin & Owner App (Admin_App)

Authentication: Secure Login/Sign-up for Admins/Owners.

Dashboard: Overview of key platform metrics (bookings, users, spaces).

Workspace Management: CRUD operations (Create, Read, Update, Delete) for co-working spaces.

Booking Management: View all platform bookings, filter, and manage statuses.

User/Owner Management (Admin): View and manage platform users and space owners.

Issue Tracking: System for logging and resolving reported problems.

Technology Stack

Framework: Flutter (Cross-platform UI toolkit)

Language: Dart

Backend & Database: Firebase (Authentication, Firestore, possibly Storage)

State Management: GetX (Reactive state management, dependency injection, routing)

Mapping: Google Maps Flutter plugin

Connectivity: connectivity_plus (Network status checking)

Project Structure (lib Folder Focus)

The core logic is organized within the lib directory of each application.

Admin App (Admin_App/lib/)

lib/
├── app.dart              # Main application setup (GetMaterialApp)
├── controller_binder.dart  # GetX dependency bindings
├── controllers/          # Business logic and state management
│   ├── admin_controller.dart
│   └── network_controller.dart
├── firebase_options.dart   # Firebase configuration
├── main.dart             # App entry point
├── models/               # Data structures
│   ├── admin_model.dart
│   └── work_space_model.dart # Shared model (likely)
├── screens/              # UI pages/views
│   ├── add_workspace_screen.dart
│   ├── dashboard_screen.dart
│   ├── edit_workspace_screen.dart
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   └── workspace_list_screen.dart
└── service/              # Data fetching and external interactions
├── connectivity_service.dart
└── firestore_service.dart


User App (User_App/lib/)

lib/
├── app.dart              # Main application setup (GetMaterialApp)
├── controller_binder.dart  # GetX dependency bindings
├── controllers/          # Business logic and state management
│   ├── auth/             # Authentication specific controllers
│   ├── booking_controller.dart
│   ├── card_information_controller.dart
│   ├── category_controller.dart
│   ├── date_and_time_cotroller.dart
│   ├── main_bottom_nav_bar_controller.dart
│   ├── map_controller.dart
│   ├── search_controller.dart
│   ├── user_controller.dart
│   └── work_space_controller.dart
├── core/                 # Foundational code (shared models, base classes)
│   ├── models/           # Data structures
│   ├── repositories/     # Data abstraction layer
│   └── validators/       # Input validation logic
├── firebase_options.dart   # Firebase configuration
├── main.dart             # App entry point
├── services/             # Data fetching and external interactions
│   ├── auth/             # Authentication specific services
│   ├── connectivity_services.dart
│   └── work_space_service.dart
└── view/                 # UI components and presentation logic
├── all_work_spaces_screen.dart
├── screens/          # UI pages/views (grouped by feature)
├── utility/          # UI constants (colors, themes, asset paths)
└── widgets/          # Reusable UI elements


UI Showcase (User App)

<p align="center">
<kbd><img src="ui/Ladning page (1) (1).png" alt="Landing Screen" width="180"/></kbd>
<kbd><img src="ui/Log-in (1).png" alt="Login Screen" width="180"/></kbd>
<kbd><img src="ui/Home Screen (1).png" alt="Home Screen" width="180"/></kbd>
<kbd><img src="ui/Search (1) (1).png" alt="Search Results" width="180"/></kbd>
</p>
<p align="center">
<kbd><img src="ui/Search Details (1).png" alt="Space Details" width="180"/></kbd>
<kbd><img src="ui/Date selection Time (1) (1).png" alt="Date & Time Selection" width="180"/></kbd>
<kbd><img src="ui/Payment methods (1).png" alt="Payment Methods" width="180"/></kbd>
<kbd><img src="ui/Date selection (1) (1).png" alt="Booking Success" width="180"/></kbd> <!-- Changed order for flow -->
</p>
<p align="center">
<kbd><img src="ui/Booking (1).png" alt="My Bookings" width="180"/></kbd>
<kbd><img src="ui/Map (1) (1).png" alt="Map View" width="180"/></kbd>
<kbd><img src="ui/Payment- Add card (1).png" alt="Add Card Screen" width="180"/></kbd>
<kbd><img src="ui/User Profile - About (1).png" alt="User Profile" width="180"/></kbd>
</p>

Getting Started

Prerequisites

Flutter SDK (Ensure version compatibility, check pubspec.yaml)

Firebase Project: Set up Firestore, Authentication (Email/Pass, Google, Facebook enabled), and potentially Firebase Storage.

Android Studio / Xcode for emulators/simulators or a physical device.

Firebase CLI (optional but recommended for managing backend rules/functions).

Installation & Setup

Clone the Repository:

git clone [https://github.com/your-username/spacehub.git](https://github.com/your-username/spacehub.git) # Replace with your repo URL
cd spacehub


Firebase Configuration:

Android: Place your google-services.json file in both Admin_App/android/app/ and User_App/android/app/.

iOS: Configure your GoogleService-Info.plist file within Xcode for both the Admin_App/ios/Runner and User_App/ios/Runner targets.

Ensure your Firestore security rules are appropriately configured for user, owner, and admin access.

Install Dependencies:

# For User App
cd User_App
flutter pub get

# For Admin App
cd ../Admin_App
flutter pub get


Run the Apps:

# Ensure an emulator is running or a device is connected

# For User App
cd ../User_App
flutter run

# For Admin App
cd ../Admin_App
flutter run


Contributing

We welcome contributions to SpaceHub! Please follow these general guidelines:

Fork the repository.

Create a new branch for your feature or bug fix (e.g., git checkout -b feature/add-new-payment-method or bugfix/login-issue).

Make your changes following the project's coding style (if defined).

Write tests for your changes if applicable.

Commit your changes with clear, descriptive messages.

Push your branch to your fork.

Submit a Pull Request to the main repository's main or develop branch.

Please ensure your PR includes a clear description of the changes and addresses any relevant issues.