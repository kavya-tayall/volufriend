part of 'login_user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  // Define a getter for userId
  String? get userId => null;

  @override
  List<Object?> get props => [];
}

// Initial state
class UserInitial extends UserState {}

// Loading state for checking user status, login, and registration
class UserLoading extends UserState {}

// State indicating that the user needs to log in
class LoginRequired extends UserState {
  final LoginUser user;

  const LoginRequired({required this.user});

  @override
  String? get userId => user.userid;

  @override
  List<Object?> get props => [user];
}

// State for successful login
class LoginSuccess extends UserState {
  final LoginUser user;

  const LoginSuccess({required this.user});

  @override
  String? get userId => user.userid;

  @override
  List<Object?> get props => [user];
}

// State for failed login
class LoginFail extends UserState {
  final String message;

  const LoginFail({required this.message});

  @override
  List<Object?> get props => [message];
}

// State for successful registration
class RegisterSuccess extends UserState {
  final LoginUser user;

  const RegisterSuccess({required this.user});

  @override
  String? get userId => user.userid;

  @override
  List<Object?> get props => [user];
}

// State for failed registration
class RegisterFail extends UserState {
  final String message;

  const RegisterFail({required this.message});

  @override
  List<Object?> get props => [message];
}

// State for when the user has no home organization
class NoHomeOrg extends UserState {
  final LoginUser user;

  const NoHomeOrg({required this.user});

  @override
  String? get userId => user.userid;

  @override
  List<Object?> get props => [user];
}

// State for when the user successfully joins a home organization
class LoginUserWithHomeOrg extends UserState {
  final LoginUser user;

  const LoginUserWithHomeOrg({required this.user});

  @override
  String? get userId => user.userid;

  @override
  List<Object?> get props => [user];
}
