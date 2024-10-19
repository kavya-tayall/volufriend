part of 'vf_loginaccountscreen_bloc.dart';

/// Represents the state of VfLoginaccountscreen in the application.

// ignore_for_file: must_be_immutable
class VfLoginaccountscreenState extends Equatable {
  VfLoginaccountscreenState({
    this.emailController,
    this.passwordController,
    this.isShowPassword = true,
    this.rememberMeCheckbox = false,
    this.vfLoginaccountscreenModelObj,
  });

  TextEditingController? emailController;

  TextEditingController? passwordController;

  VfLoginaccountscreenModel? vfLoginaccountscreenModelObj;

  bool isShowPassword;

  bool rememberMeCheckbox;

  @override
  List<Object?> get props => [
        emailController,
        passwordController,
        isShowPassword,
        rememberMeCheckbox,
        vfLoginaccountscreenModelObj
      ];
  VfLoginaccountscreenState copyWith({
    TextEditingController? emailController,
    TextEditingController? passwordController,
    bool? isShowPassword,
    bool? rememberMeCheckbox,
    VfLoginaccountscreenModel? vfLoginaccountscreenModelObj,
  }) {
    return VfLoginaccountscreenState(
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      rememberMeCheckbox: rememberMeCheckbox ?? this.rememberMeCheckbox,
      vfLoginaccountscreenModelObj:
          vfLoginaccountscreenModelObj ?? this.vfLoginaccountscreenModelObj,
    );
  }
}
