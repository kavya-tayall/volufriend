import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_export.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../models/vf_createorgscreen_model.dart';
import '/crud_repository/volufriend_crud_repo.dart';

part 'vf_createorgscreen_event.dart';
part 'vf_createorgscreen_state.dart';

class VfCreateorgscreenBloc
    extends Bloc<VfCreateorgscreenEvent, VfCreateorgscreenState> {
  final VolufriendCrudService vfcrudService;

  VfCreateorgscreenBloc(VfCreateorgscreenState initialState, this.vfcrudService)
      : super(initialState) {
    on<VfCreateorgscreenInitialEvent>(_onInitialize);
    on<ChangeIsSchoolCheckBoxEvent>(_changeCheckBox);
    on<LoadMultiSelectDataEvent>(_onLoadMultiSelectDataEvent);
    on<UpdateMultiSelectValuesEvent>(_onUpdateMultiSelectValuesEvent);
    on<SaveOrganizationEvent>(_onSaveOrganizationEvent);
    on<UpdateOrgFieldEvent>(_onUpdateFieldEvent);
  }

  Future<void> _onInitialize(VfCreateorgscreenInitialEvent event,
      Emitter<VfCreateorgscreenState> emit) async {
    emit(state.copyWith(isLoading: true));

    // Load dropdown and multi-select data first
    await _onLoadMultiSelectDataEvent(LoadMultiSelectDataEvent(), emit);
    print("I am here org");
    if (state.OrgId!.isNotEmpty) {
      // Fetch organization profile after data has been loaded
      final OrgProfile = await vfcrudService.getOrganization(state.OrgId!);

      // Update screen object model organization profile
      final updatedVfCreateorgscreenModelObj = state.vfCreateorgscreenModelObj
          ?.copyWith(organizationProfile: OrgProfile);

      // Set pre-selected multi-select values for causes
      final selectedMultiSelectValuesforCauses =
          updatedVfCreateorgscreenModelObj?.causesList
                  .where(
                      (cause) => OrgProfile.causes?.contains(cause.id) ?? false)
                  .toList() ??
              [];

      // Initialize controllers with fetched data
      final orgNameInputController =
          TextEditingController(text: OrgProfile.name ?? '');
      final orgPOCNameInputController =
          TextEditingController(text: OrgProfile.contactname ?? '');
      final orgAddressInputController =
          TextEditingController(text: OrgProfile.address ?? '');
      final orgEmailInputController =
          TextEditingController(text: OrgProfile.contactemail ?? '');
      final orgPhoneInputController =
          TextEditingController(text: OrgProfile.phone ?? '');
      final orgPicUrlInputController =
          TextEditingController(text: OrgProfile.picture_url ?? '');
      final orgWebsiteInputController =
          TextEditingController(text: OrgProfile.website ?? '');

      emit(state.copyWith(
        orgNameInputController: orgNameInputController,
        orgPOCNameInputController: orgPOCNameInputController,
        orgAddressInputController: orgAddressInputController,
        orgEmailInputController: orgEmailInputController,
        orgPhoneInputController: orgPhoneInputController,
        orgPicUrlInputController: orgPicUrlInputController,
        orgWebsiteInputController: orgWebsiteInputController,
        selectedMultiSelectValuesforCauses: selectedMultiSelectValuesforCauses,
        vfCreateorgscreenModelObj: updatedVfCreateorgscreenModelObj,
        isSchoolCheckbox: OrgProfile.isSchool ?? false,
        isLoading: false,
      ));
    } else {
      print("I will create org");
      emit(state.copyWith(
        orgNameInputController: TextEditingController(),
        orgPOCNameInputController: TextEditingController(),
        orgAddressInputController: TextEditingController(),
        orgEmailInputController: TextEditingController(),
        orgPhoneInputController: TextEditingController(),
        orgPicUrlInputController: TextEditingController(),
        orgWebsiteInputController: TextEditingController(),
        isSchoolCheckbox: false,
        isLoading: false,
      ));
    }
  }

  Future<void> _onLoadMultiSelectDataEvent(LoadMultiSelectDataEvent event,
      Emitter<VfCreateorgscreenState> emit) async {
    try {
      final causesData = await vfcrudService.getcauses();
      emit(state.copyWith(
        vfCreateorgscreenModelObj: state.vfCreateorgscreenModelObj?.copyWith(
          causesList: causesData,
        ),
      ));
    } catch (error) {
      emit(state.copyWith(errorMessage: 'Failed to load multi-select data'));
    }
  }

  void _onUpdateMultiSelectValuesEvent(UpdateMultiSelectValuesEvent event,
      Emitter<VfCreateorgscreenState> emit) {
    emit(state.copyWith(
      selectedMultiSelectValuesforCauses: event.selectedValues,
    ));
  }

  void _changeCheckBox(
      ChangeIsSchoolCheckBoxEvent event, Emitter<VfCreateorgscreenState> emit) {
    emit(state.copyWith(
      isSchoolCheckbox: event.value,
      parentOrgName: event.parentOrgName,
    ));
  }

  void _onUpdateFieldEvent(
      UpdateOrgFieldEvent event, Emitter<VfCreateorgscreenState> emit) {
    print(
        'Handling UpdateFieldEvent: ${event.field} with value: ${event.value}');
    final updatedController = TextEditingController(text: event.value);

    switch (event.field) {
      case 'orgname':
        emit(state.copyWith(orgNameInputController: updatedController));
        break;
      case 'lastName':
        emit(state.copyWith(orgAddressInputController: updatedController));
        break;
      case 'email':
        emit(state.copyWith(orgPOCNameInputController: updatedController));
        break;
      case 'phoneNumber':
        emit(state.copyWith(orgPhoneInputController: updatedController));
        break;
      case 'DOB':
        emit(state.copyWith(orgWebsiteInputController: updatedController));
        break;
      default:
        print('Unknown field: ${event.field}');
        break;
    }
  }

  Future<void> _onSaveOrganizationEvent(
      SaveOrganizationEvent event, Emitter<VfCreateorgscreenState> emit) async {
    print('Handling SaveUserProfileEvent');

    // Emit saving state
    emit(state.copyWith(isSaving: true));

    try {
      final CreateOrgBody = {
        'name': state.orgNameInputController?.text ?? '',
        'address': state.orgAddressInputController?.text ?? '',
        'contactname': state.orgPOCNameInputController?.text ?? '',
        'contactemail': state.orgEmailInputController?.text ?? '',
        'phone': state.orgPhoneInputController?.text ?? '',
        'website': state.orgWebsiteInputController?.text ?? '',
        'causes': state.selectedMultiSelectValuesforCauses
                ?.map((cause) => cause.id)
                .toList() ??
            [],
        'isSchool': state.isSchoolCheckbox ?? false,
        'picture_url': state.orgPicUrlInputController?.text ?? '',
        'updatedAt': DateTime.now().toIso8601String(),
        'updatedBy': state.userId ?? '',
        'createdAt': DateTime.now().toIso8601String(),
        'createdBy': state.userId ?? '',
        'parent_org': state.parentOrgName,
        // Include any other fields as necessary based on the schema
      };
      print(CreateOrgBody);
      // Call service to save the updated user profile
      final savedOrganizationProfile =
          await vfcrudService.addNewOrg(CreateOrgBody);

      final updateUserOrg = {
        "orgId": savedOrganizationProfile.id,
        "role": 'Organization',
        "createdAt": DateTime.now().toIso8601String(),
        "createdBy": state.userId!,
        "orgRole": "Admin"
      };

      await vfcrudService.joinHomeOrg(state.userId!, updateUserOrg);
      // Update state with the response
      emit(state.copyWith(
        vfCreateorgscreenModelObj: state.vfCreateorgscreenModelObj?.copyWith(
          organizationProfile: savedOrganizationProfile,
        ),
        isSaved: true,
        isSaving: false,
        errorMessage: null, // Clear any previous error message
      ));
      print('Organization profile saved successfully');
    } catch (error) {
      print('Error saving Organization profile: $error');

      // Emit state with error message and reset saving flag
      emit(state.copyWith(
        isSaving: false,
        isSaved: false,
        errorMessage: 'Failed to save Organization profile: $error',
      ));
    }
  }
}
