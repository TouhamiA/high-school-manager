class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String phone;
  final String status;
  final String? address;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.phone,
    required this.status,
    this.address,
    this.createdAt,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? phone,
    String? status,
    String? address,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'phone': phone,
      'status': status,
      'address': address,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      phone: json['phone'] ?? '',
      status: json['status'] ?? 'active',
      address: json['address'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }
}
