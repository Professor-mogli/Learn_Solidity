import 'package:flutter/material.dart';

import '../core/models/app_user.dart';
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
  AppUser? _user;

  void _handleLogin(UserRole role) {
    setState(() {
      switch (role) {
        case UserRole.superAdmin:
          _user = const AppUser(
            id: 'u-1',
            name: 'Super Admin',
            role: UserRole.superAdmin,
            gymId: 'all',
          );
          break;
        case UserRole.gymOwner:
          _user = const AppUser(
            id: 'u-2',
            name: 'Rohit Singh',
            role: UserRole.gymOwner,
            gymId: 'g-100',
          );
          break;
        case UserRole.member:
          _user = const AppUser(
            id: 'm-101',
            name: 'Aman Gupta',
            role: UserRole.member,
            gymId: 'g-100',
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Management SaaS',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: _user == null
          ? LoginPage(onLogin: _handleLogin)
          : switch (_user!.role) {
              UserRole.superAdmin => SuperAdminHomePage(
                  user: _user!,
                  onLogout: () => setState(() => _user = null),
                ),
              UserRole.gymOwner => GymOwnerHomePage(
                  user: _user!,
                  onLogout: () => setState(() => _user = null),
                ),
              UserRole.member => MemberHomePage(
                  user: _user!,
                  onLogout: () => setState(() => _user = null),
                ),
            },
    );
  }
}
