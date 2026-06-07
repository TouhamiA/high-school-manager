import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';
import '../../providers/theme_provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            l10n.translate('settings'),
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.translate('language'),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      _LanguageButton(
                        label: 'English',
                        isSelected:
                            localeProvider.locale.languageCode == 'en',
                        onPressed: () {
                          localeProvider.setLocale(const Locale('en'));
                        },
                      ),
                      _LanguageButton(
                        label: 'العربية',
                        isSelected:
                            localeProvider.locale.languageCode == 'ar',
                        onPressed: () {
                          localeProvider.setLocale(const Locale('ar'));
                        },
                      ),
                      _LanguageButton(
                        label: 'Français',
                        isSelected:
                            localeProvider.locale.languageCode == 'fr',
                        onPressed: () {
                          localeProvider.setLocale(const Locale('fr'));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              title: Text(l10n.translate('theme')),
              subtitle: Text(
                themeProvider.themeMode == ThemeMode.system
                    ? 'System'
                    : themeProvider.themeMode == ThemeMode.dark
                        ? 'Dark'
                        : 'Light',
              ),
              trailing: DropdownButton<ThemeMode>(
                value: themeProvider.themeMode,
                items: const [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text('System'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text('Light'),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text('Dark'),
                  ),
                ],
                onChanged: (ThemeMode? mode) {
                  if (mode != null) {
                    themeProvider.setThemeMode(mode);
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              title: Text(l10n.translate('profile')),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {},
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login', (route) => false);
            },
            child: Text(
              l10n.translate('logout'),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const _LanguageButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.surface,
        foregroundColor: isSelected
            ? Colors.white
            : Theme.of(context).colorScheme.onSurface,
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
