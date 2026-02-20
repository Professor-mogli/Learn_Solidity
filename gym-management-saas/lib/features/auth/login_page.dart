import 'package:flutter/material.dart';

import '../../core/models/app_user.dart';

class LoginPage extends StatelessWidget {
  final void Function(UserRole role) onLogin;

  const LoginPage({super.key, required this.onLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gym SaaS Login')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Demo Login (Role Based)',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => onLogin(UserRole.superAdmin),
                    child: const Text('Login as Super Admin'),
                  ),
                  ElevatedButton(
                    onPressed: () => onLogin(UserRole.gymOwner),
                    child: const Text('Login as Gym Owner'),
                  ),
                  ElevatedButton(
                    onPressed: () => onLogin(UserRole.member),
                    child: const Text('Login as Member'),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Note: QR scanner is not part of Gym Owner app. Scanner device is at gym gate.',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
