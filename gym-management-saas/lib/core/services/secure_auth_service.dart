import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

import '../models/app_user.dart';
import '../models/demo_credential.dart';

class AuthSession {
  final AppUser user;
  final String accessToken;
  final DateTime issuedAt;

  const AuthSession({
    required this.user,
    required this.accessToken,
    required this.issuedAt,
  });
}

class SecureAuthService {
  static const _maxFailedAttempts = 5;

  final Map<String, int> _failedAttemptsById = {};

  static const demoCredentials = [
    DemoCredential(
      label: 'Super Admin',
      role: UserRole.superAdmin,
      emailOrMobile: 'admin@gymmanager.com',
      passwordOrOtpHint: 'admin123',
    ),
    DemoCredential(
      label: 'Gym Owner 1',
      role: UserRole.gymOwner,
      emailOrMobile: 'rajesh@ironfit.com',
      passwordOrOtpHint: 'gym123',
    ),
    DemoCredential(
      label: 'Gym Owner 2',
      role: UserRole.gymOwner,
      emailOrMobile: 'priya@flexzone.com',
      passwordOrOtpHint: 'gym456',
    ),
    DemoCredential(
      label: 'Member (OTP demo)',
      role: UserRole.member,
      emailOrMobile: '+91 99887 76655',
      passwordOrOtpHint: 'Use OTP: 1234',
    ),
  ];

  AuthSession? loginWithPassword({
    required UserRole role,
    required String identity,
    required String password,
  }) {
    final normalizedIdentity = identity.trim().toLowerCase();

    if (_isLocked(normalizedIdentity)) {
      return null;
    }

    final passwordHash = sha256.convert(utf8.encode(password)).toString();

    if (role == UserRole.superAdmin &&
        normalizedIdentity == 'admin@gymmanager.com' &&
        _secureEquals(
          passwordHash,
          '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9',
        )) {
      _failedAttemptsById.remove(normalizedIdentity);
      return _issue(
        const AppUser(
          id: 'sa-001',
          name: 'Super Admin',
          role: UserRole.superAdmin,
          gymId: 'all',
        ),
      );
    }

    if (role == UserRole.gymOwner &&
        normalizedIdentity == 'rajesh@ironfit.com' &&
        _secureEquals(
          passwordHash,
          '6feda8bf94fb8a974abada66419ab2962729a96edde574e251bad0a8bfc5fb07',
        )) {
      _failedAttemptsById.remove(normalizedIdentity);
      return _issue(
        const AppUser(
          id: 'gym-1',
          name: 'Rajesh Kumar',
          role: UserRole.gymOwner,
          gymId: 'gym-1',
        ),
      );
    }

    if (role == UserRole.gymOwner &&
        normalizedIdentity == 'priya@flexzone.com' &&
        _secureEquals(
          passwordHash,
          '77d093147c06f06e359fb2b2f2389d544bad12af14852c2332a571587e7adbfd',
        )) {
      _failedAttemptsById.remove(normalizedIdentity);
      return _issue(
        const AppUser(
          id: 'gym-2',
          name: 'Priya Sharma',
          role: UserRole.gymOwner,
          gymId: 'gym-2',
        ),
      );
    }

    _failedAttemptsById[normalizedIdentity] =
        (_failedAttemptsById[normalizedIdentity] ?? 0) + 1;
    return null;
  }

  AuthSession? loginMemberWithOtp({
    required String mobile,
    required String otp,
  }) {
    final normalizedIdentity = mobile.replaceAll(' ', '');

    if (_isLocked(normalizedIdentity)) {
      return null;
    }

    if (normalizedIdentity.endsWith('9988776655') && otp.trim() == '1234') {
      _failedAttemptsById.remove(normalizedIdentity);
      return _issue(
        const AppUser(
          id: 'mem-1',
          name: 'Amit Patel',
          role: UserRole.member,
          gymId: 'gym-1',
        ),
      );
    }

    _failedAttemptsById[normalizedIdentity] =
        (_failedAttemptsById[normalizedIdentity] ?? 0) + 1;
    return null;
  }

  bool isLockedOut(String identity) {
    final normalized = identity.trim().toLowerCase().replaceAll(' ', '');
    return _isLocked(normalized);
  }

  bool _isLocked(String normalizedIdentity) {
    return (_failedAttemptsById[normalizedIdentity] ?? 0) >= _maxFailedAttempts;
  }

  AuthSession _issue(AppUser user) {
    final now = DateTime.now();
    final random = Random.secure();
    final tokenBytes = List<int>.generate(32, (_) => random.nextInt(256));
    return AuthSession(
      user: user,
      accessToken: base64UrlEncode(tokenBytes),
      issuedAt: now,
    );
  }

  bool _secureEquals(String a, String b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
    }
    return diff == 0;
  }
}
