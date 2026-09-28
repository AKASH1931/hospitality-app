# Hospitality Hire App (Frontend Only MVP)

Direct Hire flow: Brands chefs, waiters, bartenders, housekeeping, decor vendors ko search karke direct book kar sakte hain.

## Status
- Flutter UI ready (Provider + dummy data)
- Backend abhi nahi hai. Bookings memory me hain (restart par clear).

## Chalane ke liye (Windows)

1. Flutter SDK install karo:
   - https://docs.flutter.dev/get-started/install/windows se Flutter download karo
   - `flutter doctor` chalao, Android Studio + Java install karo

2. Phir:
```powershell
cd C:\Users\Saravanan\hospitality_app
flutter create --project-name hospitality_app .
flutter pub get
flutter run
```

> Note: `flutter create .` android/ ios/ folders bana dega (ye abhi intentionally nahi banaye taaki naam baad me change ho sake).

## Structure
- lib/main.dart - entry
- lib/data/dummy_data.dart - 8 demo workers
- lib/data/app_state.dart - role, bookings, favorites
- lib/screens/ - role_select, home_shell, home, search, worker_detail, booking, bookings, profile
- lib/widgets/worker_card.dart

## Next (Backend)
- Firebase Auth (Phone OTP) + Firestore: users, workers, bookings collections
- Storage: profile photos, decor portfolio
- Push: booking confirm notification
Batao jab backend chahiye, main Firebase wala code jod dunga.
