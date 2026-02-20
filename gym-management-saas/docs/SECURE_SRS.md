# Secure Technical SRS - Gym Management SaaS

## 1. Product Type
- Multi-tenant SaaS
- One platform, multiple gyms, strict tenant isolation

## 2. Roles & Access

### Super Admin
- Manage gym owners
- Manage subscription packs
- Activate/deactivate gyms
- View global analytics, payments, reports

### Gym Owner
- Manage own gym profile
- Add/manage members
- QR scan for attendance
- View attendance and revenue reports

### Gym Member
- OTP login
- View subscription, QR, and attendance
- Update profile

## 3. Critical Security Requirements

- RBAC authorization enforced at backend and app routing layer
- Tenant scope check (`gymId`) for all owner/member queries
- OTP login with expiration and attempt limits
- JWT tokens with short-lived access tokens
- Refresh token rotation and revocation support
- Brute-force protection, API throttling, and suspicious login alerting
- Audit logs for admin actions and attendance scans

## 4. QR + Attendance Validation Flow

1. Member presents QR at gym gate.
2. Gym owner scans QR.
3. Backend validates:
   - Gym status is active
   - Member belongs to same gym
   - Member subscription is active and not expired
4. If valid:
   - Access granted response
   - Attendance marked (first scan only for day)
5. If invalid:
   - Access denied with reason

## 5. Attendance Business Rules

- Unique rule: (`gym_id`, `member_id`, `date`) must be unique.
- Same day multiple scans should return existing present record.
- Attendance must be visible to both member and owner immediately.
- Attendance summary metrics:
  - Total present days (month)
  - Last visit date
  - Attendance percentage
  - Date-wise history

## 6. Suggested API Contracts

- `POST /auth/login` (admin/owner)
- `POST /auth/member/request-otp`
- `POST /auth/member/verify-otp`
- `POST /scan/qr-entry`
- `GET /owner/attendance?date=YYYY-MM-DD`
- `GET /owner/attendance/member/:memberId?month=YYYY-MM`
- `GET /member/attendance?month=YYYY-MM`
- `GET /member/dashboard`

## 7. Database (High-level)

- `users`
- `gyms`
- `subscription_packs`
- `gym_subscriptions`
- `members`
- `member_subscriptions`
- `attendance_logs`
- `payments`

### Attendance Table (required)

`attendance_logs`
- `id`
- `gym_id`
- `member_id`
- `attendance_date`
- `check_in_time`
- `status` (present)
- `source` (qr_scan)
- `created_at`

## 8. UI Deliverables

### Super Admin
- Login
- Dashboard
- Gym list/create/edit
- Pack management
- Reports

### Gym Owner
- Login
- Dashboard
- Members list/add/edit
- QR scanner
- Attendance page (today + monthly + member detail)
- Reports

### Member
- OTP login
- Dashboard (subscription + QR + days left)
- Attendance page (calendar + list + summary)
- Profile page

## 9. Non-Functional Requirements

- Response time under 300 ms for scan validations (p95 target)
- Mobile responsive design
- Dark mode support
- 99.9% availability target
- Daily encrypted backups
