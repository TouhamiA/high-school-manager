import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
import '../../models/user_model.dart';
import '../../providers/user_provider.dart';
import '../../widgets/user_dialog.dart';

class UsersTab extends StatelessWidget {
  const UsersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final users = Provider.of<UserProvider>(context).users;

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
                  l10n.translate('users'),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                ElevatedButton.icon(
                  onPressed: () => _showUserDialog(context, null),
                  icon: const Icon(Icons.add),
                  label: Text(l10n.translate('add')),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(user.name[0]),
                    ),
                    title: Text(user.name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(user.email),
                        Text(user.role),
                      ],
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text(l10n.translate('edit')),
                          onTap: () => _showUserDialog(context, user),
                        ),
                        PopupMenuItem(
                          child: Text(l10n.translate('delete')),
                          onTap: () => _showDeleteDialog(context, user),
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

  void _showUserDialog(BuildContext context, UserModel? user) {
    showDialog(
      context: context,
      builder: (context) => UserDialog(user: user),
    );
  }

  void _showDeleteDialog(BuildContext context, UserModel user) {
    final l10n = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.translate('delete')),
        content: Text(l10n.translate('confirm_delete')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.translate('cancel')),
          ),
          TextButton(
            onPressed: () {
              Provider.of<UserProvider>(context, listen: false)
                  .deleteUser(user.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.translate('success'))),
              );
            },
            child: Text(l10n.translate('delete')),
          ),
        ],
      ),
    );
  }
}
