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
  final Voluevents? orgEvent; // Optional parameter, can be null
  VfCreateeventscreen3EventadditionaldetailsInitialEvent({this.orgEvent});
  @override
  List<Object?> get props => [orgEvent];
}

// ignore_for_file: must_be_immutable
class ChangeCountryEvent
    extends VfCreateeventscreen3EventadditionaldetailsEvent {
  ChangeCountryEvent({required this.value});

  Country value;

  @override
  List<Object?> get props => [value];
}

class UpdateAdditionalDetailsEvent
    extends VfCreateeventscreen3EventadditionaldetailsEvent {
  final String additionalDetails;

  UpdateAdditionalDetailsEvent(this.additionalDetails);

  @override
  List<Object> get props => [additionalDetails];
}

class UploadFileEvent extends VfCreateeventscreen3EventadditionaldetailsEvent {
  final String filePath;

  UploadFileEvent(this.filePath);

  @override
  List<Object> get props => [filePath];
}

class SaveEventAdditionalDetailsEvent
    extends VfCreateeventscreen3EventadditionaldetailsEvent {
  final bool saveIntentToDb;

  SaveEventAdditionalDetailsEvent({required this.saveIntentToDb});

  @override
  List<Object?> get props => [saveIntentToDb];
}

/// Event for fetching the shift details
class FetchEventAdditionalDetailsEvent
    extends VfCreateeventscreen3EventadditionaldetailsEvent {
  final Voluevents orgEvent;

  FetchEventAdditionalDetailsEvent({required this.orgEvent});

  @override
  List<Object?> get props => [orgEvent];
}

/// Event for fetching the shift details
class SaveEventShiftstoDbEvent
    extends VfCreateeventscreen3EventadditionaldetailsEvent {
  final Voluevents orgEvent;

  SaveEventShiftstoDbEvent({required this.orgEvent});

  @override
  List<Object?> get props => [orgEvent];
}

/// Event for fetching the shift details
class SaveEventAlbumtoStorageEvent
    extends VfCreateeventscreen3EventadditionaldetailsEvent {
  final EventAlbum eventAlbum;

  SaveEventAlbumtoStorageEvent({required this.eventAlbum});

  @override
  List<Object?> get props => [eventAlbum];
}

class VfCreateeventscreen3EventadditionaldetailsResetInitializationEvent
    extends VfCreateeventscreen3EventadditionaldetailsEvent {
  VfCreateeventscreen3EventadditionaldetailsResetInitializationEvent();

  @override
  List<Object?> get props => [];
}
