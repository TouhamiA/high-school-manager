import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n/app_localizations.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';

class UserDialog extends StatefulWidget {
  final UserModel? user;

  const UserDialog({Key? key, this.user}) : super(key: key);

  @override
  State<UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends State<UserDialog> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late String _selectedRole;
  late String _selectedStatus;

  final _roles = ['admin', 'teacher', 'student', 'parent', 'staff'];
  final _statuses = ['active', 'inactive'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user?.name ?? '');
    _emailController = TextEditingController(text: widget.user?.email ?? '');
    _phoneController = TextEditingController(text: widget.user?.phone ?? '');
    _selectedRole = widget.user?.role ?? 'student';
    _selectedStatus = widget.user?.status ?? 'active';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isEditing = widget.user != null;

    return AlertDialog(
      title: Text(isEditing ? l10n.translate('edit') : l10n.translate('add')),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: l10n.translate('name'),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: l10n.translate('email'),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: l10n.translate('phone'),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              items: _roles
                  .map((role) => DropdownMenuItem(
                        value: role,
                        child: Text(role),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => _selectedRole = value ?? 'student');
              },
              decoration: InputDecoration(
                labelText: l10n.translate('role'),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              items: _statuses
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => _selectedStatus = value ?? 'active');
              },
              decoration: InputDecoration(
                labelText: l10n.translate('status'),
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.translate('cancel')),
        ),
        ElevatedButton(
          onPressed: _saveUser,
          child: Text(l10n.translate('save')),
        ),
      ],
    );
  }

  void _saveUser() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final l10n = AppLocalizations.of(context);

    if (_nameController.text.isEmpty || _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.translate('error'))),
      );
      return;
    }

    final user = UserModel(
      id: widget.user?.id ?? DateTime.now().toString(),
      name: _nameController.text,
      email: _emailController.text,
      role: _selectedRole,
      phone: _phoneController.text,
      status: _selectedStatus,
    );

    if (widget.user != null) {
      userProvider.updateUser(user);
    } else {
      userProvider.addUser(user);
    }

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.translate('success'))),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
