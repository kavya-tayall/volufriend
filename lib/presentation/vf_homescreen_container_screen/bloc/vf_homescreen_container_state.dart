part of 'vf_homescreen_container_bloc.dart';

/// Represents the state of VfHomescreenContainer in the application.

// ignore_for_file: must_be_immutable
class VfHomescreenContainerState extends Equatable {
  VfHomescreenContainerState({
    this.vfHomescreenContainerModelObj,
    this.eventId = '',
    this.eventIdInEditModeStarted = false,
    this.eventIdInEditModeEnded = false,
    this.eventIdInCreateModeStarted = false,
    this.eventIdInCreateModeEnded = false,
    this.eventIdInDetailsViewMode = false,
    this.eventInCreateMode = false,
    this.forcestate,
  });

  VfHomescreenContainerModel? vfHomescreenContainerModelObj;
  String? eventId;
  bool eventIdInEditModeStarted;
  bool eventIdInEditModeEnded;
  bool eventIdInCreateModeStarted;
  bool eventIdInCreateModeEnded;
  bool eventIdInDetailsViewMode;
  bool eventInCreateMode;
  bool? forcestate;

  @override
  List<Object?> get props => [
        vfHomescreenContainerModelObj,
        eventId,
        eventIdInEditModeStarted,
        eventIdInEditModeEnded,
        eventIdInCreateModeStarted,
        eventIdInCreateModeEnded,
        eventIdInDetailsViewMode,
        eventInCreateMode,
        forcestate,
      ];

  VfHomescreenContainerState copyWith({
    VfHomescreenContainerModel? vfHomescreenContainerModelObj,
    String? eventId,
    bool? eventIdInEditModeStarted,
    bool? eventIdInEditModeEnded,
    bool? eventIdInCreateModeStarted,
    bool? eventIdInCreateModeEnded,
    bool? eventIdInDetailsViewMode,
    bool? eventInCreateMode,
    bool? forcestate,
  }) {
    return VfHomescreenContainerState(
      vfHomescreenContainerModelObj:
          vfHomescreenContainerModelObj ?? this.vfHomescreenContainerModelObj,
      eventId: eventId ?? this.eventId,
      eventIdInEditModeStarted:
          eventIdInEditModeStarted ?? this.eventIdInEditModeStarted,
      eventIdInEditModeEnded:
          eventIdInEditModeEnded ?? this.eventIdInEditModeEnded,
      eventIdInCreateModeStarted:
          eventIdInCreateModeStarted ?? this.eventIdInCreateModeStarted,
      eventIdInCreateModeEnded:
          eventIdInCreateModeEnded ?? this.eventIdInCreateModeEnded,
      eventIdInDetailsViewMode:
          eventIdInDetailsViewMode ?? this.eventIdInDetailsViewMode,
      eventInCreateMode: eventInCreateMode ?? this.eventInCreateMode,
      forcestate: forcestate ?? this.forcestate,
    );
  }
}
