# Mobile App Developer Hiring Task - Android

This repository contains the submission for the Mobile App Developer Hiring Task. The application is built using **Flutter** targeting the **Android** platform. It demonstrates UI implementation, API integration, local caching (offline mode), and Push Notifications.

## 📱 Features Implemented

| Task | Status | Description |
| :--- | :--- | :--- |
| **UI/UX** | ✅ Completed | Login screen with validation & Dashboard with post list. |
| **API Integration** | ✅ Completed | Fetches posts from JSONPlaceholder using `http` with error handling. |
| **Local Caching** | ✅ Completed | Uses **Hive** to cache data. Automatically loads cache when offline. |
| **State Management** | ✅ Completed | Uses **Provider** for clean logic separation. |
| **Builds** | ✅ Completed | Generated Signed APK and AAB for release. |
| **Notifications** | ✅ Completed | Firebase Messaging (FCM) + Local Notifications for foreground alerts. |

## 🛠️ Tech Stack & Architecture

* **Framework:** Flutter (Dart)
* **State Management:** Provider
* **Networking:** http (with custom headers for security checks)
* **Local Database:** Hive (Key-value database)
* **Notifications:** Firebase Messaging & Flutter Local Notifications

**Architecture Pattern:**
The app follows a Clean Architecture approach using the **Provider** pattern:
* `screens/`: UI components.
* `providers/`: Business logic and state management.
* `models/`: Data models (Hive adapted).
* `services/`: (Optional) dedicated services for API/Storage.

## 🚀 How to Run the App

### Prerequisites
* Flutter SDK installed.
* Android Studio / VS Code with Flutter extensions.
* Android Emulator or Physical Device.

### Installation Steps
1.  **Clone the repository** (or extract the zip):
    ```bash
    git clone [REPOSITORY_URL]
    cd mt_task_alabtechnology
    ```

2.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Run the App:**
    ```bash
    flutter run
    ```

## 📦 Build Instructions (Signed APK & AAB)

The project is configured to sign the release build automatically using `key.properties`.

**To generate the builds manually:**

1.  **APK (for testing on device):**
    ```bash
    flutter build apk --release
    ```
    *Output:* `build/app/outputs/flutter-apk/app-release.apk`

2.  **AAB (for Play Store):**
    ```bash
    flutter build appbundle --release
    ```
    *Output:* `build/app/outputs/bundle/release/app-release.aab`

> **Note:** The `key.properties` and keystore file are included in the `android/` directory for the purpose of this evaluation.

## 🔔 Push Notifications Setup

The app handles notifications in three states:
1.  **Background:** System tray notification (handled by Firebase).
2.  **Terminated:** System tray notification (handled by Firebase).
3.  **Foreground:** Heads-up banner (handled by `flutter_local_notifications`).

**To Test Notifications:**
1.  Run the app and check the debug console for **FCM TOKEN**.
2.  Use Firebase Console -> Messaging to send a test message to that token.

## Images
![alt text](<WhatsApp Image 2025-11-24 at 20.12.54_87eb66f0.jpg>)

![alt text](<WhatsApp Image 2025-11-24 at 20.12.54_54451f87.jpg>)

![alt text](<WhatsApp Image 2025-11-24 at 20.12.55_951f04f2.jpg>)