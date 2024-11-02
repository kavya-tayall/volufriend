part of 'vf_eventdetailspage_bloc.dart';

/// Abstract class for all events that can be dispatched from the
/// VfEventsignupscreen widget.
/// Events must be immutable and implement the [Equatable] interface.
abstract class VfEventsdetailspageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfEventsignupscreen widget is first created.
class VfEventdetailspageInitialEvent extends VfEventsdetailspageEvent {
  final Voluevents eventSelected;

  // Constructor to pass the eventId
  VfEventdetailspageInitialEvent(this.eventSelected);

  @override
  List<Object?> get props => [eventSelected];
}

class resetEventDetailPage extends VfEventsdetailspageEvent {}

class CancelSingleEventEvent extends VfEventsdetailspageEvent {
  final String eventId;
  final bool notifyParticipants;

  CancelSingleEventEvent(
      {required this.eventId, required this.notifyParticipants});

  @override
  List<Object?> get props => [eventId, notifyParticipants];
}

/// Event to fetch event details.
class FetchEventDetails extends VfEventsdetailspageEvent {
  final String eventId;

  FetchEventDetails(this.eventId);

  @override
  List<Object> get props => [eventId];
}

/// Event to toggle the visibility of the contact information.
class ToggleContactInfoEvent extends VfEventsdetailspageEvent {}

// vf_eventsignupscreen_event.dart

class ToggleShiftSelectionEvent extends VfEventsdetailspageEvent {
  final int index; // Index in the list
  final bool isSelected; // Whether the checkbox is selected
  final String shiftId; // The shiftId of the selected shift

  ToggleShiftSelectionEvent(this.index, this.isSelected, this.shiftId);

  @override
  List<Object?> get props => [index, isSelected, shiftId];
}

class SaveEventSignUp extends VfEventsdetailspageEvent {
  final List<String> selectedShiftIds; // List of selected shift IDs

  SaveEventSignUp(this.selectedShiftIds);

  @override
  List<Object?> get props => [selectedShiftIds];
}
