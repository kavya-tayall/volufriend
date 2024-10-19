import 'package:equatable/equatable.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';

/// This class defines the variables used in the [vf_createorgscreen_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class VfCreateorgscreenModel extends Equatable {
  VfCreateorgscreenModel({this.dropdownItemList = const []});

  List<SelectionPopupModel> dropdownItemList;

  VfCreateorgscreenModel copyWith(
      {List<SelectionPopupModel>? dropdownItemList}) {
    return VfCreateorgscreenModel(
      dropdownItemList: dropdownItemList ?? this.dropdownItemList,
    );
  }

  @override
  List<Object?> get props => [dropdownItemList];
}
