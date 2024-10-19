part of 'vf_eventdetailspage_bloc.dart';

/// Represents the state of VfEventsignupscreen in the application.

// ignore_for_file: must_be_immutable
class VfEventsdetailspageState extends Equatable {
  final VfEventdetailspageModel? vfEventdetailsModelObj;
  final String? errorMessage;
  final String? successMessage;
  final bool showContactInfo; // New property to manage visibility
  final List<bool> selectedShifts;
  final List<String> selectedShiftIds; // Tracks the selected shift IDs

  final String orgId;
  final String eventId;
  final String userId;

  const VfEventsdetailspageState({
    this.vfEventdetailsModelObj,
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
        vfEventdetailsModelObj,
        errorMessage,
        successMessage,
        showContactInfo,
        selectedShifts,
        selectedShiftIds,
        orgId,
        eventId,
        userId,
      ];

  VfEventsdetailspageState copyWith({
    VfEventdetailspageModel? vfEventdetailsModelObj,
    String? errorMessage,
    String? successMessage,
    bool? showContactInfo,
    List<bool>? selectedShifts,
    List<String>? selectedShiftIds,
    String? orgId,
    String? eventId,
    String? userId,
  }) {
    return VfEventsdetailspageState(
      vfEventdetailsModelObj:
          vfEventdetailsModelObj ?? this.vfEventdetailsModelObj,
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
