# Quick Start Guide - Halo Clinic

Panduan singkat untuk developer yang baru clone project ini.

## TL;DR (Too Long; Didn't Read)

```bash
# 1. Clone & install
git clone https://github.com/ulililzam/halo-clinic.git
cd halo-clinic
flutter pub get

# 2. Setup Firebase (opsional, untuk notifikasi)
# Download google-services.json → android/app/
# Download GoogleService-Info.plist → ios/Runner/

# 3. Run
flutter run
```

---

## Prerequisites

- Flutter SDK 3.7.2+ ([Install Flutter](https://flutter.dev/docs/get-started/install))
- Android Studio / VS Code
- Git
- Firebase Account (hanya untuk fitur notifikasi)

---

## Setup Steps

### Step 1: Clone Repository

```bash
git clone https://github.com/ulililzam/halo-clinic.git
cd halo-clinic
```

### Step 2: Install Dependencies

```bash
flutter pub get
```

### Step 3: Setup Firebase (Opsional)

> **Skip langkah ini jika:**
> - Hanya ingin testing UI tanpa notifikasi
> - Belum punya akun Firebase
> 
> **Lakukan langkah ini jika:**
> - Ingin test fitur push notifications
> - Siap deploy untuk production

**Quick Setup:**
1. Buat Firebase project di [Firebase Console](https://console.firebase.google.com/)
2. Download file konfigurasi:
   - Android: `google-services.json` → `android/app/`
   - iOS: `GoogleService-Info.plist` → `ios/Runner/`


### Step 4: Run App

```bash
# Run di device/emulator yang terhubung
flutter run

# Atau specify platform
flutter run -d chrome          # Web browser
flutter run -d android          # Android
flutter run -d ios              # iOS (Mac only)
```

---

## Project Structure (5 Menit Tour)

```
lib/
├── main.dart                      # Entry point
└── app/
    ├── common/
    │   ├── themes/                # Colors & theme
    │   ├── utils/                 # Helpers & validators
    │   └── widgets/               # Reusable widgets
    ├── modules/
    │   ├── auth/                  # Login, Register, OTP
    │   ├── home/                  # Dashboard
    │   ├── articles/              # Health articles
    │   ├── consultation/          # Doctor consultation
    │   ├── notifications/         # FCM notifications
    │   ├── bmi/                   # BMI calculator
    │   └── ...                    # Other modules
    └── routes/
        ├── app_routes.dart        # Route constants
        └── app_pages.dart         # Route configurations
```

---

## Testing the App

### 1. Tanpa Firebase (Basic Testing)
```bash
flutter run
```
- Login bisa pakai email/password apa saja (mock data)
- Semua fitur UI bisa diakses
- Notifikasi tidak akan berfungsi

### 2. Dengan Firebase (Full Testing)
```bash
flutter run
# Tap notification icon (🔔) di dashboard
# Kirim test notification dari Firebase Console
```

---

## Common Issues & Solutions

### "MissingPluginException" atau Build Error

```bash
flutter clean
flutter pub get
cd ios && pod install
cd ..
flutter run
```

### "Firebase not initialized" (jika skip Firebase setup)

**Solusi 1 (Recommended untuk testing):** Setup Firebase mengikuti [NOTIFICATION_SETUP.md](NOTIFICATION_SETUP.md)

**Solusi 2 (Quick workaround):** Comment kode Firebase di `main.dart`:
```dart
// await Firebase.initializeApp();
// FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
```

### Android build error "minSdkVersion"

Update `android/app/build.gradle.kts`:
```kotlin
minSdk = 21
```

### iOS pod install failed

```bash
cd ios
pod deintegrate
pod install --repo-update
cd ..
```

---

## Next Steps

Setelah app berjalan, explore:

1. **Fitur Login** - Coba register & login (data dummy)
2. **Dashboard** - Explore semua menu cards
3. **Artikel Kesehatan** - Baca artikel kesehatan
4. **BMI Calculator** - Hitung BMI
5. **Tes Mental Health** - Coba tes stres/depresi
5. **Notifikasi** - Setup Firebase dan test push notification

---

## Learning Resources

| Topic | Resource |
|-------|----------|
| Flutter Basics | [Flutter Docs](https://flutter.dev/docs) |
| GetX State Management | [GetX Docs](https://pub.dev/packages/get) |
| Firebase FCM | [Firebase Messaging](https://firebase.flutter.dev/docs/messaging/overview) |
| MVVM Pattern | 
---

## Tips untuk Developer Pemula

1. **Jangan panik jika error** - Coba `flutter clean` dulu
2. **Baca error message** - Flutter error messages biasanya helpful
3. **Test di real device** - Beberapa fitur (notifikasi iOS) tidak jalan di simulator
4. **Hot reload adalah teman** - Tekan `r` di terminal untuk hot reload
5. **Lihat console log** - `print()` statements akan muncul di sini

---

## Butuh Bantuan?

- Baca dokumentasi: [README.md](README.md)
- Issue di GitHub: [Create Issue](https://github.com/ulililzam/halo-clinic/issues)

---

## Checklist Setup (Print & Check!)

- [ ] Flutter SDK installed & verified (`flutter doctor`)
- [ ] Project cloned
- [ ] Dependencies installed (`flutter pub get`)
- [ ] Firebase setup (opsional, untuk notifikasi)
- [ ] App runs successfully
- [ ] Tested basic features (login, dashboard)

---

<div align="center">
  <p>Happy Coding Bro!</p>
  <p>Made with Flutter</p>
</div>
