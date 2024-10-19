part of 'login_user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

// Event for checking if a user is already logged in
class CheckUserStatus extends UserEvent {
  final LoginUser? user;

  const CheckUserStatus({this.user});

  @override
  List<Object?> get props => [user];
}

class RegisterUserEvent extends UserEvent {
  final String userId;

  const RegisterUserEvent({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}

class RegisterUserTokenEvent extends UserEvent {
  final String userId;
  final String fcmToken;

  const RegisterUserTokenEvent({
    required this.userId,
    required this.fcmToken,
  });

  @override
  List<Object?> get props => [userId, fcmToken];
}

// Event for logging in an existing user
class LoginUserEvent extends UserEvent {
  final String userId;

  const LoginUserEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

// Event for joining a home organization
class JoinHomeOrg extends UserEvent {
  final String userId;
  final String orgId;
  final String role;
  final String createdAt;
  final String createdBy;
  final String orgRole;

  const JoinHomeOrg({
    required this.userId,
    required this.orgId,
    required this.role,
    required this.createdAt,
    required this.createdBy,
    required this.orgRole,
  });

  @override
  List<Object> get props =>
      [userId, orgId, role, createdAt, createdBy, orgRole];
}

// Event for logging out the user
class LogoutEvent extends UserEvent {
  const LogoutEvent();

  @override
  List<Object?> get props => [];
}
