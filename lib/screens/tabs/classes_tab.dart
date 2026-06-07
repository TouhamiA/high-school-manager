import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class ClassesTab extends StatelessWidget {
  const ClassesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final classes = [
      {'name': '1st Year A', 'teacher': 'Fatima Teacher', 'students': '30'},
      {'name': '1st Year B', 'teacher': 'Ahmed Teacher', 'students': '28'},
      {'name': '2nd Year A', 'teacher': 'Sara Teacher', 'students': '32'},
      {'name': '3rd Year A', 'teacher': 'Mohammed Teacher', 'students': '25'},
    ];

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.translate('classes'),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add),
                  label: Text(l10n.translate('add')),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: classes.length,
              itemBuilder: (context, index) {
                final classItem = classes[index];
                return Card(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.withOpacity(0.1),
                          Colors.purple.withOpacity(0.1),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          classItem['name']!,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          classItem['teacher']!,
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Chip(
                          label: Text('${classItem['students']} students'),
                        ),
                      ],
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
