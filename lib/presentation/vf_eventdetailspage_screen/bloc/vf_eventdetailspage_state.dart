part of 'vf_eventdetailspage_bloc.dart';

/// Represents the state of VfEventsignupscreen in the application.
class VfEventsdetailspageState extends Equatable {
  final VfEventdetailspageModel? vfEventdetailsModelObj;
  final String? errorMessage;
  final String? successMessage;
  final bool showContactInfo; // New property to manage visibility
  final List<bool> selectedShifts;
  final List<String> selectedShiftIds; // Tracks the selected shift IDs
  final bool isLoading;
  final String orgId;
  final String eventId;
  final String userId;
  final bool cancelsucess;

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
    this.isLoading = false,
    this.cancelsucess = false,
  });

  static const initial = VfEventsdetailspageState(
    vfEventdetailsModelObj: null,
    errorMessage: '',
    successMessage: '',
    showContactInfo: false,
    selectedShifts: [],
    selectedShiftIds: [],
    orgId: '',
    eventId: '',
    userId: '',
    isLoading: false,
    cancelsucess: false,
  );

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
        isLoading,
        cancelsucess,
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
    bool? isLoading,
    bool? cancelsucess,
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
      isLoading: isLoading ?? this.isLoading,
      cancelsucess: cancelsucess ?? this.cancelsucess,
    );
  }
}
