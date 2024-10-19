part of 'add_new_user_bloc.dart';

abstract class AddNewUserState extends Equatable {
  const AddNewUserState();
}

class AddNewUserInitial extends AddNewUserState {
  @override
  List<Object?> get props => [];
}

class AddNewUserLoading extends AddNewUserState {
  @override
  List<Object?> get props => [];
}

class AddNewUserSuccess extends AddNewUserState {
  final String userId;

  const AddNewUserSuccess(this.userId);

  @override
  List<Object?> get props => [userId];
}

class AddNewUserFailure extends AddNewUserState {
  final String error;

  const AddNewUserFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class AddNewUserLoaded extends AddNewUserState {
  final NewVolufrienduser newUser;

  const AddNewUserLoaded({required this.newUser});

  @override
  List<Object?> get props => [newUser];
}
