import 'package:flutter/material.dart';
import '../models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserProvider extends ChangeNotifier {
  List<UserModel> _users = [];
  UserModel? _currentUser;

  List<UserModel> get users => _users;
  UserModel? get currentUser => _currentUser;

  UserProvider() {
    _initializeUsers();
  }

  Future<void> _initializeUsers() async {
    await _loadUsers();
    if (_users.isEmpty) {
      _initializeSampleUsers();
      await _saveUsers();
    }
  }

  void _initializeSampleUsers() {
    _users = [
      UserModel(
        id: '1',
        name: 'Ahmed Admin',
        email: 'admin@school.com',
        role: 'admin',
        phone: '+212 6 12 34 56 78',
        status: 'active',
      ),
      UserModel(
        id: '2',
        name: 'Fatima Teacher',
        email: 'fatima@school.com',
        role: 'teacher',
        phone: '+212 6 87 65 43 21',
        status: 'active',
      ),
      UserModel(
        id: '3',
        name: 'Mohamed Student',
        email: 'student1@school.com',
        role: 'student',
        phone: '+212 6 55 55 55 55',
        status: 'active',
      ),
      UserModel(
        id: '4',
        name: 'Aisha Parent',
        email: 'parent@school.com',
        role: 'parent',
        phone: '+212 6 99 99 99 99',
        status: 'active',
      ),
      UserModel(
        id: '5',
        name: 'Hassan Staff',
        email: 'staff@school.com',
        role: 'staff',
        phone: '+212 6 77 77 77 77',
        status: 'active',
      ),
      UserModel(
        id: '6',
        name: 'Zahra Teacher',
        email: 'zahra@school.com',
        role: 'teacher',
        phone: '+212 6 11 11 11 11',
        status: 'active',
      ),
      UserModel(
        id: '7',
        name: 'Karim Student',
        email: 'student2@school.com',
        role: 'student',
        phone: '+212 6 22 22 22 22',
        status: 'active',
      ),
      UserModel(
        id: '8',
        name: 'Noor Parent',
        email: 'parent2@school.com',
        role: 'parent',
        phone: '+212 6 33 33 33 33',
        status: 'active',
      ),
      UserModel(
        id: '9',
        name: 'Omar Staff',
        email: 'staff2@school.com',
        role: 'staff',
        phone: '+212 6 44 44 44 44',
        status: 'inactive',
      ),
      UserModel(
        id: '10',
        name: 'Layla Teacher',
        email: 'layla@school.com',
        role: 'teacher',
        phone: '+212 6 55 66 77 88',
        status: 'active',
      ),
    ];
    notifyListeners();
  }

  void addUser(UserModel user) {
    _users.add(user);
    _saveUsers();
    notifyListeners();
  }

  void updateUser(UserModel user) {
    final index = _users.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _users[index] = user;
      _saveUsers();
      notifyListeners();
    }
  }

  void deleteUser(String id) {
    _users.removeWhere((u) => u.id == id);
    _saveUsers();
    notifyListeners();
  }

  void setCurrentUser(UserModel user) {
    _currentUser = user;
    notifyListeners();
  }

  Future<void> _saveUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = jsonEncode(_users.map((u) => u.toJson()).toList());
    await prefs.setString('users', usersJson);
  }

  Future<void> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('users');
    if (usersJson != null) {
      final List<dynamic> decodedList = jsonDecode(usersJson);
      _users = decodedList
          .map((userJson) => UserModel.fromJson(userJson))
          .toList();
    }
    notifyListeners();
  }
}
