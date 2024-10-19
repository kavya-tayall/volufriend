part of 'vf_myupcomingeventscreen_bloc.dart';

// ignore_for_file: must_be_immutable
class VfMyupcomingeventscreenState extends Equatable {
  final VfMyupcomingeventscreenModel? vfMyupcomingeventscreenModelObj;
  final String errorMessage;
  final String successMessage;
  final String orgId;
  final String eventId;
  final String userId;
  final bool isLoading;

  const VfMyupcomingeventscreenState({
    this.vfMyupcomingeventscreenModelObj,
    this.errorMessage = '',
    this.successMessage = '',
    this.orgId = '',
    this.eventId = '',
    this.userId = '',
    this.isLoading = false,
  });

  @override
  List<Object?> get props => [
        vfMyupcomingeventscreenModelObj,
        errorMessage,
        successMessage,
        orgId,
        eventId,
        userId,
        isLoading,
      ];

  // Create a copy of the current state, with updated values where necessary
  VfMyupcomingeventscreenState copyWith({
    VfMyupcomingeventscreenModel? vfMyupcomingeventscreenModelObj,
    String? errorMessage,
    String? successMessage,
    String? orgId,
    String? eventId,
    String? userId,
    bool? isLoading,
  }) {
    return VfMyupcomingeventscreenState(
      vfMyupcomingeventscreenModelObj: vfMyupcomingeventscreenModelObj ??
          this.vfMyupcomingeventscreenModelObj,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      orgId: orgId ?? this.orgId,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
