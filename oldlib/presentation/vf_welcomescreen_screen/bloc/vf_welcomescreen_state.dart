part of 'vf_welcomescreen_bloc.dart';

/// Represents the state of VfWelcomescreen in the application.

// ignore_for_file: must_be_immutable
class VfWelcomescreenState extends Equatable {
  VfWelcomescreenState({this.vfWelcomescreenModelObj});

  VfWelcomescreenModel? vfWelcomescreenModelObj;

  @override
  List<Object?> get props => [vfWelcomescreenModelObj];
  VfWelcomescreenState copyWith(
      {VfWelcomescreenModel? vfWelcomescreenModelObj}) {
    return VfWelcomescreenState(
      vfWelcomescreenModelObj:
          vfWelcomescreenModelObj ?? this.vfWelcomescreenModelObj,
    );
  }
}
