import 'package:flutter/material.dart';

import '../core/models/app_user.dart';
import '../core/services/secure_auth_service.dart';
import '../features/auth/login_page.dart';
import '../features/gym_owner/gym_owner_home_page.dart';
import '../features/member/member_home_page.dart';
import '../features/super_admin/super_admin_home_page.dart';

class GymApp extends StatefulWidget {
  const GymApp({super.key});

  @override
  State<GymApp> createState() => _GymAppState();
}

class _GymAppState extends State<GymApp> {
  final SecureAuthService _authService = SecureAuthService();
  AuthSession? _session;

  void _onAuthenticated(AuthSession session) {
    setState(() {
      _session = session;
    });
  }

  void _logout() {
    setState(() {
      _session = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Management SaaS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF4F7FE),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF4F46E5)),
      ),
      home: _session == null
          ? LoginPage(
              authService: _authService,
              onAuthenticated: _onAuthenticated,
            )
          : _homeForRole(_session!.user),
    );
  }

  Widget _homeForRole(AppUser user) {
    return switch (user.role) {
      UserRole.superAdmin => SuperAdminHomePage(
          user: user,
          onLogout: _logout,
        ),
      UserRole.gymOwner => GymOwnerHomePage(
          user: user,
          onLogout: _logout,
        ),
      UserRole.member => MemberHomePage(
          user: user,
          onLogout: _logout,
        ),
    };
  }
}
