# Gym Management SaaS - Flutter MVP

Ye folder ab ek **runnable Flutter app MVP** provide karta hai jo aapke दिए हुए product plan par based hai.

## ✅ Aapke latest feedback ke hisaab se kya change hua

- Gym Owner app se QR scanner hata diya gaya hai.
- QR scanner ko gate device flow ke hisaab se treat kiya gaya hai.
- Member app me QR show hota hai (entry ke liye).
- Attendance data Gym Owner aur Member dono ko dikh raha hai.

## Features in this MVP

### 1) Super Admin
- Dashboard cards: total gyms, active/inactive gyms, revenue.

### 2) Gym Owner
- Dashboard summary cards.
- Attendance list visible (today/month style summary + recent entries).
- Note shown clearly: scanner owner app me nahi hai.

### 3) Member
- Dashboard cards: plan, days left, total days attended, last visit.
- Entry QR display card.
- Attendance history list visible.

## Project Structure

- `lib/main.dart` - entry point
- `lib/app/gym_app.dart` - role-based app flow
- `lib/features/auth/login_page.dart` - demo role login
- `lib/features/super_admin/` - super admin dashboard
- `lib/features/gym_owner/` - owner dashboard + attendance visibility
- `lib/features/member/` - member dashboard + QR + attendance visibility
- `lib/core/services/mock_data_service.dart` - shared attendance mock state

## Run Instructions (Step-by-step)

### Prerequisites
1. Flutter SDK (stable) installed
2. Dart SDK (comes with Flutter)
3. Android Studio / VS Code + emulator (or physical device)

### Run
```bash
cd gym-management-saas
flutter pub get
flutter run
```

### Tests
```bash
cd gym-management-saas
flutter test
```

## Important note for production build

Current app uses mock data to demonstrate end-to-end flow. Production ke liye:
- Backend APIs connect karne honge
- Secure auth (JWT + refresh + OTP)
- Tenant isolation on server
- Real gate scanner service integration
