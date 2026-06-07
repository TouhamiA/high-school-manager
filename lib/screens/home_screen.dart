import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../providers/user_provider.dart';
import 'tabs/dashboard_tab.dart';
import 'tabs/users_tab.dart';
import 'tabs/classes_tab.dart';
import 'tabs/schedule_tab.dart';
import 'tabs/settings_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currentUser = Provider.of<UserProvider>(context).currentUser;

    final tabs = const [
      DashboardTab(),
      UsersTab(),
      ClassesTab(),
      ScheduleTab(),
      SettingsTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.translate('app_title')),
        elevation: 0,
        actions: [
          if (currentUser != null)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  currentUser.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ),
        ],
      ),
      body: tabs[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedIndex: _selectedIndex,
        destinations: [
          NavigationDestination(
            selectedIcon: const Icon(Icons.dashboard),
            icon: const Icon(Icons.dashboard_outlined),
            label: l10n.translate('dashboard'),
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.people),
            icon: const Icon(Icons.people_outlined),
            label: l10n.translate('users'),
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.class_),
            icon: const Icon(Icons.class_outlined),
            label: l10n.translate('classes'),
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.schedule),
            icon: const Icon(Icons.schedule_outlined),
            label: l10n.translate('schedule'),
          ),
          NavigationDestination(
            selectedIcon: const Icon(Icons.settings),
            icon: const Icon(Icons.settings_outlined),
            label: l10n.translate('settings'),
          ),
        ],
      ),
    );
  }
}
