part of 'get_user_bloc.dart';

abstract class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object?> get props => [];
}

class GetUserInitial extends GetUserState {}

class GetUserLoading extends GetUserState {}

class GetUserLoaded extends GetUserState {
  const GetUserLoaded({required this.user});

  final NewVolufrienduser user;

  @override
  List<Object?> get props => [user];
}

class GetUserError extends GetUserState {
  const GetUserError({required this.error});

  final String error;

  @override
  List<Object?> get props => [error];
}
