import 'package:flutter/material.dart';

import '../../core/models/app_user.dart';
import '../../core/services/secure_auth_service.dart';

class LoginPage extends StatefulWidget {
  final SecureAuthService authService;
  final void Function(AuthSession session) onAuthenticated;

  const LoginPage({
    super.key,
    required this.authService,
    required this.onAuthenticated,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserRole _role = UserRole.superAdmin;
  final _identityController = TextEditingController();
  final _passwordOrOtpController = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _identityController.dispose();
    _passwordOrOtpController.dispose();
    super.dispose();
  }

  void _applyDemo(UserRole role) {
    final cred = SecureAuthService.demoCredentials.firstWhere((c) => c.role == role);
    setState(() {
      _role = role;
      _identityController.text = cred.emailOrMobile;
      _passwordOrOtpController.text =
          role == UserRole.member ? '1234' : cred.passwordOrOtpHint;
      _error = null;
    });
  }

  void _submit() {
    final identity = _identityController.text;
    final passOrOtp = _passwordOrOtpController.text;

    if (identity.isEmpty || passOrOtp.isEmpty) {
      setState(() => _error = 'Please fill required fields.');
      return;
    }

    final session = _role == UserRole.member
        ? widget.authService.loginMemberWithOtp(mobile: identity, otp: passOrOtp)
        : widget.authService
            .loginWithPassword(role: _role, identity: identity, password: passOrOtp);

    if (session == null) {
      final locked = widget.authService.isLockedOut(identity);
      setState(
        () => _error = locked
            ? 'Account temporarily locked due to too many attempts.'
            : 'Invalid credentials or access is inactive.',
      );
      return;
    }

    widget.onAuthenticated(session);
  }

  @override
  Widget build(BuildContext context) {
    final isMember = _role == UserRole.member;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 880),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gym Management SaaS',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Production-oriented demo with role-based login and secure session patterns.',
                      style: TextStyle(color: Color(0xFF475569)),
                    ),
                    const SizedBox(height: 16),
                    SegmentedButton<UserRole>(
                      segments: const [
                        ButtonSegment(
                          value: UserRole.superAdmin,
                          label: Text('Super Admin'),
                        ),
                        ButtonSegment(
                          value: UserRole.gymOwner,
                          label: Text('Gym Owner'),
                        ),
                        ButtonSegment(
                          value: UserRole.member,
                          label: Text('Member'),
                        ),
                      ],
                      selected: {_role},
                      onSelectionChanged: (selected) {
                        setState(() {
                          _role = selected.first;
                          _error = null;
                          _identityController.clear();
                          _passwordOrOtpController.clear();
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _identityController,
                      decoration: InputDecoration(
                        labelText: isMember ? 'Mobile Number' : 'Email',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _passwordOrOtpController,
                      obscureText: !isMember,
                      decoration: InputDecoration(
                        labelText: isMember ? 'OTP' : 'Password',
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_error != null)
                      Text(_error!, style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        child: Text(isMember ? 'Verify OTP' : 'Login'),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        OutlinedButton(
                          onPressed: () => _applyDemo(UserRole.superAdmin),
                          child: const Text('Use Admin Demo'),
                        ),
                        OutlinedButton(
                          onPressed: () => _applyDemo(UserRole.gymOwner),
                          child: const Text('Use Owner Demo'),
                        ),
                        OutlinedButton(
                          onPressed: () => _applyDemo(UserRole.member),
                          child: const Text('Use Member Demo'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Security Notes: Role-based access, lockout after failed attempts, constant-time hash compare, tokenized sessions.',
                      style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
