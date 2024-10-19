part of 'vf_createeventscreen1_eventdetails_bloc.dart';

/// Abstract class for all events that can be dispatched from the
/// VfCreateeventscreen1Eventdetails widget.
///
/// Events must be immutable and implement the [Equatable] interface.
abstract class VfCreateeventscreen1EventdetailsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfCreateeventscreen1Eventdetails widget is first created.
class VfCreateeventscreen1EventdetailsInitialEvent
    extends VfCreateeventscreen1EventdetailsEvent {
  final String eventId;
  final String formContext;
  final String? useridinorg;
  final String? orgId;
  final String? parentOrg;
  final String? orgName;

  VfCreateeventscreen1EventdetailsInitialEvent({
    required this.eventId,
    required this.formContext,
    this.useridinorg,
    this.orgId,
    this.parentOrg,
    this.orgName,
  });
}

class LoadCausesDropdownDataEvent
    extends VfCreateeventscreen1EventdetailsEvent {}

class LoadEventHostingOptionsEvent
    extends VfCreateeventscreen1EventdetailsEvent {}

class UpdateCausesDropDownSelectionEvent
    extends VfCreateeventscreen1EventdetailsEvent {
  final SelectionPopupModel? selectedValue;

  UpdateCausesDropDownSelectionEvent(this.selectedValue);

  @override
  List<Object?> get props => [selectedValue];
}

class UpdateEventHostingOptionsEvent
    extends VfCreateeventscreen1EventdetailsEvent {
  final List<EventHostingType> selectedValues;

  UpdateEventHostingOptionsEvent(this.selectedValues);

  @override
  List<Object?> get props => [selectedValues];
}

class ChangeEventDateEvent extends VfCreateeventscreen1EventdetailsEvent {
  final DateTime date;

  ChangeEventDateEvent({required this.date});

  @override
  List<Object?> get props => [date];
}

class ChangeEventRegistrationByDateEvent
    extends VfCreateeventscreen1EventdetailsEvent {
  final DateTime date;

  ChangeEventRegistrationByDateEvent({required this.date});

  @override
  List<Object?> get props => [date];
}

class FetchEventDetails extends VfCreateeventscreen1EventdetailsEvent {
  final String eventId;

  FetchEventDetails(this.eventId);

  @override
  List<Object> get props => [eventId];
}

class SaveEventDetailsEvent extends VfCreateeventscreen1EventdetailsEvent {
  SaveEventDetailsEvent(); // No fields needed

  @override
  List<Object?> get props => [];
}

class VfCreateeventscreen1EventdetailsResetInitializationEvent
    extends VfCreateeventscreen1EventdetailsEvent {
  VfCreateeventscreen1EventdetailsResetInitializationEvent();
}
