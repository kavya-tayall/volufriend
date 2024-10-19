part of 'vf_onboarding_1_bloc.dart';

/// Represents the state of VfOnboarding1 in the application.

// ignore_for_file: must_be_immutable
class VfOnboarding1State extends Equatable {
  VfOnboarding1State({this.vfOnboarding1ModelObj});

  VfOnboarding1Model? vfOnboarding1ModelObj;

  @override
  List<Object?> get props => [vfOnboarding1ModelObj];
  VfOnboarding1State copyWith({VfOnboarding1Model? vfOnboarding1ModelObj}) {
    return VfOnboarding1State(
      vfOnboarding1ModelObj:
          vfOnboarding1ModelObj ?? this.vfOnboarding1ModelObj,
    );
  }
}
