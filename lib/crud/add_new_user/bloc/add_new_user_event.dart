part of 'add_new_user_bloc.dart';

abstract class AddNewUserEvent extends Equatable {
  const AddNewUserEvent();
}

class AddNewUser extends AddNewUserEvent {
  const AddNewUser({
    required this.userId,
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
    required this.schoolhomeorgid,
  });
  final String userId;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final DateTime? dob;
  final String email;
  final String gender;
  final String phone;
  final String pictureUrl;
  final String? role;
  final DateTime updatedAt;
  final String? schoolhomeorgid;
  @override
  List<Object?> get props => [
        userId,
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
        schoolhomeorgid,
      ];
}
