part of 'vf_createorgscreen_bloc.dart';

/// Abstract class for all events that can be dispatched from the
/// VfCreateorgscreen widget.
///
/// Events must be immutable and implement the [Equatable] interface.
abstract class VfCreateorgscreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfCreateorgscreen widget is first created.
class VfCreateorgscreenInitialEvent extends VfCreateorgscreenEvent {
  @override
  List<Object?> get props => [];
}

class LoadMultiSelectDataEvent extends VfCreateorgscreenEvent {
  @override
  List<Object?> get props => [];
}

/// Event for updating the multi-select values in the VfCreateorgscreen widget.
class UpdateMultiSelectValuesEvent extends VfCreateorgscreenEvent {
  final List<causes>
      selectedValues; // Ensure Causes is correctly imported and used

  UpdateMultiSelectValuesEvent(this.selectedValues);

  @override
  List<Object?> get props => [selectedValues];
}

/// Event for changing the checkbox value in the VfCreateorgscreen widget.
class ChangeIsSchoolCheckBoxEvent extends VfCreateorgscreenEvent {
  final bool value;
  final String? parentOrgName;

  ChangeIsSchoolCheckBoxEvent({required this.value, this.parentOrgName});

  @override
  List<Object?> get props => [value, parentOrgName];
}

class UpdateOrgFieldEvent extends VfCreateorgscreenEvent {
  final String field;
  final String value;

  UpdateOrgFieldEvent({required this.field, required this.value});

  @override
  List<Object?> get props => [field, value];
}

class SaveOrganizationEvent extends VfCreateorgscreenEvent {
  @override
  List<Object?> get props => [];
}
// Add any additional events here as needed