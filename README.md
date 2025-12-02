# Halo Clinic - Healthcare Application

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" />
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" />
  <img src="https://img.shields.io/badge/GetX-8A2BE2?style=for-the-badge" />
</div>

## About

Halo Clinic adalah aplikasi kesehatan berbasis Flutter yang mengusung arsitektur MVVM dengan GetX. Fokus proyek ini adalah menyediakan fondasi fitur-fitur inti (autentikasi, konsultasi dokter, artikel kesehatan, dan penunjang lain) menggunakan data mock sehingga tim lain dapat langsung mengembangkan backend tanpa harus menyiapkan UI lagi.

## Tech Stack

- Flutter 3.7.2+
- Dart 3
- GetX (state management, routing, DI)
- HTTP & Shared Preferences
- MVVM + modular folder structure

## Fitur Utama

- **Authentication** - Login, Register, Forgot Password
- **Dashboard** - Quick access ke semua fitur
- **Artikel Kesehatan** - Baca artikel kesehatan terkini
- **BMI** - Ukur Berat ideal
- **Tes Kesehatan Mental** - Tes Stres, Tes Depresi
- **Konsultasi Dokter** - Booking konsultasi dengan dokter
- **Push Notifications** - Real-time notifications dengan Firebase FCM
- **Profile** - Manage profil dan pengaturan


## Arsitektur

Project ini menggunakan **MVVM Pattern** dengan struktur:

```
View (UI) 
  ↓
ViewModel/Controller (State Management)
  ↓
Service (Business Logic & API)
  ↓
Model (Data Structure)
```

## Struktur Project

```
lib/
├── main.dart
└── app/
    ├── common/
    ├── data/
    ├── models/
    ├── modules/
    └── routes/
```

### Penjelasan folder `lib`

- `main.dart` – entry point aplikasi yang melakukan inisialisasi GetMaterialApp, tema global, serta daftar routing awal.
- `app/common` – resource lintas fitur: tema warna (`themes/`), utilitas seperti formatter dan validator (`utils/`), dan widget reusable (`widgets/`).
- `app/data/models` – data object sederhana yang tidak terikat pada satu fitur, misalnya `AddressModel`, `CartItemModel`, hingga `MedicineModel`.
- `app/models` – model generik tingkat aplikasi seperti `NavigationItem` untuk bottom navigation.
- `app/modules` – setiap fitur utama berada di subfolder sendiri dengan struktur konsisten `bindings/`, `controllers/`, `models/`, `views/`, dan `widgets/`. Contoh:
  - `articles` memuat list/detail artikel beserta widget pendukung.
  - `auth` berisi alur onboarding, login, OTP, dan service autentikasi.
  - `consultation`, `cart`, `medicine`, `profile`, `depression_test`, `stress_test`, `support`, `home`, `bmi`, dll. masing-masing menangani layar dan logika khusus fitur tersebut.
- `app/routes` – deklarasi konstanta route (`app_routes.dart`) dan konfigurasi GetX page (`app_pages.dart`).

**Lihat dokumentasi lengkap:**
- [STRUKTUR_PROJECT.md](STRUKTUR_PROJECT.md) - Struktur lengkap & penjelasan
- [CHEATSHEET.md](CHEATSHEET.md) - Quick reference untuk development
- [NOTIFICATION_SETUP.md](NOTIFICATION_SETUP.md) - Setup Firebase & Push Notifications (Developer Friendly!)
- [staterpack.md](staterpack.md) - MVVM guide lengkap

## Menjalankan Proyek

### 1. Persyaratan dasar
- Flutter SDK 3.7.2+ (cek dengan `flutter --version`)
- Android Studio / VS Code dengan Flutter extension
- Emulator Android/iOS atau perangkat fisik
- **Firebase Project** (untuk fitur notifikasi) - [Setup Guide](NOTIFICATION_SETUP.md)

### 2. Clone & instalasi dependencies
```bash
git clone <repository-url>
cd halo_clinic
flutter pub get
```

### 3. Setup Firebase (untuk notifikasi)
> **Penting untuk developer pemula!** Ikuti panduan lengkap di [NOTIFICATION_SETUP.md](NOTIFICATION_SETUP.md)

Quick setup:
1. Download `google-services.json` dari Firebase Console
2. Letakkan di `android/app/google-services.json`
3. Download `GoogleService-Info.plist` dari Firebase Console
4. Letakkan di `ios/Runner/GoogleService-Info.plist`

### 4. Jalankan aplikasi
```bash
# Run di perangkat yang terdeteksi otomatis
flutter run

# Atau pilih target tertentu
flutter run -d chrome      # Web
flutter run -d ios         # iOS Simulator
flutter run -d emulator-5554  # Android emulator
```

### 5. Build paket rilis
```bash
flutter build apk --release
flutter build ios --release   # membutuhkan Xcode + akun Apple
```

> Tips: gunakan `flutter clean` sebelum build rilis jika berpindah channel/branch.

## Dependencies

```yaml
get: ^4.6.5                    # State management & routing
http: ^1.1.0                   # HTTP client
shared_preferences: ^2.2.2     # Local storage
intl: ^0.19.0                  # Date/number formatting
firebase_core: ^2.32.0         # Firebase core
firebase_messaging: ^14.7.10   # Push notifications
flutter_fcm_notifications:     # Custom FCM plugin
  git:
    url: https://github.com/ulililzam/flutter_fcm_notifications.git
    ref: main
```

## Alur Navigasi

```
Login → Register / Forgot Password
  ↓
Home (Bottom Navigation)
  ├─ Dashboard
  ├─ Obat
  ├─ Consultation
  ├─ Support
  └─ Profile → Logout
```


## Development

### Add New Feature
## Todo / Roadmap

- [ ] Integrate dengan backend API
- [x] Implement push notifications (Firebase FCM)
- [ ] Add unit tests
- [ ] Add integration tests
- [ ] Implement CI/CDe guide
- Use `const` constructors
- Implement proper error handling
- Add comments untuk kode kompleks

## Todo / Roadmap

- [ ] Integrate dengan backend API
- [ ] Add unit tests
- [ ] Add integration tests
- [ ] Implement CI/CD

## Known Issues

- Mock data digunakan untuk development
- Backend API belum terintegrasi

## License

This project is licensed under the MIT License.

<div align="center">
  Made with Flutter
</div>
