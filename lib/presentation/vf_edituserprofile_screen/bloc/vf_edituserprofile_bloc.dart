import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/app_export.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../models/vf_edituserprofile_model.dart';
import '/crud_repository/volufriend_crud_repo.dart';
import 'package:intl/intl.dart';

part 'vf_edituserprofile_event.dart';
part 'vf_edituserprofile_state.dart';

class VfEdituserprofileBloc
    extends Bloc<VfEdituserprofileEvent, VfEdituserprofileState> {
  final VolufriendCrudService vfcrudService;

  VfEdituserprofileBloc(VfEdituserprofileState initialState, this.vfcrudService)
      : super(initialState) {
    on<VfEdituserprofileInitialEvent>(_onInitialEvent);
    on<LoadDropdownDataEvent>(_onLoadDropdownDataEvent);
    on<LoadMultiSelectDataEvent>(_onLoadMultiSelectDataEvent);
    on<UpdateDropDownSelectionEvent>(_onUpdateDropDownSelectionEvent);
    on<UpdateGenderDropDownSelectionEvent>(
        _onUpdateGenderDropDownSelectionEvent);
    on<UpdateMultiSelectValuesEvent>(_onUpdateMultiSelectValuesEvent);
    on<UpdateFieldEvent>(_onUpdateFieldEvent);
    on<SaveUserProfileEvent>(_onSaveUserProfileEvent);
    on<LoadGenderOptionsEvent>(_populateGenderOptions);
    ;
  }

  Future<void> _populateGenderOptions(LoadGenderOptionsEvent event,
      Emitter<VfEdituserprofileState> emit) async {
    // Define the hardcoded gender options
    List<GenderOptions> hardcodedGenderOptions = [
      GenderOptions(id: 'Male', option: 'Male'),
      GenderOptions(id: 'Female', option: 'Female'),
      GenderOptions(id: 'Other', option: 'Other'),
    ];

    // Emit state with updated gender options
    emit(state.copyWith(
      vfEdituserprofileModelObj: state.vfEdituserprofileModelObj?.copyWith(
        genderoptions: hardcodedGenderOptions,
      ),
    ));
  }

  Future<void> _onInitialEvent(VfEdituserprofileInitialEvent event,
      Emitter<VfEdituserprofileState> emit) async {
    print('Handling VfEdituserprofileInitialEvent');

    emit(state.copyWith(isLoading: true)); // Start loading state

    // Load dropdown and multi-select data first
    await Future.wait([
      _onLoadDropdownDataEvent(LoadDropdownDataEvent(), emit),
      _onLoadMultiSelectDataEvent(LoadMultiSelectDataEvent(), emit),
      _populateGenderOptions(LoadGenderOptionsEvent(), emit),
    ]);

    // Fetch user profile after data has been loaded
    final userProfile = await vfcrudService.getUser(state.userId!);
    // Update screen object model user profile
    state.copyWith(
        vfEdituserprofileModelObj: state.vfEdituserprofileModelObj
            ?.copyWith(userProfile: userProfile));

    print("contexttype");
    print(state.contextType);

    if (userProfile.role != null && userProfile.role!.isNotEmpty) {
      if (userProfile.role != state.contextType) {
        // Throw an error if the role does not match the expected context type
        emit(state.copyWith(isLoading: false)); // Start loading state
        throw Exception('Error: Role does not match the expected context.');
      }
    }
    // Initialize controllers with fetched data
    final firstNameFieldController =
        TextEditingController(text: userProfile.firstName ?? '');
    final lastNameFieldController =
        TextEditingController(text: userProfile.lastName ?? '');
    final emailFieldController =
        TextEditingController(text: userProfile.email ?? '');
    final phoneNumberFieldController =
        TextEditingController(text: userProfile.phone ?? '');

    String readOnlyFieldValueJoinAsRole;

// Determine the value of `readOnlyFieldValueJoinAsRole` based on `userProfile.role`
    if (userProfile.role == null || userProfile.role!.isEmpty) {
      readOnlyFieldValueJoinAsRole = state.contextType;
    } else {
      readOnlyFieldValueJoinAsRole = userProfile.role!;
    }

// Create the `JoinAsRoleController` with the determined value
    final JoinAsRoleController =
        TextEditingController(text: readOnlyFieldValueJoinAsRole);

    // Format DOB as a string (assuming you want to display it as 'MM/dd/yyyy')
    final DOBFieldController = TextEditingController(
      text: userProfile.dob != null
          ? DateFormat('MM/dd/yyyy').format(userProfile.dob!)
          : '',
    );

    // Convert Organization to SelectionPopupModel
    SelectionPopupModel convertOrganizationToSelectionPopupModel(
        Organization org) {
      return SelectionPopupModel(
        id: org.id,
        title: org.name ?? '', // Handle potential null name
        value: org, // Store the entire object or any other relevant value
      );
    }

// Convert GenderOptions to SelectionPopupModel
    SelectionPopupModel convertGenderOptionsToSelectionPopupModel(
        GenderOptions gender) {
      return SelectionPopupModel(
        id: gender.id, // Ensure this is a string or an ID
        title: gender.option ?? '', // Title or label for display
        value:
            gender.id, // Store id or another relevant property for comparison
      );
    }

    // Ensure that vfEdituserprofileModelObj has been updated with data
    // Model contains user profile, list of all orgs , list of all causes and all genders

    final vfEditUserProfileModel = state.vfEdituserprofileModelObj;

    // Set pre-selected dropdown values for home org
    final selectedDropDownValueforHomeOrg = vfEditUserProfileModel
        ?.organizationList
        .map((org) => convertOrganizationToSelectionPopupModel(org))
        .firstWhere(
          (model) => model.id == userProfile.HomeOrSchoolOrgId,
          orElse: () => SelectionPopupModel(
              id: '', title: '', value: ''), // Default with empty values
        );

    // Set pre-selected dropdown values for gender

    final selectedDropDownValueforGender = vfEditUserProfileModel?.genderoptions
        .map((gender) => convertGenderOptionsToSelectionPopupModel(gender))
        .firstWhere(
          (model) => model.id == userProfile.gender,
          orElse: () => SelectionPopupModel(
              id: 'defaultId', title: 'Select Gender', value: 'defaultValue'),
        );

    // Set pre-selected multi-select values for causes
    final selectedMultiSelectValuesforCauses = vfEditUserProfileModel
            ?.causesList
            .where((cause) => userProfile.causes?.contains(cause.id) ?? false)
            .toList() ??
        [];

    // Initialize screen form controllers and state
    emit(state.copyWith(
      firstNameFieldController: firstNameFieldController,
      lastNameFieldController: lastNameFieldController,
      emailFieldController: emailFieldController,
      phoneNumberFieldController: phoneNumberFieldController,
      DOBFieldController: DOBFieldController,
      selectedDropDownValueforHomeOrg: selectedDropDownValueforHomeOrg,
      selectedDropDownValueforGender: selectedDropDownValueforGender,
      selectedMultiSelectValuesforCauses: selectedMultiSelectValuesforCauses,
      vfEdituserprofileModelObj: vfEditUserProfileModel,
      JoinAsRoleController: JoinAsRoleController,
      readOnlyFieldValueJoinAsRole: readOnlyFieldValueJoinAsRole,
      isSaved: false,
      isLoading: false, // Stop loading state
    ));
  }

  Future<void> _onLoadDropdownDataEvent(
      LoadDropdownDataEvent event, Emitter<VfEdituserprofileState> emit) async {
    print('Handling LoadDropdownDataEvent');
    try {
      final homeOrgData = await vfcrudService.getOrgList();
      print("Sucess Org Data Fetch");
      //  print(homeOrgData);
      emit(state.copyWith(
        vfEdituserprofileModelObj: state.vfEdituserprofileModelObj?.copyWith(
          organizationList: homeOrgData,
        ),
      ));
    } catch (error) {
      print('Error loading dropdown data: $error');
      emit(state.copyWith(errorMessage: 'Failed to load dropdown data'));
    }
  }

  Future<void> _onLoadMultiSelectDataEvent(LoadMultiSelectDataEvent event,
      Emitter<VfEdituserprofileState> emit) async {
    print('Handling LoadMultiSelectDataEvent');
    try {
      final causesData = await vfcrudService.getcauses();
      emit(state.copyWith(
        vfEdituserprofileModelObj: state.vfEdituserprofileModelObj?.copyWith(
          causesList: causesData,
        ),
      ));
    } catch (error) {
      print('Error loading multi-select data: $error');
      emit(state.copyWith(errorMessage: 'Failed to load multi-select data'));
    }
  }

  void _onUpdateDropDownSelectionEvent(UpdateDropDownSelectionEvent event,
      Emitter<VfEdituserprofileState> emit) {
    print('Handling UpdateDropDownSelectionEvent');
    emit(state.copyWith(
      selectedDropDownValueforHomeOrg: event.selectedValue,
    ));
  }

  void _onUpdateGenderDropDownSelectionEvent(
      UpdateGenderDropDownSelectionEvent event,
      Emitter<VfEdituserprofileState> emit) {
    print('Handling UpdateGenderDropDownSelectionEvent');
    emit(state.copyWith(
      selectedDropDownValueforGender: event.selectedValue,
    ));
  }

  void _onUpdateMultiSelectValuesEvent(UpdateMultiSelectValuesEvent event,
      Emitter<VfEdituserprofileState> emit) {
    print('Handling UpdateMultiSelectValuesEvent');
    emit(state.copyWith(
      selectedMultiSelectValuesforCauses: event.selectedValues,
    ));
  }

  void _onUpdateFieldEvent(
      UpdateFieldEvent event, Emitter<VfEdituserprofileState> emit) {
    print(
        'Handling UpdateFieldEvent: ${event.field} with value: ${event.value}');
    final updatedController = TextEditingController(text: event.value);

    switch (event.field) {
      case 'firstName':
        emit(state.copyWith(firstNameFieldController: updatedController));
        break;
      case 'lastName':
        emit(state.copyWith(lastNameFieldController: updatedController));
        break;
      case 'email':
        emit(state.copyWith(emailFieldController: updatedController));
        break;
      case 'phoneNumber':
        emit(state.copyWith(phoneNumberFieldController: updatedController));
        break;
      case 'DOB':
        emit(state.copyWith(DOBFieldController: updatedController));
        break;
      default:
        print('Unknown field: ${event.field}');
        break;
    }
  }

  Future<void> _onSaveUserProfileEvent(
      SaveUserProfileEvent event, Emitter<VfEdituserprofileState> emit) async {
    print('Handling SaveUserProfileEvent');

    // Emit saving state
    emit(state.copyWith(isSaving: true));

    try {
      final updateUserProfile = {
        'First Name': state.firstNameFieldController?.text ?? '',
        'Last Name': state.lastNameFieldController?.text ?? '',
        'email': state.emailFieldController?.text ?? '',
        'phone': state.phoneNumberFieldController?.text ?? '',
        'dob': state.DOBFieldController?.text ?? '',
        'school_home_org_id': state.selectedDropDownValueforHomeOrg?.id ?? '',
        'gender': state.selectedDropDownValueforGender?.id ?? '',
        'causes': state.selectedMultiSelectValuesforCauses
                ?.map((cause) => cause.id)
                .toList() ??
            [],
        'role': state.readOnlyFieldValueJoinAsRole ?? '',
        'updated_at': DateTime.now().toIso8601String(),
      };

      // Call service to save the updated user profile
      final savedUserProfile =
          await vfcrudService.updateUser(state.userId!, updateUserProfile);

      final updateUserOrg = {
        "orgId": state.selectedDropDownValueforHomeOrg?.id ?? '',
        "role": state.readOnlyFieldValueJoinAsRole ?? '',
        "createdAt": DateTime.now().toIso8601String(),
        "createdBy": state.userId!,
        "orgRole": "Not Applicable"
      };

      await vfcrudService.joinHomeOrg(state.userId!, updateUserOrg);

      // Update state with the response
      emit(state.copyWith(
        vfEdituserprofileModelObj: state.vfEdituserprofileModelObj?.copyWith(
          userProfile: savedUserProfile,
        ),
        isSaved: true,
        isSaving: false,
        errorMessage: null, // Clear any previous error message
      ));
      print('User profile saved successfully');
    } catch (error) {
      print('Error saving user profile: $error');

      // Emit state with error message and reset saving flag
      emit(state.copyWith(
        isSaving: false,
        isSaved: false,
        errorMessage: 'Failed to save user profile: $error',
      ));
    }
  }
}
