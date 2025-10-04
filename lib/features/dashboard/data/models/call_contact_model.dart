class CallContactModel {
  final String id;
  final String name;
  final String phone;
  final String? email;
  final String? company;
  final String? notes;
  final DateTime? lastCalled;
  final int callCount;
  final bool isFavorite;
  final String status; // pending, in-progress, completed, failed

  CallContactModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.company,
    this.notes,
    this.lastCalled,
    this.callCount = 0,
    this.isFavorite = false,
    this.status = 'pending',
  });

  factory CallContactModel.fromJson(Map<String, dynamic> json) {
    return CallContactModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'],
      company: json['company'],
      notes: json['notes'],
      lastCalled: json['last_called'] != null
          ? DateTime.parse(json['last_called'])
          : null,
      callCount: json['call_count'] ?? 0,
      isFavorite: json['is_favorite'] ?? false,
      status: json['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'company': company,
      'notes': notes,
      'last_called': lastCalled?.toIso8601String(),
      'call_count': callCount,
      'is_favorite': isFavorite,
      'status': status,
    };
  }

  CallContactModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? company,
    String? notes,
    DateTime? lastCalled,
    int? callCount,
    bool? isFavorite,
    String? status,
  }) {
    return CallContactModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      company: company ?? this.company,
      notes: notes ?? this.notes,
      lastCalled: lastCalled ?? this.lastCalled,
      callCount: callCount ?? this.callCount,
      isFavorite: isFavorite ?? this.isFavorite,
      status: status ?? this.status,
    );
  }
}