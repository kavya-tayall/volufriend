part of 'update_user_bloc.dart';

abstract class UpdateUserEvent extends Equatable {
  const UpdateUserEvent();

  @override
  List<Object?> get props => [];
}

class UpdateUser extends UpdateUserEvent {
  const UpdateUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.email,
    required this.gender,
    required this.phone,
    required this.pictureUrl,
    required this.role,
    required this.updatedAt,
  });

  final String id;
  final String firstName;
  final String lastName;
  final DateTime dob;
  final String email;
  final String gender;
  final String phone;
  final String pictureUrl;
  final String role;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        dob,
        email,
        gender,
        phone,
        pictureUrl,
        role,
        updatedAt,
      ];
}
