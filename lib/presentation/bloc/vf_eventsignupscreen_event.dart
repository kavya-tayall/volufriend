part of 'vf_eventsignupscreen_bloc.dart';

/// Abstract class for all events that can be dispatched from the
/// VfEventsignupscreen widget.
/// Events must be immutable and implement the [Equatable] interface.
abstract class VfEventsignupscreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfEventsignupscreen widget is first created.
class VfEventsignupscreenInitialEvent extends VfEventsignupscreenEvent {
  final String eventId;
  final String userId;
  final String orgId;

  // Constructor to pass the eventId
  VfEventsignupscreenInitialEvent(this.eventId, this.userId, this.orgId);

  @override
  List<Object?> get props => [eventId, userId, orgId];
}

/// Event to fetch event details.
class FetchEventDetails extends VfEventsignupscreenEvent {
  final String eventId;

  FetchEventDetails(this.eventId);

  @override
  List<Object> get props => [eventId];
}

/// Event to toggle the visibility of the contact information.
class ToggleContactInfoEvent extends VfEventsignupscreenEvent {}

// vf_eventsignupscreen_event.dart

class ToggleShiftSelectionEvent extends VfEventsignupscreenEvent {
  final int index; // Index in the list
  final bool isSelected; // Whether the checkbox is selected
  final String shiftId; // The shiftId of the selected shift

  ToggleShiftSelectionEvent(this.index, this.isSelected, this.shiftId);

  @override
  List<Object?> get props => [index, isSelected, shiftId];
}

class SaveEventSignUp extends VfEventsignupscreenEvent {
  final List<String> selectedShiftIds; // List of selected shift IDs

  SaveEventSignUp(this.selectedShiftIds);

  @override
  List<Object?> get props => [selectedShiftIds];
}
