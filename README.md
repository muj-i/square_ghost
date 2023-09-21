
# Square Ghost

## Description 

A simple CRUD app that uses Firebase Authentication and Firebase Realtime Database.

## Responsibilities

- User authentication with Firebase Authentication
- Data storage in Firebase Realtime Database
- CRUD operations on user profiles

## Square Ghost UI

<div style="display: flex; flex-wrap: wrap;">
    <img src="https://github.com/muj-i/square_ghost/blob/main/screenshots/ss1.png" width="300" />
    <img src="https://github.com/muj-i/square_ghost/blob/main/screenshots/ss2.png" width="300" />
    <img src="https://github.com/muj-i/square_ghost/blob/main/screenshots/ss3.png" width="300" />
    <img src="https://github.com/muj-i/square_ghost/blob/main/screenshots/ss4.png" width="300" />
    <img src="https://github.com/muj-i/square_ghost/blob/main/screenshots/ss5.png" width="300" />
    
</div>

## Getting Started

### Prerequisites

Ensure Flutter is installed on your machine. For installation instructions, refer to the official [Flutter website](https://flutter.dev/docs/get-started/install).

### Installation

Follow these steps to run the Progress Pal Application:

1. Clone this repository to your local machine:

```bash
git clone https://github.com/muj-i/square_ghost.git
```

2. Navigate to the project folder:

```bash
cd square_ghost
```

3. Install dependencies:

```bash
flutter pub get
```

### How to Run

Connect your device or emulator and run the app using the following command:

```bash
flutter run
```
## Used Packages

Square Ghost integrates the following packages to enhance functionality:
- `firebase_core: ^2.15.0`: Firebase Core for Firebase integration.
- `firebase_auth: ^4.7.1`: Firebase Authentication for user authentication.
- `google_fonts: ^5.1.0`: Access Google Fonts for typography options.
- `font_awesome_flutter: ^10.5.0`: Access a wide range of Font Awesome icons for stylish visuals.
- `firebase_database: ^10.2.4`: Firebase Realtime Database for real-time data storage.
- `flutter_launcher_icons: ^0.13.1`: Simplify the generation of launcher icons on various platforms.
- `firebase_crashlytics: ^3.3.5`: Firebase Crashlytics for crash reporting and analysis.

## Project Directory Structure

The Square Ghost directory structure is organized as follows:

```
  progress_pal/
  ├── assets/
  │   ├── logo/
  │   │   ├── logo_name.png
  │   │   ├── logo.png
  │   │   ├── logo2.png
  ├── lib/
  │   ├── pages/
  │   │   ├── auth_pages/
  │   │   │   ├── forgot_password_page.dart
  │   │   │   ├── lib/pages/auth_pages/logedin_checking_page.dart
  │   │   │   ├── lib/pages/auth_pages/login_page.dart
  │   │   │   ├── lib/pages/auth_pages/signup_page.dart
  │   │   ├── lib/pages/home_page.dart
  │   │   ├── lib/pages/update_user_data_page.dart
  │   ├── reusable_widgets/
  │   │   ├── lib/reusable_widgets/all_over_button.dart
  │   │   ├── lib/reusable_widgets/constants.dart
  │   │   ├── lib/reusable_widgets/delete_account.dart
  │   │   ├── lib/reusable_widgets/gender_selection.dart
  │   │   ├── lib/reusable_widgets/log_in_sign_up_button.dart
  │   │   ├── lib/reusable_widgets/selected_gender.dart
  │   ├── lib/firebase_options.dart
  │   ├── main.dart
```

## Contributors

- [Mujahedul Islam](https://github.com/muj-i)

## Special Thanks

A heartfelt thanks to [Mitch Koko](https://www.youtube.com/@createdbykoko) for his enlightening tutorial on Firebase & for teaching me how to make UI like this.

The Firebase tutorial of Mitch I follow:

[Firebase x Flutter Tutorial](https://www.youtube.com/watch?v=TkuO8OLgvkk&list=PLlvRDpXh1Se4wZWOWs8yapI8AS_fwDHzf&index=3)

[Email Login & Logout • Flutter Auth Tutorial ♡](https://www.youtube.com/watch?v=_3W-JuIVFlg)

## License

This project is licensed under the MIT License. Refer to the [LICENSE](https://opensource.org/license/mit/) file for details.
