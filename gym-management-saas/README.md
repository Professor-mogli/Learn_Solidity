# Gym Management SaaS - Secure Flutter Demo

Ye project ab aapke Figma flow ke according **production-oriented secure demo app** format me update kiya gaya hai.

## What is included now

- Multi-role app flow: Super Admin, Gym Owner, Member.
- Role-based login UI with segmented roles.
- Demo credentials autofill buttons.
- Secure login patterns in demo layer:
  - SHA-256 password hash verification
  - Constant-time hash compare
  - Failed-attempt lockout
  - Tokenized session object on successful auth
- Gym Owner app me in-app scanner **nahi** (scanner gate device pe hi rahega).
- Attendance visibility Owner + Member dono me maintained.

## Demo Credentials

### Super Admin
- Email: `admin@gymmanager.com`
- Password: `admin123`

### Gym Owner
- Email: `rajesh@ironfit.com`
- Password: `gym123`

### Gym Owner (Alt)
- Email: `priya@flexzone.com`
- Password: `gym456`

### Member (OTP Demo)
- Mobile: `+91 99887 76655`
- OTP: `1234`

## Run Instructions

```bash
cd gym-management-saas
flutter pub get
flutter run
```

### Windows support (if needed)
```bash
cd gym-management-saas
flutter config --enable-windows-desktop
flutter create --platforms=windows .
flutter pub get
flutter run -d windows
```

### Web fallback
```bash
cd gym-management-saas
flutter run -d chrome
```

## Test

```bash
cd gym-management-saas
flutter test
```

## Important production note

Ye app abhi bhi **demo backend logic** use karta hai (in-memory/auth mock style).
True production deployment ke liye still required:
- Real backend APIs + DB
- JWT/refresh token infra
- Real OTP provider
- Device/session revocation
- API gateway rate limiting
- Audit logging + SIEM integration
