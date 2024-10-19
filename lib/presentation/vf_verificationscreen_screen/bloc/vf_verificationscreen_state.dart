part of 'vf_verificationscreen_bloc.dart';

/// Represents the state of VfVerificationscreen in the application.

// ignore_for_file: must_be_immutable
class VfVerificationscreenState extends Equatable {
  VfVerificationscreenState(
      {this.otpController, this.vfVerificationscreenModelObj});

  TextEditingController? otpController;

  VfVerificationscreenModel? vfVerificationscreenModelObj;

  @override
  List<Object?> get props => [otpController, vfVerificationscreenModelObj];
  VfVerificationscreenState copyWith({
    TextEditingController? otpController,
    VfVerificationscreenModel? vfVerificationscreenModelObj,
  }) {
    return VfVerificationscreenState(
      otpController: otpController ?? this.otpController,
      vfVerificationscreenModelObj:
          vfVerificationscreenModelObj ?? this.vfVerificationscreenModelObj,
    );
  }
}
