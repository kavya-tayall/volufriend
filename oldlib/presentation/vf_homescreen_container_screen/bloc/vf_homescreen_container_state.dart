part of 'vf_homescreen_container_bloc.dart';

/// Represents the state of VfHomescreenContainer in the application.

// ignore_for_file: must_be_immutable
class VfHomescreenContainerState extends Equatable {
  VfHomescreenContainerState({this.vfHomescreenContainerModelObj});

  VfHomescreenContainerModel? vfHomescreenContainerModelObj;

  @override
  List<Object?> get props => [vfHomescreenContainerModelObj];
  VfHomescreenContainerState copyWith(
      {VfHomescreenContainerModel? vfHomescreenContainerModelObj}) {
    return VfHomescreenContainerState(
      vfHomescreenContainerModelObj:
          vfHomescreenContainerModelObj ?? this.vfHomescreenContainerModelObj,
    );
  }
}
