part of 'get_user_bloc.dart';

abstract class GetUserEvent extends Equatable {
  const GetUserEvent();

  @override
  List<Object?> get props => [];
}

class GetUser extends GetUserEvent {
  const GetUser(this.userId);

  final String userId;

  @override
  List<Object?> get props => [userId];
}
