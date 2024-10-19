part of 'get_users_bloc.dart';

@immutable
sealed class GetUsersState extends Equatable {
  const GetUsersState();
}

class GetUsersLoading extends GetUsersState {
  @override
  List<Object?> get props => [];
}

class GetUsersLoaded extends GetUsersState {
  const GetUsersLoaded({this.users = const <NewVolufrienduser>[]});

  final List<NewVolufrienduser> users;

  @override
  List<Object?> get props => [users];
}

class GetUsersError extends GetUsersState {
  @override
  List<Object?> get props => [];
}
