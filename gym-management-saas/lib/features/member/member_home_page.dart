import 'package:flutter/material.dart';

import '../../core/models/app_user.dart';
import '../../core/services/mock_data_service.dart';
import '../shared/widgets/stat_card.dart';

class MemberHomePage extends StatelessWidget {
  final AppUser user;
  final VoidCallback onLogout;

  const MemberHomePage({
    super.key,
    required this.user,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final service = MockDataService.instance;
    final month = DateTime.now();
    final attendance = service.memberAttendance(user.id, month);
    final lastVisit = service.lastVisit(user.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Member - ${user.name}'),
        actions: [
          IconButton(onPressed: onLogout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('My Dashboard',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              StatCard(label: 'Plan', value: 'Premium Monthly'),
              StatCard(label: 'Days Left', value: '18'),
              StatCard(
                label: 'Total Days Attended',
                value: attendance.length.toString(),
              ),
              StatCard(
                label: 'Last Visit',
                value: lastVisit == null
                    ? 'N/A'
                    : '${lastVisit.day}/${lastVisit.month}/${lastVisit.year}',
              ),
            ],
          ),
          const SizedBox(height: 18),
          Card(
            child: ListTile(
              leading: const Icon(Icons.qr_code_2, size: 40),
              title: const Text('My Entry QR'),
              subtitle: const Text('This QR is scanned by gate scanner device.'),
              trailing: const Text('ID: m-101'),
            ),
          ),
          const SizedBox(height: 18),
          const Text('My Attendance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          ...attendance.map(
            (a) => ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: Text('${a.date.day}/${a.date.month}/${a.date.year}'),
              subtitle: Text(
                'Check-in ${a.checkInTime.hour.toString().padLeft(2, '0')}:${a.checkInTime.minute.toString().padLeft(2, '0')}',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
