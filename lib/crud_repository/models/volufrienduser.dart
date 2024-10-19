import 'package:equatable/equatable.dart';

class Volufrienduser extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final DateTime dob;
  final String email;
  final String gender;
  final String phone;
  final String pictureUrl;
  final String role;
  final DateTime updatedAt;
  final String? schoolHomeOrgId; // Nullable field
  final List<String>? causes; // New field for cause IDs

  Volufrienduser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.dob,
    required this.email,
    required this.gender,
    required this.phone,
    required this.pictureUrl,
    required this.role,
    required this.updatedAt,
    this.schoolHomeOrgId, // Optional in the constructor
    this.causes, // Optional in the constructor
  });

  factory Volufrienduser.fromJson(Map<String, dynamic> json, String id) {
    return Volufrienduser(
      id: id,
      firstName: json['First Name'],
      lastName: json['Last Name'],
      createdAt: DateTime.parse(json['created_at']),
      dob: DateTime.parse(json['dob']),
      email: json['email'],
      gender: json['gender'],
      phone: json['phone'],
      pictureUrl: json['picture_url'],
      role: json['role'],
      updatedAt: DateTime.parse(json['updated_at']),
      schoolHomeOrgId: json['school_home_org_id'], // Parse this field
      causes: (json['causes'] as List<dynamic>?)
          ?.map((cause) => cause as String)
          .toList(), // Parse cause IDs
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'First Name': firstName,
      'Last Name': lastName,
      'created_at': createdAt.toIso8601String(),
      'dob': dob.toIso8601String(),
      'email': email,
      'gender': gender,
      'phone': phone,
      'picture_url': pictureUrl,
      'role': role,
      'updated_at': updatedAt.toIso8601String(),
      'school_home_org_id': schoolHomeOrgId, // Include this field
      'causes': causes, // Include cause IDs in JSON
    };
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        createdAt,
        dob,
        email,
        gender,
        phone,
        pictureUrl,
        role,
        updatedAt,
        schoolHomeOrgId, // Include in props
        causes, // Include causes in props
      ];
}
