part of 'vf_onboarding_3_bloc.dart';

/// Represents the state of VfOnboarding3 in the application.

// ignore_for_file: must_be_immutable
class VfOnboarding3State extends Equatable {
  VfOnboarding3State({this.vfOnboarding3ModelObj});

  VfOnboarding3Model? vfOnboarding3ModelObj;

  @override
  List<Object?> get props => [vfOnboarding3ModelObj];
  VfOnboarding3State copyWith({VfOnboarding3Model? vfOnboarding3ModelObj}) {
    return VfOnboarding3State(
      vfOnboarding3ModelObj:
          vfOnboarding3ModelObj ?? this.vfOnboarding3ModelObj,
    );
  }
}
