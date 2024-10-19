part of 'vf_homescreen_container_bloc.dart';

/// Abstract class for all events that can be dispatched from the
/// VfHomescreenContainer widget.
///
/// Events must be immutable and implement the [Equatable] interface.
abstract class VfHomescreenContainerEvent extends Equatable {
  const VfHomescreenContainerEvent();

  @override
  List<Object?> get props => [];
}

/// Event to set the eventId when entering edit mode.
/// This event will set the eventId and mark the edit mode as started.
class SetEventIdInEditModeStarted extends VfHomescreenContainerEvent {
  final String eventId;

  const SetEventIdInEditModeStarted(this.eventId);

  @override
  List<Object?> get props => [eventId];
}

/// Event to signal that edit mode has ended.
/// This event will set the eventId and mark the edit mode as ended.
class SetEventIdInEditModeEnded extends VfHomescreenContainerEvent {
  final String eventId;

  const SetEventIdInEditModeEnded(this.eventId);

  @override
  List<Object?> get props => [eventId];
}

/// Event to set the eventId in details view mode.
/// This event will set the eventId to the value passed in the event.
class SetEventIdInDetailsViewMode extends VfHomescreenContainerEvent {
  final String eventId;

  const SetEventIdInDetailsViewMode(this.eventId);

  @override
  List<Object?> get props => [eventId];
}

/// Event to signal that create mode has started.
/// This will set the eventId to an empty string and mark the create mode as started.
class StartCreateModeEvent extends VfHomescreenContainerEvent {
  const StartCreateModeEvent();

  @override
  List<Object?> get props => [];
}

/// Event to signal that create mode has ended.
/// This will set the eventId to the value passed in the event and mark the create mode as ended.
class EndCreateModeEvent extends VfHomescreenContainerEvent {
  final String eventId;

  const EndCreateModeEvent(this.eventId);

  @override
  List<Object?> get props => [eventId];
}

/// Event that is dispatched when the VfHomescreenContainer widget is first created.
class VfHomescreenContainerInitialEvent extends VfHomescreenContainerEvent {
  @override
  List<Object?> get props => [];
}
