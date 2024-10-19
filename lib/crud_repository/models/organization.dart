import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Organization extends Equatable {
  final String id;
  final String? name;
  final String? address;
  final DateTime? createdAt;
  final String? contactemail;
  final String? contactname;
  final String? picture_url;
  final String? phone;
  final String? website;
  final DateTime? updatedAt;
  final List<String>? causes; // New field for cause IDs
  final String? createdBy; // New field for creator
  final String? updatedBy; // New field for updater
  final bool isSchool; // New field for school status
  final String? parentOrg; // New field for parent organization

  const Organization({
    required this.id,
    this.name,
    this.address,
    this.createdAt,
    this.contactemail,
    this.contactname,
    this.picture_url,
    this.phone,
    this.website,
    this.updatedAt,
    this.causes,
    this.createdBy,
    this.updatedBy,
    this.isSchool = false, // Default value for isSchool
    this.parentOrg,
  });

  factory Organization.fromJson(Map<String, dynamic> json, String id) {
    return Organization(
      id: id,
      name: json['name'] as String?,
      address: json['address'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      contactemail: json['contactemail'] as String?,
      contactname: json['contactname'] as String?,
      picture_url: json['picture_url'] as String?,
      phone: json['phone'] as String?,
      website: json['website'] as String?,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      causes: (json['causes'] as List<dynamic>?)
          ?.map((cause) => cause as String)
          .toList(), // Parse cause IDs
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      isSchool:
          json['isSchool'] as bool? ?? false, // Default to false if not present
      parentOrg: json['parentOrg'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'createdAt': createdAt?.toIso8601String(),
      'contactemail': contactemail,
      'contactname': contactname,
      'picture_url': picture_url,
      'phone': phone,
      'website': website,
      'updatedAt': updatedAt?.toIso8601String(),
      'causes': causes, // Include cause IDs in JSON
      'createdBy': createdBy,
      'updatedBy': updatedBy,
      'isSchool': isSchool, // Include isSchool in JSON
      'parentOrg': parentOrg,
    };
  }

  @override
  List<Object?> get props => [
        name,
        address,
        createdAt,
        contactemail,
        contactname,
        picture_url,
        phone,
        website,
        updatedAt,
        causes,
        createdBy,
        updatedBy,
        isSchool,
        parentOrg,
      ];
}
