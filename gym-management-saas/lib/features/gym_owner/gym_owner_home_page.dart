import 'package:flutter/material.dart';

import '../../core/models/app_user.dart';
import '../../core/services/mock_data_service.dart';
import '../shared/widgets/stat_card.dart';

class GymOwnerHomePage extends StatelessWidget {
  final AppUser user;
  final VoidCallback onLogout;

  const GymOwnerHomePage({
    super.key,
    required this.user,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final attendance = MockDataService.instance.gymAttendance(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Owner • ${user.name}'),
        actions: [
          TextButton.icon(
            onPressed: onLogout,
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF7ED),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Important: QR scanner owner app me nahi hai. Gate par dedicated scanner device lagega.',
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              StatCard(
                label: "Today's Entries",
                value: attendance.where((e) => _sameDay(e.date, DateTime.now())).length.toString(),
                icon: Icons.login,
              ),
              StatCard(
                label: 'This Month Attendance',
                value: attendance.length.toString(),
                accent: Colors.green,
                icon: Icons.calendar_month,
              ),
              const StatCard(
                label: 'Most Active Member',
                value: 'Aman Gupta',
                accent: Colors.orange,
                icon: Icons.emoji_events,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Today Attendance List',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  ...attendance.map(
                    (entry) => ListTile(
                      dense: true,
                      leading: const Icon(Icons.how_to_reg, color: Colors.green),
                      title: Text(entry.memberName),
                      subtitle: Text(
                        '${entry.date.day}/${entry.date.month}/${entry.date.year} • ${entry.checkInTime.hour.toString().padLeft(2, '0')}:${entry.checkInTime.minute.toString().padLeft(2, '0')}',
                      ),
                      trailing: const Text('Present', style: TextStyle(color: Colors.green)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static bool _sameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
