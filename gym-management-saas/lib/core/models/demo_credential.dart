import 'app_user.dart';

class DemoCredential {
  final String label;
  final UserRole role;
  final String emailOrMobile;
  final String passwordOrOtpHint;

  const DemoCredential({
    required this.label,
    required this.role,
    required this.emailOrMobile,
    required this.passwordOrOtpHint,
  });
}
