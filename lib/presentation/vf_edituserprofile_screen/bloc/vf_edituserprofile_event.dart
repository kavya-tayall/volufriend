part of 'vf_edituserprofile_bloc.dart';

abstract class VfEdituserprofileEvent extends Equatable {
  const VfEdituserprofileEvent();

  @override
  List<Object?> get props => [];
}

class VfEdituserprofileInitialEvent extends VfEdituserprofileEvent {}

class LoadDropdownDataEvent extends VfEdituserprofileEvent {}

class LoadMultiSelectDataEvent extends VfEdituserprofileEvent {}

class LoadGenderOptionsEvent extends VfEdituserprofileEvent {}

class UpdateDropDownSelectionEvent extends VfEdituserprofileEvent {
  final SelectionPopupModel? selectedValue;

  const UpdateDropDownSelectionEvent(this.selectedValue);

  @override
  List<Object?> get props => [selectedValue];
}

class UpdateGenderDropDownSelectionEvent extends VfEdituserprofileEvent {
  final SelectionPopupModel? selectedValue;

  const UpdateGenderDropDownSelectionEvent(this.selectedValue);

  @override
  List<Object?> get props => [selectedValue];
}

class UpdateMultiSelectValuesEvent extends VfEdituserprofileEvent {
  final List<causes> selectedValues;

  const UpdateMultiSelectValuesEvent(this.selectedValues);

  @override
  List<Object?> get props => [selectedValues];
}

class UpdateFieldEvent extends VfEdituserprofileEvent {
  final String field;
  final String value;

  const UpdateFieldEvent(this.field, this.value);

  @override
  List<Object?> get props => [field, value];
}

class UpdateReadOnlyFieldValueEvent extends VfEdituserprofileEvent {
  final String value;

  const UpdateReadOnlyFieldValueEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class SaveUserProfileEvent extends VfEdituserprofileEvent {
  const SaveUserProfileEvent();

  @override
  List<Object?> get props => [];
}

class SelectValueEvent extends VfEdituserprofileEvent {
  final String selectedValue;

  SelectValueEvent(this.selectedValue);

  @override
  List<Object?> get props => [selectedValue];
}
