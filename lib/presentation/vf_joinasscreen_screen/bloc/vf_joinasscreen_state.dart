part of 'vf_joinasscreen_bloc.dart';

/// Represents the base state of VfJoinasscreen in the application.
class VfJoinasscreenState extends Equatable {
  final VfJoinasscreenModel? vfJoinasscreenModelObj;

  VfJoinasscreenState({this.vfJoinasscreenModelObj});

  @override
  List<Object?> get props => [vfJoinasscreenModelObj];

  VfJoinasscreenState copyWith({VfJoinasscreenModel? vfJoinasscreenModelObj}) {
    return VfJoinasscreenState(
      vfJoinasscreenModelObj:
          vfJoinasscreenModelObj ?? this.vfJoinasscreenModelObj,
    );
  }
}

/// State when the user joins as a volunteer.
class JoinAsVolunteerState extends VfJoinasscreenState {
  JoinAsVolunteerState({VfJoinasscreenModel? vfJoinasscreenModelObj})
      : super(vfJoinasscreenModelObj: vfJoinasscreenModelObj);

  @override
  List<Object?> get props => [vfJoinasscreenModelObj];
}

/// State when the user joins as an organization.
class JoinAsOrganizationState extends VfJoinasscreenState {
  JoinAsOrganizationState({VfJoinasscreenModel? vfJoinasscreenModelObj})
      : super(vfJoinasscreenModelObj: vfJoinasscreenModelObj);

  @override
  List<Object?> get props => [vfJoinasscreenModelObj];
}
