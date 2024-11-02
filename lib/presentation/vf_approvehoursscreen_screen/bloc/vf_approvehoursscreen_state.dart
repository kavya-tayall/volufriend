part of 'vf_approvehoursscreen_bloc.dart';

class VfApprovehoursscreenState extends Equatable {
  final VfApprovehoursscreenModel vfApprovehoursscreenModelObj;
  final TextEditingController searchController;
  final bool isSelectedSwitch;
  final bool selectedAllAttendees;
  final bool isRejectMode;
  final double totalApprovedHours;
  final double totalAttendedHours;
  final List<Attendance> attendeeList;
  final int shiftIndex;
  final String? eventName;
  final String? eventDate;
  final String? shift1Id;
  final String? shift2Id;
  final int shift1AttendeeCount;
  final int shift2AttendeeCount;
  final String shift1Time;
  final String shift2Time;
  final List<Attendance> shift1Attendees;
  final List<Attendance> shift2Attendees;
  final isSaving;
  final String sucessMessage;
  // Added properties
  final bool isLoading; // For loader during async operations
  final String? errorMessage; // For error handling
  final List<Attendance> selectedAttendees; // List of selected attendees
  final int selectedAttendeesCount; // Count of selected attendees

  VfApprovehoursscreenState({
    required this.vfApprovehoursscreenModelObj,
    required this.searchController,
    this.isSelectedSwitch = false,
    this.selectedAllAttendees = false,
    this.isRejectMode = false,
    this.totalApprovedHours = 0,
    this.totalAttendedHours = 0,
    this.attendeeList = const [],
    this.shiftIndex = 0,
    this.eventName,
    this.eventDate,
    this.shift1Id,
    this.shift2Id,
    this.shift1AttendeeCount = 0,
    this.shift2AttendeeCount = 0,
    required this.shift1Attendees,
    required this.shift2Attendees,

    // Initialize new properties
    this.isLoading = false,
    this.errorMessage,
    this.selectedAttendees = const [],
    this.selectedAttendeesCount = 0,

    // Added property
    this.shift1Time = '',
    this.shift2Time = '',
    this.isSaving = false,
    this.sucessMessage = '',
  });

  List<Attendance> getAttendeesForShift(String shiftId, int shiftIndex) {
    if (shiftIndex == 0) {
      print('shift1Attendees: $vfApprovehoursscreenModelObj.shift1Attendees');
      return vfApprovehoursscreenModelObj.shift1Attendees;
    } else if (shiftIndex == 1) {
      print('shift2Attendees: $vfApprovehoursscreenModelObj.shift2Attendees');
      return vfApprovehoursscreenModelObj.shift2Attendees;
    } else {
      return [];
    }
  }

  @override
  List<Object?> get props => [
        vfApprovehoursscreenModelObj,
        searchController,
        isSelectedSwitch,
        selectedAllAttendees,
        isRejectMode,
        totalApprovedHours,
        totalAttendedHours,
        attendeeList,
        shiftIndex,
        eventName,
        eventDate,
        shift1Id,
        shift2Id,
        shift1AttendeeCount,
        shift2AttendeeCount,
        isLoading,
        errorMessage,
        selectedAttendees,
        selectedAttendeesCount,
        shift1Time,
        shift2Time,
        shift1Attendees,
        shift2Attendees,
        isSaving,
        sucessMessage,
      ];

  /// CopyWith method to handle updates
  VfApprovehoursscreenState copyWith({
    VfApprovehoursscreenModel? vfApprovehoursscreenModelObj,
    TextEditingController? searchController,
    bool? isSelectedSwitch,
    bool? selectedAllAttendees,
    bool? isRejectMode,
    double? totalApprovedHours,
    double? totalAttendedHours,
    List<Attendance>? attendeeList,
    int? shiftIndex,
    String? eventName,
    String? eventDate,
    String? shift1Id,
    String? shift2Id,
    int? shift1AttendeeCount,
    int? shift2AttendeeCount,
    String? shift1Time,
    String? shift2Time,
    List<Attendance>? shift1Attendees,
    List<Attendance>? shift2Attendees,

    // For new properties
    bool? isLoading,
    String? errorMessage,
    List<Attendance>? selectedAttendees,
    int? selectedAttendeesCount,
    bool? isSaving,
    String? sucessMessage,
  }) {
    return VfApprovehoursscreenState(
      vfApprovehoursscreenModelObj:
          vfApprovehoursscreenModelObj ?? this.vfApprovehoursscreenModelObj,
      searchController: searchController ?? this.searchController,
      isSelectedSwitch: isSelectedSwitch ?? this.isSelectedSwitch,
      selectedAllAttendees: selectedAllAttendees ?? this.selectedAllAttendees,
      isRejectMode: isRejectMode ?? this.isRejectMode,
      totalApprovedHours: totalApprovedHours ?? this.totalApprovedHours,
      totalAttendedHours: totalAttendedHours ?? this.totalAttendedHours,
      attendeeList: attendeeList ?? this.attendeeList,
      shiftIndex: shiftIndex ?? this.shiftIndex,
      eventName: eventName ?? this.eventName,
      eventDate: eventDate ?? this.eventDate,
      shift1Id: shift1Id ?? this.shift1Id,
      shift2Id: shift2Id ?? this.shift2Id,
      shift1AttendeeCount: shift1AttendeeCount ?? this.shift1AttendeeCount,
      shift2AttendeeCount: shift2AttendeeCount ?? this.shift2AttendeeCount,
      shift1Time: shift1Time ?? this.shift1Time,
      shift2Time: shift2Time ?? this.shift2Time,
      shift1Attendees: shift1Attendees ?? this.shift1Attendees,
      shift2Attendees: shift2Attendees ?? this.shift2Attendees,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedAttendees: selectedAttendees ?? this.selectedAttendees,
      selectedAttendeesCount:
          selectedAttendeesCount ?? this.selectedAttendeesCount,
      isSaving: isSaving ?? this.isSaving,
      sucessMessage: sucessMessage ?? this.sucessMessage,
    );
  }
}
