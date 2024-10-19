import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

@immutable
class NewVolufrienduser extends Equatable {
  final String id;
  final String? firstName;
  final String? lastName;
  final DateTime? createdAt;
  final DateTime? dob;
  final String? email;
  final String? gender;
  final String? phone;
  final String? pictureUrl;
  final String? role;
  final String? HomeOrSchoolOrgId;
  final DateTime? updatedAt;
  final List<String>? causes; // New field for cause IDs

  const NewVolufrienduser({
    required this.id,
    this.firstName,
    this.lastName,
    this.createdAt,
    this.dob,
    this.email,
    this.gender,
    this.phone,
    this.pictureUrl,
    this.role,
    this.HomeOrSchoolOrgId,
    this.updatedAt,
    this.causes, // Initialize causes
  });

  // Define the parseDate function as a static method
  static DateTime? parseDate(String? dateStr) {
    if (dateStr == null) return null;

    try {
      final format = DateFormat('MM/dd/yyyy');
      return format.parse(dateStr);
    } catch (e) {
      print('Error parsing date: $e');
      return null;
    }
  }

  factory NewVolufrienduser.fromJson(Map<String, dynamic> json, String id) {
    return NewVolufrienduser(
      id: id,
      firstName: json['First Name'] as String?,
      lastName: json['Last Name'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(
              json['created_at'] as String) // Use tryParse for safer parsing
          : null,
      dob: json['dob'] != null
          ? NewVolufrienduser.parseDate(json['dob'] as String)
          : null,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      pictureUrl: json['picture_url'] as String?,
      role: json['role'] as String?,
      HomeOrSchoolOrgId: json['school_home_org_id'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(
              json['updated_at'] as String) // Use tryParse for safer parsing
          : null,
      causes: (json['causes'] as List<dynamic>?)
          ?.map((cause) => cause as String)
          .toList(), // Parse cause IDs
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'First Name': firstName,
      'Last Name': lastName,
      'created_at': createdAt?.toIso8601String(),
      'dob': dob != null ? DateFormat('MM/dd/yyyy').format(dob!) : null,
      'email': email,
      'gender': gender,
      'phone': phone,
      'picture_url': pictureUrl,
      'role': role,
      'school_home_org_id': HomeOrSchoolOrgId,
      'updated_at': updatedAt?.toIso8601String(),
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
        HomeOrSchoolOrgId,
        updatedAt,
        causes, // Add causes to the props list
      ];
}
