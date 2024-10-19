part of 'vf_createeventscreen2_eventshifts_bloc.dart';

/// Represents the state of VfCreateeventscreen2Eventshifts in the application.

// ignore_for_file: must_be_immutable
class VfCreateeventscreen2EventshiftsState extends Equatable {
  VfCreateeventscreen2EventshiftsState({
    this.isInitialized = false,
    this.eventId,
    TextEditingController? shift1ActivityInputController,
    TextEditingController? shift1StartTimeController,
    TextEditingController? shift1EndTimeController,
    TextEditingController? shift1MaxParticipantsController,
    TextEditingController? shift1MinimumAgeController,
    TextEditingController? shift2ActivityInputController,
    TextEditingController? shift2StartTimeController,
    TextEditingController? shift2EndTimeController,
    TextEditingController? shift2MaxParticipantsController,
    TextEditingController? shift2MinimumAgeController,
    this.vfCreateeventscreen2EventshiftsModelObj,
    this.isLoading = false,
    this.isSaved = false,
    this.isSaving = false,
    this.errorMessage,
  })  : shift1ActivityInputController =
            shift1ActivityInputController ?? TextEditingController(),
        shift1StartTimeController =
            shift1StartTimeController ?? TextEditingController(),
        shift1EndTimeController =
            shift1EndTimeController ?? TextEditingController(),
        shift1MaxParticipantsController =
            shift1MaxParticipantsController ?? TextEditingController(),
        shift1MinimumAgeController =
            shift1MinimumAgeController ?? TextEditingController(),
        shift2ActivityInputController =
            shift2ActivityInputController ?? TextEditingController(),
        shift2StartTimeController =
            shift2StartTimeController ?? TextEditingController(),
        shift2EndTimeController =
            shift2EndTimeController ?? TextEditingController(),
        shift2MaxParticipantsController =
            shift2MaxParticipantsController ?? TextEditingController(),
        shift2MinimumAgeController =
            shift2MinimumAgeController ?? TextEditingController();

  String? eventId;
  bool isInitialized;

  TextEditingController shift1ActivityInputController;
  TextEditingController shift1StartTimeController;
  TextEditingController shift1EndTimeController;
  TextEditingController shift1MaxParticipantsController;
  TextEditingController shift1MinimumAgeController;

  TextEditingController shift2ActivityInputController;
  TextEditingController shift2StartTimeController;
  TextEditingController shift2EndTimeController;
  TextEditingController shift2MaxParticipantsController;
  TextEditingController shift2MinimumAgeController;

  VfCreateeventscreen2EventshiftsModel? vfCreateeventscreen2EventshiftsModelObj;

  final bool isLoading;
  final bool isSaved;
  final bool isSaving;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        isInitialized,
        eventId,
        shift1ActivityInputController,
        shift1StartTimeController,
        shift1EndTimeController,
        shift1MaxParticipantsController,
        shift1MinimumAgeController,
        shift2ActivityInputController,
        shift2StartTimeController,
        shift2EndTimeController,
        shift2MaxParticipantsController,
        shift2MinimumAgeController,
        vfCreateeventscreen2EventshiftsModelObj,
        isLoading,
        isSaved,
        isSaving,
        errorMessage,
      ];

  VfCreateeventscreen2EventshiftsState copyWith({
    bool? isInitialized,
    String? eventId,
    TextEditingController? shift1ActivityInputController,
    TextEditingController? shift1StartTimeController,
    TextEditingController? shift1EndTimeController,
    TextEditingController? shift1MaxParticipantsController,
    TextEditingController? shift1MinimumAgeController,
    TextEditingController? shift2ActivityInputController,
    TextEditingController? shift2StartTimeController,
    TextEditingController? shift2EndTimeController,
    TextEditingController? shift2MaxParticipantsController,
    TextEditingController? shift2MinimumAgeController,
    VfCreateeventscreen2EventshiftsModel?
        vfCreateeventscreen2EventshiftsModelObj,
    bool? isLoading,
    bool? isSaved,
    bool? isSaving,
    String? errorMessage,
  }) {
    return VfCreateeventscreen2EventshiftsState(
      isInitialized: isInitialized ?? this.isInitialized,
      eventId: eventId ?? this.eventId,
      shift1ActivityInputController:
          shift1ActivityInputController ?? this.shift1ActivityInputController,
      shift1StartTimeController:
          shift1StartTimeController ?? this.shift1StartTimeController,
      shift1EndTimeController:
          shift1EndTimeController ?? this.shift1EndTimeController,
      shift1MaxParticipantsController: shift1MaxParticipantsController ??
          this.shift1MaxParticipantsController,
      shift1MinimumAgeController:
          shift1MinimumAgeController ?? this.shift1MinimumAgeController,
      shift2ActivityInputController:
          shift2ActivityInputController ?? this.shift2ActivityInputController,
      shift2StartTimeController:
          shift2StartTimeController ?? this.shift2StartTimeController,
      shift2EndTimeController:
          shift2EndTimeController ?? this.shift2EndTimeController,
      shift2MaxParticipantsController: shift2MaxParticipantsController ??
          this.shift2MaxParticipantsController,
      shift2MinimumAgeController:
          shift2MinimumAgeController ?? this.shift2MinimumAgeController,
      vfCreateeventscreen2EventshiftsModelObj:
          vfCreateeventscreen2EventshiftsModelObj ??
              this.vfCreateeventscreen2EventshiftsModelObj,
      isLoading: isLoading ?? this.isLoading,
      isSaved: isSaved ?? this.isSaved,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
