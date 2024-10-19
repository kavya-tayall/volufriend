import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class causes extends Equatable {
  final String id;
  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const causes({
    required this.id,
    required this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory causes.fromJson(Map<String, dynamic> json, String id) {
    return causes(
      id: id,
      name: json['name'] as String?,
      description: json['description'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      id: id,
      'name': name,
      'description': description,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        createdAt,
        updatedAt,
      ];
}
