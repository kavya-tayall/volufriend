part of 'update_user_bloc.dart';

abstract class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object?> get props => [];
}

class UpdateUserInitial extends UpdateUserState {}

class UpdateUserLoading extends UpdateUserState {}

class UpdateUserLoaded extends UpdateUserState {
  const UpdateUserLoaded({required this.updatedUser});

  final NewVolufrienduser updatedUser;

  @override
  List<Object?> get props => [updatedUser];
}

class UpdateUserError extends UpdateUserState {
  const UpdateUserError({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}
