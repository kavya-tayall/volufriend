part of 'vf_viewvolunteeringprofilescreen_bloc.dart';

// ignore_for_file: must_be_immutable
class VfVolunteerProfilescreenState extends Equatable {
  final VfVolunteerProfilescreenModel? vfVolunteerProfilescreenModelObj;
  final String errorMessage;
  final String successMessage;
  final String orgId;
  final String eventId;
  final String userId;
  final bool isLoading;

  const VfVolunteerProfilescreenState({
    this.vfVolunteerProfilescreenModelObj,
    this.errorMessage = '',
    this.successMessage = '',
    this.orgId = '',
    this.eventId = '',
    this.userId = '',
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        vfVolunteerProfilescreenModelObj,
        errorMessage,
        successMessage,
        orgId,
        eventId,
        userId,
        isLoading,
      ];

  // Create a copy of the current state, with updated values where necessary
  VfVolunteerProfilescreenState copyWith({
    VfVolunteerProfilescreenModel? vfVolunteerProfilescreenModelObj,
    String? errorMessage,
    String? successMessage,
    String? orgId,
    String? eventId,
    String? userId,
    bool? isLoading,
  }) {
    return VfVolunteerProfilescreenState(
      vfVolunteerProfilescreenModelObj: vfVolunteerProfilescreenModelObj ??
          this.vfVolunteerProfilescreenModelObj,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      orgId: orgId ?? this.orgId,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
