part of 'vf_edituserprofile_bloc.dart';

/// Represents the state of VfEdituserprofile in the application.

/// Represents the state of VfEdituserprofile in the application.
/// Represents the state of VfEdituserprofile in the application.
class VfEdituserprofileState extends Equatable {
  final String? userId;
  final TextEditingController? firstNameFieldController;
  final TextEditingController? lastNameFieldController;
  final TextEditingController? emailFieldController;
  final TextEditingController? phoneNumberFieldController;
  final TextEditingController? DOBFieldController;
  final TextEditingController? JoinAsRoleController;
  final SelectionPopupModel? selectedDropDownValueforHomeOrg;
  final SelectionPopupModel? selectedDropDownValueforGender;
  final List<causes>? selectedMultiSelectValuesforCauses;
  final VfEdituserprofileModel? vfEdituserprofileModelObj;
  final String? readOnlyFieldValueJoinAsRole;
  final String? errorMessage; // To capture and handle errors
  final bool isLoading; // To manage loading state
  final bool isSaved;
  final bool isSaving;
  final String contextType; // Added contextType to the state

  VfEdituserprofileState({
    this.userId,
    this.firstNameFieldController,
    this.lastNameFieldController,
    this.emailFieldController,
    this.phoneNumberFieldController,
    this.DOBFieldController,
    this.JoinAsRoleController,
    this.selectedDropDownValueforHomeOrg,
    this.selectedDropDownValueforGender,
    this.selectedMultiSelectValuesforCauses,
    this.vfEdituserprofileModelObj,
    this.readOnlyFieldValueJoinAsRole,
    this.errorMessage,
    this.isLoading = false,
    this.isSaved = false,
    this.isSaving = false,
    required this.contextType, // Make contextType a required parameter
  });

  @override
  List<Object?> get props => [
        userId,
        firstNameFieldController,
        lastNameFieldController,
        emailFieldController,
        phoneNumberFieldController,
        DOBFieldController,
        JoinAsRoleController,
        selectedDropDownValueforHomeOrg,
        selectedDropDownValueforGender,
        selectedMultiSelectValuesforCauses,
        vfEdituserprofileModelObj,
        readOnlyFieldValueJoinAsRole,
        errorMessage,
        isLoading,
        isSaved,
        isSaving,
        contextType, // Include contextType in the props
      ];

  VfEdituserprofileState copyWith({
    String? userId,
    TextEditingController? firstNameFieldController,
    TextEditingController? lastNameFieldController,
    TextEditingController? emailFieldController,
    TextEditingController? phoneNumberFieldController,
    TextEditingController? DOBFieldController,
    TextEditingController? JoinAsRoleController,
    SelectionPopupModel? selectedDropDownValueforHomeOrg,
    SelectionPopupModel? selectedDropDownValueforGender,
    List<causes>? selectedMultiSelectValuesforCauses,
    VfEdituserprofileModel? vfEdituserprofileModelObj,
    String? readOnlyFieldValueJoinAsRole,
    String? errorMessage,
    bool? isLoading,
    bool? isSaved,
    bool? isSaving,
    String? contextType, // Added contextType to the copyWith method
  }) {
    return VfEdituserprofileState(
      userId: userId ?? this.userId,
      firstNameFieldController:
          firstNameFieldController ?? this.firstNameFieldController,
      lastNameFieldController:
          lastNameFieldController ?? this.lastNameFieldController,
      emailFieldController: emailFieldController ?? this.emailFieldController,
      phoneNumberFieldController:
          phoneNumberFieldController ?? this.phoneNumberFieldController,
      DOBFieldController: DOBFieldController ?? this.DOBFieldController,
      JoinAsRoleController: JoinAsRoleController ?? this.JoinAsRoleController,
      selectedDropDownValueforHomeOrg: selectedDropDownValueforHomeOrg ??
          this.selectedDropDownValueforHomeOrg,
      selectedDropDownValueforGender:
          selectedDropDownValueforGender ?? this.selectedDropDownValueforGender,
      selectedMultiSelectValuesforCauses: selectedMultiSelectValuesforCauses ??
          this.selectedMultiSelectValuesforCauses,
      vfEdituserprofileModelObj:
          vfEdituserprofileModelObj ?? this.vfEdituserprofileModelObj,
      readOnlyFieldValueJoinAsRole:
          readOnlyFieldValueJoinAsRole ?? this.readOnlyFieldValueJoinAsRole,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      isSaved: isSaved ?? this.isSaved,
      isSaving: isSaving ?? this.isSaving,
      contextType: contextType ?? this.contextType, // Handle contextType here
    );
  }
}
