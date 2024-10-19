part of 'vf_createorgscreen_bloc.dart';

/// Represents the state of VfCreateorgscreen in the application.

/// Represents the state of VfCreateorgscreen in the application.

// ignore_for_file: must_be_immutable
class VfCreateorgscreenState extends Equatable {
  final String? userId;
  final String? OrgId;
  final TextEditingController? orgNameInputController;
  final TextEditingController? orgPOCNameInputController;
  final TextEditingController? orgAddressInputController;
  final TextEditingController? orgEmailInputController;
  final TextEditingController? orgPhoneInputController;
  final TextEditingController? orgWebsiteInputController;
  final TextEditingController? orgPicUrlInputController;
  final List<causes>? selectedMultiSelectValuesforCauses;
  final VfCreateorgscreenModel? vfCreateorgscreenModelObj;
  final bool isSchoolCheckbox;
  final String? errorMessage; // To capture and handle errors
  final bool isLoading; // To manage loading state
  final bool isSaved;
  final bool isSaving;
  final String? parentOrgName;

  VfCreateorgscreenState({
    this.userId = "",
    this.OrgId = "",
    this.orgNameInputController,
    this.orgPOCNameInputController,
    this.orgAddressInputController,
    this.orgEmailInputController,
    this.orgPhoneInputController,
    this.orgPicUrlInputController,
    this.orgWebsiteInputController,
    this.selectedMultiSelectValuesforCauses,
    this.isSchoolCheckbox = false,
    this.vfCreateorgscreenModelObj,
    this.errorMessage,
    this.isLoading = false,
    this.isSaved = false,
    this.isSaving = false,
    this.parentOrgName = "",
  });

  @override
  List<Object?> get props => [
        userId,
        OrgId,
        orgNameInputController,
        orgPOCNameInputController,
        orgAddressInputController,
        orgEmailInputController,
        orgPhoneInputController,
        orgPicUrlInputController,
        orgWebsiteInputController,
        selectedMultiSelectValuesforCauses,
        isSchoolCheckbox,
        vfCreateorgscreenModelObj,
        errorMessage,
        isLoading,
        isSaved,
        isSaving,
        parentOrgName,
      ];

  VfCreateorgscreenState copyWith({
    String? userId,
    String? OrgId,
    TextEditingController? orgNameInputController,
    TextEditingController? orgPOCNameInputController,
    TextEditingController? orgAddressInputController,
    TextEditingController? orgEmailInputController,
    TextEditingController? orgPhoneInputController,
    TextEditingController? orgWebsiteInputController,
    TextEditingController? orgPicUrlInputController,
    List<causes>? selectedMultiSelectValuesforCauses,
    bool? isSchoolCheckbox,
    VfCreateorgscreenModel? vfCreateorgscreenModelObj,
    String? errorMessage,
    bool? isLoading,
    bool? isSaved,
    bool? isSaving,
    String? parentOrgName,
  }) {
    return VfCreateorgscreenState(
      userId: userId ?? this.userId,
      OrgId: OrgId ?? this.OrgId,
      orgNameInputController:
          orgNameInputController ?? this.orgNameInputController,
      orgPOCNameInputController:
          orgPOCNameInputController ?? this.orgPOCNameInputController,
      orgAddressInputController:
          orgAddressInputController ?? this.orgAddressInputController,
      orgEmailInputController:
          orgEmailInputController ?? this.orgEmailInputController,
      orgPhoneInputController:
          orgPhoneInputController ?? this.orgPhoneInputController,
      orgPicUrlInputController:
          orgPicUrlInputController ?? this.orgPicUrlInputController,
      orgWebsiteInputController:
          orgWebsiteInputController ?? this.orgWebsiteInputController,
      selectedMultiSelectValuesforCauses: selectedMultiSelectValuesforCauses ??
          this.selectedMultiSelectValuesforCauses,
      isSchoolCheckbox: isSchoolCheckbox ?? this.isSchoolCheckbox,
      vfCreateorgscreenModelObj:
          vfCreateorgscreenModelObj ?? this.vfCreateorgscreenModelObj,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      isSaved: isSaved ?? this.isSaved,
      isSaving: isSaving ?? this.isSaving,
      parentOrgName: parentOrgName ?? this.parentOrgName,
    );
  }
}
