import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class ScheduleTab extends StatelessWidget {
  const ScheduleTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final schedule = [
      {
        'day': 'Monday',
        'class': 'Math',
        'time': '08:00 - 09:00',
        'room': 'Room 101'
      },
      {
        'day': 'Monday',
        'class': 'English',
        'time': '09:15 - 10:15',
        'room': 'Room 102'
      },
      {
        'day': 'Tuesday',
        'class': 'Science',
        'time': '08:00 - 09:00',
        'room': 'Lab 1'
      },
      {
        'day': 'Tuesday',
        'class': 'History',
        'time': '09:15 - 10:15',
        'room': 'Room 103'
      },
      {
        'day': 'Wednesday',
        'class': 'PE',
        'time': '08:00 - 09:00',
        'room': 'Gym'
      },
    ];

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.translate('schedule'),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: schedule.length,
              itemBuilder: (context, index) {
                final item = schedule[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.schedule,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    title: Text(item['class']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item['day']!),
                        Text(item['time']!),
                      ],
                    ),
                    trailing: Chip(
                      label: Text(item['room']!),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
