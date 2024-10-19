part of 'get_users_bloc.dart';

abstract class GetUsersEvent extends Equatable {
  const GetUsersEvent();
}

class GetUsers extends GetUsersEvent {
  @override
  List<Object?> get props => [];
}
