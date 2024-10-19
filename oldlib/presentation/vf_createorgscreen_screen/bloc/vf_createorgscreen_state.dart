part of 'vf_createorgscreen_bloc.dart';

/// Represents the state of VfCreateorgscreen in the application.

// ignore_for_file: must_be_immutable
class VfCreateorgscreenState extends Equatable {
  VfCreateorgscreenState(
      {this.orgNameInputController,
      this.orgAddressInputController,
      this.orgEmailInputController,
      this.orgPhoneInputController,
      this.orgWebsiteInputController,
      this.selectedDropDownValue,
      this.isSchoolCheckbox = false,
      this.vfCreateorgscreenModelObj});

  TextEditingController? orgNameInputController;

  TextEditingController? orgAddressInputController;

  TextEditingController? orgEmailInputController;

  TextEditingController? orgPhoneInputController;

  TextEditingController? orgWebsiteInputController;

  SelectionPopupModel? selectedDropDownValue;

  VfCreateorgscreenModel? vfCreateorgscreenModelObj;

  bool isSchoolCheckbox;

  @override
  List<Object?> get props => [
        orgNameInputController,
        orgAddressInputController,
        orgEmailInputController,
        orgPhoneInputController,
        orgWebsiteInputController,
        selectedDropDownValue,
        isSchoolCheckbox,
        vfCreateorgscreenModelObj
      ];
  VfCreateorgscreenState copyWith({
    TextEditingController? orgNameInputController,
    TextEditingController? orgAddressInputController,
    TextEditingController? orgEmailInputController,
    TextEditingController? orgPhoneInputController,
    TextEditingController? orgWebsiteInputController,
    SelectionPopupModel? selectedDropDownValue,
    bool? isSchoolCheckbox,
    VfCreateorgscreenModel? vfCreateorgscreenModelObj,
  }) {
    return VfCreateorgscreenState(
      orgNameInputController:
          orgNameInputController ?? this.orgNameInputController,
      orgAddressInputController:
          orgAddressInputController ?? this.orgAddressInputController,
      orgEmailInputController:
          orgEmailInputController ?? this.orgEmailInputController,
      orgPhoneInputController:
          orgPhoneInputController ?? this.orgPhoneInputController,
      orgWebsiteInputController:
          orgWebsiteInputController ?? this.orgWebsiteInputController,
      selectedDropDownValue:
          selectedDropDownValue ?? this.selectedDropDownValue,
      isSchoolCheckbox: isSchoolCheckbox ?? this.isSchoolCheckbox,
      vfCreateorgscreenModelObj:
          vfCreateorgscreenModelObj ?? this.vfCreateorgscreenModelObj,
    );
  }
}
