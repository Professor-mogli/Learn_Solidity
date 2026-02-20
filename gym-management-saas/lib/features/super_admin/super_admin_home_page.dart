import 'package:flutter/material.dart';

import '../../core/models/app_user.dart';
import '../shared/widgets/stat_card.dart';

class SuperAdminHomePage extends StatefulWidget {
  final AppUser user;
  final VoidCallback onLogout;

  const SuperAdminHomePage({
    super.key,
    required this.user,
    required this.onLogout,
  });

  @override
  State<SuperAdminHomePage> createState() => _SuperAdminHomePageState();
}

class _SuperAdminHomePageState extends State<SuperAdminHomePage> {
  int selectedIndex = 0;

  static const items = [
    'Dashboard',
    'Gym Owners',
    'Subscription Packs',
    'Payments',
    'Reports',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: (index) => setState(() => selectedIndex = index),
            labelType: NavigationRailLabelType.all,
            destinations: items
                .map(
                  (item) => NavigationRailDestination(
                    icon: const Icon(Icons.circle_outlined, size: 14),
                    selectedIcon: const Icon(Icons.check_circle, size: 18),
                    label: Text(item),
                  ),
                )
                .toList(),
            trailing: IconButton(onPressed: widget.onLogout, icon: const Icon(Icons.logout)),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  'Super Admin Dashboard',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 16),
                const Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    StatCard(
                      label: 'Total Gyms',
                      value: '24',
                      icon: Icons.fitness_center,
                    ),
                    StatCard(
                      label: 'Active Gyms',
                      value: '21',
                      accent: Colors.green,
                      icon: Icons.verified,
                    ),
                    StatCard(
                      label: 'Inactive Gyms',
                      value: '3',
                      accent: Colors.red,
                      icon: Icons.block,
                    ),
                    StatCard(
                      label: 'Total Revenue',
                      value: '₹4,45,000',
                      accent: Colors.orange,
                      icon: Icons.currency_rupee,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Gym Owners',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                        const SizedBox(height: 12),
                        DataTable(
                          columns: const [
                            DataColumn(label: Text('Gym Name')),
                            DataColumn(label: Text('Owner')),
                            DataColumn(label: Text('Pack')),
                            DataColumn(label: Text('Status')),
                          ],
                          rows: const [
                            DataRow(cells: [
                              DataCell(Text('Iron House')),
                              DataCell(Text('Rohit Singh')),
                              DataCell(Text('Quarterly')),
                              DataCell(Text('Active')),
                            ]),
                            DataRow(cells: [
                              DataCell(Text('Power Lab')),
                              DataCell(Text('Anjali Jain')),
                              DataCell(Text('Monthly')),
                              DataCell(Text('Expiring Soon')),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
