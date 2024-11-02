part of 'vf_createeventscreen1_eventdetails_bloc.dart';

/// Represents the state of VfCreateeventscreen1Eventdetails in the application.
class VfCreateeventscreen1EventdetailsState extends Equatable {
  VfCreateeventscreen1EventdetailsState({
    this.isInitialized = false,
    this.eventId = '',
    this.formContext = '',
    TextEditingController? titleInputController,
    TextEditingController? venueInputController,
    TextEditingController? eventDateInputController,
    TextEditingController? minimumAgeInputController,
    TextEditingController? registrationDeadlineInputController,
    this.selectedEventHostingOptionDropDownValue,
    this.selectedCausesDropDownValue,
    this.vfCreateeventscreen1EventdetailsModelObj,
    this.selectedEventDateInput,
    this.selectedregdeadline,
    this.isLoading = false,
    this.isSaved = false,
    this.isSaving = false,
    this.errorMessage,
    this.useridinorg,
    this.orgId,
    this.parentOrg,
    this.orgName,
  })  : titleInputController = titleInputController ?? TextEditingController(),
        venueInputController = venueInputController ?? TextEditingController(),
        eventDateInputController =
            eventDateInputController ?? TextEditingController(),
        minimumAgeInputController =
            minimumAgeInputController ?? TextEditingController(),
        registrationDeadlineInputController =
            registrationDeadlineInputController ?? TextEditingController();

  bool isInitialized;
  String eventId;
  String formContext;
  TextEditingController titleInputController;
  TextEditingController venueInputController;
  TextEditingController eventDateInputController;
  TextEditingController minimumAgeInputController;
  TextEditingController registrationDeadlineInputController;
  SelectionPopupModel? selectedCausesDropDownValue;
  List<EventHostingType>? selectedEventHostingOptionDropDownValue;
  VfCreateeventscreen1EventdetailsModel?
      vfCreateeventscreen1EventdetailsModelObj;
  DateTime? selectedEventDateInput;
  DateTime? selectedregdeadline;
  final bool isLoading;
  final bool isSaved;
  final bool isSaving;
  final String? errorMessage;
  final String? useridinorg;
  final String? orgId;
  final String? parentOrg;
  final String? orgName;

  @override
  List<Object?> get props => [
        isInitialized,
        eventId,
        formContext,
        titleInputController,
        venueInputController,
        eventDateInputController,
        minimumAgeInputController,
        registrationDeadlineInputController,
        selectedCausesDropDownValue,
        selectedEventHostingOptionDropDownValue,
        vfCreateeventscreen1EventdetailsModelObj,
        selectedEventDateInput,
        selectedregdeadline,
        isLoading,
        isSaved,
        isSaving,
        errorMessage,
        useridinorg,
        orgId,
        parentOrg,
        orgName,
      ];

  VfCreateeventscreen1EventdetailsState copyWith({
    bool? isInitialized,
    String? eventId,
    String? formContext,
    TextEditingController? titleInputController,
    TextEditingController? venueInputController,
    TextEditingController? eventDateInputController,
    TextEditingController? minimumAgeInputController,
    TextEditingController? registrationDeadlineInputController,
    SelectionPopupModel? selectedCausesDropDownValue,
    List<EventHostingType>? selectedEventHostingOptionDropDownValue,
    VfCreateeventscreen1EventdetailsModel?
        vfCreateeventscreen1EventdetailsModelObj,
    DateTime? selectedEventDateInput,
    DateTime? selectedregdeadline,
    bool? isLoading,
    bool? isSaved,
    bool? isSaving,
    String? errorMessage,
    String? useridinorg,
    String? orgId,
    String? parentOrg,
    String? orgName,
  }) {
    return VfCreateeventscreen1EventdetailsState(
      isInitialized: isInitialized ?? this.isInitialized,
      eventId: eventId ?? this.eventId,
      formContext: formContext ?? this.formContext,
      titleInputController: titleInputController ?? this.titleInputController,
      venueInputController: venueInputController ?? this.venueInputController,
      eventDateInputController:
          eventDateInputController ?? this.eventDateInputController,
      minimumAgeInputController:
          minimumAgeInputController ?? this.minimumAgeInputController,
      registrationDeadlineInputController:
          registrationDeadlineInputController ??
              this.registrationDeadlineInputController,
      selectedCausesDropDownValue:
          selectedCausesDropDownValue ?? this.selectedCausesDropDownValue,
      selectedEventHostingOptionDropDownValue:
          selectedEventHostingOptionDropDownValue ??
              this.selectedEventHostingOptionDropDownValue,
      vfCreateeventscreen1EventdetailsModelObj:
          vfCreateeventscreen1EventdetailsModelObj ??
              this.vfCreateeventscreen1EventdetailsModelObj,
      selectedEventDateInput:
          selectedEventDateInput ?? this.selectedEventDateInput,
      selectedregdeadline: selectedregdeadline ?? this.selectedregdeadline,
      isLoading: isLoading ?? this.isLoading,
      isSaved: isSaved ?? this.isSaved,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: errorMessage ?? this.errorMessage,
      useridinorg: useridinorg ?? this.useridinorg,
      orgId: orgId ?? this.orgId,
      parentOrg: parentOrg ?? this.parentOrg,
      orgName: orgName ?? this.orgName,
    );
  }
}

/// Initial blank state for VfCreateeventscreen1EventdetailsState.
final initialVfCreateeventscreen1EventdetailsState =
    VfCreateeventscreen1EventdetailsState(
  isInitialized: false,
  eventId: '',
  formContext: '',
  titleInputController: TextEditingController(),
  venueInputController: TextEditingController(),
  eventDateInputController: TextEditingController(),
  minimumAgeInputController: TextEditingController(),
  registrationDeadlineInputController: TextEditingController(),
  selectedCausesDropDownValue: null,
  selectedEventHostingOptionDropDownValue: [],
  vfCreateeventscreen1EventdetailsModelObj: null,
  selectedEventDateInput: null,
  selectedregdeadline: null,
  isLoading: false,
  isSaved: false,
  isSaving: false,
  errorMessage: null,
  useridinorg: null,
  orgId: null,
  parentOrg: null,
  orgName: null,
);
