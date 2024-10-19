part of 'vf_homescreen_bloc.dart';

/// Represents the state of VfHomescreen in the application.

// ignore_for_file: must_be_immutable
class VfHomescreenState extends Equatable {
  VfHomescreenState({this.vfHomescreenModelObj});

  VfHomescreenModel? vfHomescreenModelObj;

  @override
  List<Object?> get props => [vfHomescreenModelObj];
  VfHomescreenState copyWith({VfHomescreenModel? vfHomescreenModelObj}) {
    return VfHomescreenState(
      vfHomescreenModelObj: vfHomescreenModelObj ?? this.vfHomescreenModelObj,
    );
  }
}
