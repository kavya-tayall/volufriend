part of 'vf_createaccountscreen_bloc.dart';

/// Represents the state of VfCreateaccountscreen in the application.

// ignore_for_file: must_be_immutable
class VfCreateaccountscreenState extends Equatable {
  VfCreateaccountscreenState(
      {this.firstNameFieldController,
      this.lastNameFieldController,
      this.emailFieldController,
      this.phoneNumberFieldController,
      this.passwordFieldController,
      this.isShowPassword = true,
      this.termsAndConditionsCheckbox = false,
      this.vfCreateaccountscreenModelObj});

  TextEditingController? firstNameFieldController;

  TextEditingController? lastNameFieldController;

  TextEditingController? emailFieldController;

  TextEditingController? phoneNumberFieldController;

  TextEditingController? passwordFieldController;

  VfCreateaccountscreenModel? vfCreateaccountscreenModelObj;

  bool isShowPassword;

  bool termsAndConditionsCheckbox;

  @override
  List<Object?> get props => [
        firstNameFieldController,
        lastNameFieldController,
        emailFieldController,
        phoneNumberFieldController,
        passwordFieldController,
        isShowPassword,
        termsAndConditionsCheckbox,
        vfCreateaccountscreenModelObj
      ];
  VfCreateaccountscreenState copyWith({
    TextEditingController? firstNameFieldController,
    TextEditingController? lastNameFieldController,
    TextEditingController? emailFieldController,
    TextEditingController? phoneNumberFieldController,
    TextEditingController? passwordFieldController,
    bool? isShowPassword,
    bool? termsAndConditionsCheckbox,
    VfCreateaccountscreenModel? vfCreateaccountscreenModelObj,
  }) {
    return VfCreateaccountscreenState(
      firstNameFieldController:
          firstNameFieldController ?? this.firstNameFieldController,
      lastNameFieldController:
          lastNameFieldController ?? this.lastNameFieldController,
      emailFieldController: emailFieldController ?? this.emailFieldController,
      phoneNumberFieldController:
          phoneNumberFieldController ?? this.phoneNumberFieldController,
      passwordFieldController:
          passwordFieldController ?? this.passwordFieldController,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      termsAndConditionsCheckbox:
          termsAndConditionsCheckbox ?? this.termsAndConditionsCheckbox,
      vfCreateaccountscreenModelObj:
          vfCreateaccountscreenModelObj ?? this.vfCreateaccountscreenModelObj,
    );
  }
}
