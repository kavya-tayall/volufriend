import 'package:equatable/equatable.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';

/// This class defines the variables used in the [vf_createeventscreen1_eventdetails_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class VfCreateeventscreen1EventdetailsModel extends Equatable {
  VfCreateeventscreen1EventdetailsModel(
      {this.dropdownItemList = const [],
      this.selectedEventDateInput,
      this.eventDateInput = "Choose date"}) {
    selectedEventDateInput = selectedEventDateInput ?? DateTime.now();
  }

  List<SelectionPopupModel> dropdownItemList;

  DateTime? selectedEventDateInput;

  String eventDateInput;

  VfCreateeventscreen1EventdetailsModel copyWith({
    List<SelectionPopupModel>? dropdownItemList,
    DateTime? selectedEventDateInput,
    String? eventDateInput,
  }) {
    return VfCreateeventscreen1EventdetailsModel(
      dropdownItemList: dropdownItemList ?? this.dropdownItemList,
      selectedEventDateInput:
          selectedEventDateInput ?? this.selectedEventDateInput,
      eventDateInput: eventDateInput ?? this.eventDateInput,
    );
  }

  @override
  List<Object?> get props =>
      [dropdownItemList, selectedEventDateInput, eventDateInput];
}
