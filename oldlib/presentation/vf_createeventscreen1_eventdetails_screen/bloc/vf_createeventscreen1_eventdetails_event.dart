part of 'vf_createeventscreen1_eventdetails_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///VfCreateeventscreen1Eventdetails widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class VfCreateeventscreen1EventdetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfCreateeventscreen1Eventdetails widget is first created.
class VfCreateeventscreen1EventdetailsInitialEvent
    extends VfCreateeventscreen1EventdetailsEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing date

// ignore_for_file: must_be_immutable
class ChangeDateEvent extends VfCreateeventscreen1EventdetailsEvent {
  ChangeDateEvent({required this.date});

  DateTime date;

  @override
  List<Object?> get props => [date];
}
