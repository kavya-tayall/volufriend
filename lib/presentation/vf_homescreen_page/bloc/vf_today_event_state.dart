part of 'vf_today_event_bloc.dart';

abstract class vfTodayEventState extends Equatable {
  const vfTodayEventState();

  @override
  List<Object?> get props => [];
}

class EventInitial extends vfTodayEventState {}

class EventLoading extends vfTodayEventState {}

class EventLoaded extends vfTodayEventState {
  final Voluevents todayevent; // Assuming Event is your model

  const EventLoaded({required this.todayevent});

  @override
  List<Object?> get props => [todayevent];
}

class EventError extends vfTodayEventState {
  final String error;

  const EventError({required this.error});

  @override
  List<Object?> get props => [error];
}
