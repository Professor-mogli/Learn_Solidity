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
    final service = MockDataService.instance;
    final month = DateTime.now();
    final attendance = service.gymAttendance(month);

    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Owner - ${user.name}'),
        actions: [
          IconButton(onPressed: onLogout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Dashboard',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(height: 8),
          const Text(
            'QR scanner gate device par hoga. Is app me scan module nahi diya gaya hai.',
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              StatCard(
                label: "Today's Attendance",
                value: attendance
                    .where((a) => _sameDay(a.date, DateTime.now()))
                    .length
                    .toString(),
              ),
              StatCard(
                label: 'This Month Attendance',
                value: attendance.length.toString(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Recent Attendance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          ...attendance.map(
            (a) => Card(
              child: ListTile(
                leading: const Icon(Icons.how_to_reg, color: Colors.green),
                title: Text(a.memberName),
                subtitle: Text(
                  '${a.date.day}/${a.date.month}/${a.date.year} • ${a.checkInTime.hour.toString().padLeft(2, '0')}:${a.checkInTime.minute.toString().padLeft(2, '0')}',
                ),
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
