part of 'vf_createeventscreen3_eventadditionaldetails_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///VfCreateeventscreen3Eventadditionaldetails widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class VfCreateeventscreen3EventadditionaldetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfCreateeventscreen3Eventadditionaldetails widget is first created.
class VfCreateeventscreen3EventadditionaldetailsInitialEvent
    extends VfCreateeventscreen3EventadditionaldetailsEvent {
  @override
  List<Object?> get props => [];
}

///Event for changing country code

// ignore_for_file: must_be_immutable
class ChangeCountryEvent
    extends VfCreateeventscreen3EventadditionaldetailsEvent {
  ChangeCountryEvent({required this.value});

  Country value;

  @override
  List<Object?> get props => [value];
}
