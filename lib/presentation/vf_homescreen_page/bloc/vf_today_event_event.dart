part of 'vf_today_event_bloc.dart';

abstract class VfTodayEventEvent extends Equatable {
  const VfTodayEventEvent();

  @override
  List<Object> get props => [];
}

class FetchFirstEventOfDay extends VfTodayEventEvent {}
