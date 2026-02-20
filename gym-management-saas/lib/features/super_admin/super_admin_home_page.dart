import 'package:flutter/material.dart';

import '../../core/models/app_user.dart';
import '../shared/widgets/stat_card.dart';

class SuperAdminHomePage extends StatelessWidget {
  final AppUser user;
  final VoidCallback onLogout;

  const SuperAdminHomePage({
    super.key,
    required this.user,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Super Admin Dashboard'),
        actions: [
          IconButton(onPressed: onLogout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              StatCard(label: 'Total Gyms', value: '24'),
              StatCard(label: 'Active Gyms', value: '21'),
              StatCard(label: 'Inactive Gyms', value: '3'),
              StatCard(label: 'Total Revenue', value: '₹4,45,000'),
            ],
          ),
        ],
      ),
    );
  }
}
