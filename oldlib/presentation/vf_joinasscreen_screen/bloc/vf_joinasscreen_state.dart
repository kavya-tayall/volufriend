part of 'vf_joinasscreen_bloc.dart';

/// Represents the state of VfJoinasscreen in the application.

// ignore_for_file: must_be_immutable
class VfJoinasscreenState extends Equatable {
  VfJoinasscreenState({this.vfJoinasscreenModelObj});

  VfJoinasscreenModel? vfJoinasscreenModelObj;

  @override
  List<Object?> get props => [vfJoinasscreenModelObj];
  VfJoinasscreenState copyWith({VfJoinasscreenModel? vfJoinasscreenModelObj}) {
    return VfJoinasscreenState(
      vfJoinasscreenModelObj:
          vfJoinasscreenModelObj ?? this.vfJoinasscreenModelObj,
    );
  }
}
