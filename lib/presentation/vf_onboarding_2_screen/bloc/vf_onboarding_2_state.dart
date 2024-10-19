part of 'vf_onboarding_2_bloc.dart';

/// Represents the state of VfOnboarding2 in the application.

// ignore_for_file: must_be_immutable
class VfOnboarding2State extends Equatable {
  VfOnboarding2State({this.vfOnboarding2ModelObj});

  VfOnboarding2Model? vfOnboarding2ModelObj;

  @override
  List<Object?> get props => [vfOnboarding2ModelObj];
  VfOnboarding2State copyWith({VfOnboarding2Model? vfOnboarding2ModelObj}) {
    return VfOnboarding2State(
      vfOnboarding2ModelObj:
          vfOnboarding2ModelObj ?? this.vfOnboarding2ModelObj,
    );
  }
}
