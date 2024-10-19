part of 'vf_createeventscreen3_eventadditionaldetails_bloc.dart';

/// Represents the state of VfCreateeventscreen3Eventadditionaldetails in the application.

// ignore_for_file: must_be_immutable
class VfCreateeventscreen3EventadditionaldetailsState extends Equatable {
  VfCreateeventscreen3EventadditionaldetailsState(
      {this.additionalDetailsTextAreaController,
      this.nofilechosenvalController,
      this.coordinatorNameInputController,
      this.coordinatorEmailInputController,
      this.coordinatorPhoneInputController,
      this.phoneNumberController,
      this.selectedCountry,
      this.vfCreateeventscreen3EventadditionaldetailsModelObj});

  TextEditingController? additionalDetailsTextAreaController;

  TextEditingController? nofilechosenvalController;

  TextEditingController? coordinatorNameInputController;

  TextEditingController? coordinatorEmailInputController;

  TextEditingController? coordinatorPhoneInputController;

  TextEditingController? phoneNumberController;

  VfCreateeventscreen3EventadditionaldetailsModel?
      vfCreateeventscreen3EventadditionaldetailsModelObj;

  Country? selectedCountry;

  @override
  List<Object?> get props => [
        additionalDetailsTextAreaController,
        nofilechosenvalController,
        coordinatorNameInputController,
        coordinatorEmailInputController,
        coordinatorPhoneInputController,
        phoneNumberController,
        selectedCountry,
        vfCreateeventscreen3EventadditionaldetailsModelObj
      ];
  VfCreateeventscreen3EventadditionaldetailsState copyWith({
    TextEditingController? additionalDetailsTextAreaController,
    TextEditingController? nofilechosenvalController,
    TextEditingController? coordinatorNameInputController,
    TextEditingController? coordinatorEmailInputController,
    TextEditingController? coordinatorPhoneInputController,
    TextEditingController? phoneNumberController,
    Country? selectedCountry,
    VfCreateeventscreen3EventadditionaldetailsModel?
        vfCreateeventscreen3EventadditionaldetailsModelObj,
  }) {
    return VfCreateeventscreen3EventadditionaldetailsState(
      additionalDetailsTextAreaController:
          additionalDetailsTextAreaController ??
              this.additionalDetailsTextAreaController,
      nofilechosenvalController:
          nofilechosenvalController ?? this.nofilechosenvalController,
      coordinatorNameInputController:
          coordinatorNameInputController ?? this.coordinatorNameInputController,
      coordinatorEmailInputController: coordinatorEmailInputController ??
          this.coordinatorEmailInputController,
      coordinatorPhoneInputController: coordinatorPhoneInputController ??
          this.coordinatorPhoneInputController,
      phoneNumberController:
          phoneNumberController ?? this.phoneNumberController,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      vfCreateeventscreen3EventadditionaldetailsModelObj:
          vfCreateeventscreen3EventadditionaldetailsModelObj ??
              this.vfCreateeventscreen3EventadditionaldetailsModelObj,
    );
  }
}
