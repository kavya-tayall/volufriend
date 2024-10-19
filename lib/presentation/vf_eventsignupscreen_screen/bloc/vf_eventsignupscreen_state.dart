part of 'vf_eventsignupscreen_bloc.dart';

/// Represents the state of VfEventsignupscreen in the application.

// ignore_for_file: must_be_immutable
class VfEventsignupscreenState extends Equatable {
  final VfEventsignupscreenModel? vfEventsignupscreenModelObj;
  final String? errorMessage;
  final String? successMessage;
  final bool showContactInfo; // New property to manage visibility
  final List<bool> selectedShifts;
  final List<String> selectedShiftIds; // Tracks the selected shift IDs

  final String orgId;
  final String eventId;
  final String userId;

  const VfEventsignupscreenState({
    this.vfEventsignupscreenModelObj,
    this.errorMessage = '',
    this.successMessage = '',
    this.showContactInfo = false, // Default to false
    this.selectedShifts = const [],
    this.selectedShiftIds = const [], // Initialize selectedShiftIds
    this.orgId = '',
    this.eventId = '',
    this.userId = '',
  });

  @override
  List<Object?> get props => [
        vfEventsignupscreenModelObj,
        errorMessage,
        successMessage,
        showContactInfo,
        selectedShifts,
        selectedShiftIds,
        orgId,
        eventId,
        userId,
      ];

  VfEventsignupscreenState copyWith({
    VfEventsignupscreenModel? vfEventsignupscreenModelObj,
    String? errorMessage,
    String? successMessage,
    bool? showContactInfo,
    List<bool>? selectedShifts,
    List<String>? selectedShiftIds,
    String? orgId,
    String? eventId,
    String? userId,
  }) {
    return VfEventsignupscreenState(
      vfEventsignupscreenModelObj:
          vfEventsignupscreenModelObj ?? this.vfEventsignupscreenModelObj,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      showContactInfo: showContactInfo ?? this.showContactInfo,
      selectedShifts: selectedShifts ?? this.selectedShifts,
      selectedShiftIds: selectedShiftIds ?? this.selectedShiftIds,
      orgId: orgId ?? this.orgId,
      eventId: eventId ?? this.eventId,
      userId: userId ?? this.userId,
    );
  }
}
