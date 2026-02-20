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
    final month = DateTime.now();
    final service = MockDataService.instance;
    final attendance = service.memberAttendance(user.id, month);
    final attendedDays = attendance.map((e) => e.date.day).toSet();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Member App'),
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
          Text('Welcome, ${user.name}', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 14),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              const StatCard(label: 'Subscription', value: 'Premium Monthly', icon: Icons.workspace_premium),
              const StatCard(label: 'Expiry Date', value: '28 Feb 2026', accent: Colors.red, icon: Icons.event_busy),
              StatCard(
                label: 'Days Attended (Month)',
                value: attendance.length.toString(),
                accent: Colors.green,
                icon: Icons.how_to_reg,
              ),
              StatCard(
                label: 'Last Visit',
                value: service.lastVisit(user.id)?.toString().split(' ').first ?? 'N/A',
                accent: Colors.orange,
                icon: Icons.history,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              leading: const Icon(Icons.qr_code_2_rounded, size: 42),
              title: const Text('My QR Code'),
              subtitle: const Text('Is QR ko gate scanner machine scan karegi.'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text('ID: m-101'),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Attendance Calendar (this month)', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      30,
                      (index) {
                        final day = index + 1;
                        final present = attendedDays.contains(day);
                        return Container(
                          width: 36,
                          height: 36,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: present ? const Color(0xFFDCFCE7) : const Color(0xFFF1F5F9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('$day', style: TextStyle(color: present ? Colors.green[800] : Colors.black54)),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text('Attendance History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          ...attendance.map(
            (entry) => ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: Text('${entry.date.day}/${entry.date.month}/${entry.date.year}'),
              subtitle: Text('Check-in: ${entry.checkInTime.hour.toString().padLeft(2, '0')}:${entry.checkInTime.minute.toString().padLeft(2, '0')}'),
            ),
          ),
        ],
      ),
    );
  }
}
