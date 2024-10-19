part of 'vf_createeventscreen3_eventadditionaldetails_bloc.dart';

// part of 'vf_createeventscreen3_eventadditionaldetails_bloc.dart';

/// Represents the state of VfCreateeventscreen3Eventadditionaldetails in the application.

// ignore_for_file: must_be_immutable
class VfCreateeventscreen3EventadditionaldetailsState extends Equatable {
  VfCreateeventscreen3EventadditionaldetailsState({
    this.eventId,
    TextEditingController? additionalDetailsTextAreaController,
    TextEditingController? nofilechosenvalController,
    TextEditingController? coordinatorNameInputController,
    TextEditingController? coordinatorEmailInputController,
    TextEditingController? coordinatorPhoneInputController,
    TextEditingController? phoneNumberController,
    this.selectedCountry,
    this.vfCreateeventscreen3EventadditionaldetailsModelObj,
    this.uploadedFilePath,
    this.isSaving = false,
    this.isSaved = false,
    this.isLoading = false,
    this.errorMessage,
    this.isInitialized = false,
    this.eventAlbum,
    this.isSavedtoDb = false,
    this.SaveDbIntent = false,
  })  : additionalDetailsTextAreaController =
            additionalDetailsTextAreaController ?? TextEditingController(),
        nofilechosenvalController =
            nofilechosenvalController ?? TextEditingController(),
        coordinatorNameInputController =
            coordinatorNameInputController ?? TextEditingController(),
        coordinatorEmailInputController =
            coordinatorEmailInputController ?? TextEditingController(),
        coordinatorPhoneInputController =
            coordinatorPhoneInputController ?? TextEditingController(),
        phoneNumberController =
            phoneNumberController ?? TextEditingController();

  String? eventId;
  EventAlbum? eventAlbum;
  TextEditingController additionalDetailsTextAreaController;
  TextEditingController nofilechosenvalController;
  TextEditingController coordinatorNameInputController;
  TextEditingController coordinatorEmailInputController;
  TextEditingController coordinatorPhoneInputController;
  TextEditingController phoneNumberController;
  VfCreateEventScreen3EventAdditionalDetailsModel?
      vfCreateeventscreen3EventadditionaldetailsModelObj;
  Country? selectedCountry;
  String? uploadedFilePath;
  final bool isSaving;
  final bool isSaved;
  final bool isLoading;
  final String? errorMessage;
  final bool isInitialized;
  final bool isSavedtoDb;
  final bool SaveDbIntent;

  @override
  List<Object?> get props => [
        eventId,
        additionalDetailsTextAreaController,
        nofilechosenvalController,
        coordinatorNameInputController,
        coordinatorEmailInputController,
        coordinatorPhoneInputController,
        phoneNumberController,
        selectedCountry,
        uploadedFilePath,
        vfCreateeventscreen3EventadditionaldetailsModelObj,
        isSaving,
        isSaved,
        isLoading,
        errorMessage,
        isInitialized,
        eventAlbum,
        isSavedtoDb,
        SaveDbIntent,
      ];

  VfCreateeventscreen3EventadditionaldetailsState copyWith({
    String? eventId,
    TextEditingController? additionalDetailsTextAreaController,
    TextEditingController? nofilechosenvalController,
    TextEditingController? coordinatorNameInputController,
    TextEditingController? coordinatorEmailInputController,
    TextEditingController? coordinatorPhoneInputController,
    TextEditingController? phoneNumberController,
    Country? selectedCountry,
    VfCreateEventScreen3EventAdditionalDetailsModel?
        vfCreateeventscreen3EventadditionaldetailsModelObj,
    String? uploadedFilePath,
    bool? isSaving,
    bool? isSaved,
    bool? isLoading,
    String? errorMessage,
    bool? isInitialized,
    EventAlbum? eventAlbum,
    bool? isSavedtoDb,
    bool? SaveDbIntent,
  }) {
    return VfCreateeventscreen3EventadditionaldetailsState(
      eventId: eventId ?? this.eventId,
      additionalDetailsTextAreaController:
          additionalDetailsTextAreaController ??
              this.additionalDetailsTextAreaController,
      nofilechosenvalController:
          nofilechosenvalController ?? this.nofilechosenvalController,
      coordinatorNameInputController:
          coordinatorNameInputController ?? this.coordinatorNameInputController,
      coordinatorEmailInputController: coordinatorEmailInputController ??
          this.coordinatorEmailInputController,
      coordinatorPhoneInputController: coordinatorPhoneInputController ??
          this.coordinatorPhoneInputController,
      phoneNumberController:
          phoneNumberController ?? this.phoneNumberController,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      vfCreateeventscreen3EventadditionaldetailsModelObj:
          vfCreateeventscreen3EventadditionaldetailsModelObj ??
              this.vfCreateeventscreen3EventadditionaldetailsModelObj,
      uploadedFilePath: uploadedFilePath ?? this.uploadedFilePath,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isInitialized: isInitialized ?? this.isInitialized,
      eventAlbum: eventAlbum ?? this.eventAlbum,
      isSavedtoDb: isSavedtoDb ?? this.isSavedtoDb,
      SaveDbIntent: SaveDbIntent ?? this.SaveDbIntent,
    );
  }
}
