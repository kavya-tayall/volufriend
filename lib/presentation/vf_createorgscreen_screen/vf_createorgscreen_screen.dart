import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../widgets/custom_checkbox_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_text_field.dart';
import 'bloc/vf_createorgscreen_bloc.dart';
import 'models/vf_createorgscreen_model.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import '/crud_repository/volufriend_crud_repo.dart';
import '../../auth/bloc/login_user_bloc.dart';
import '../../widgets/vf_app_bar_with_title_back_button.dart';
import '../../presentation/app_navigation_screen/bloc/app_navigation_bloc.dart';

class VfCreateorgscreenScreen extends StatelessWidget {
  VfCreateorgscreenScreen({Key? key}) : super(key: key);
  final controller = MultiSelectController<causes>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final userState = userBloc.state;

    if (userState is NoHomeOrg || userState is LoginUserWithHomeOrg) {
      final userId = userState.userId;

      return BlocProvider<VfCreateorgscreenBloc>(
        create: (context) => VfCreateorgscreenBloc(
          VfCreateorgscreenState(
            userId: userId,
            vfCreateorgscreenModelObj: VfCreateorgscreenModel(),
          ),
          context.read<VolufriendCrudService>(),
        )..add(VfCreateorgscreenInitialEvent()),
        child: VfCreateorgscreenScreen(),
      );
    } else {
      return Scaffold(
        body: Center(child: Text('User data is not available')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: VfAppBarWithTitleBackButton(
          title: "Create Organization",
          onBackPressed: () => Navigator.of(context).pop(),
        ),
        body: BlocListener<VfCreateorgscreenBloc, VfCreateorgscreenState>(
          listener: (context, state) {
            if (state.isSaved) {
              NavigatorService.pushNamed(AppRoutes.vfHomescreenContainerScreen);
            } else if (state.errorMessage != null) {
              showErrorDialog(context, state.errorMessage!);
            }
          },
          child: BlocBuilder<VfCreateorgscreenBloc, VfCreateorgscreenState>(
            builder: (context, state) {
              return Form(
                key: _formKey,
                child: Container(
                  width: double.maxFinite,
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildIsSchoolCheckbox(context),
                        if (state.isSchoolCheckbox ?? false)
                          _buildSchoolLabel(context),
                        SizedBox(height: 16),
                        buildUserCauseMultiselect(
                          context,
                          controller,
                          state.selectedMultiSelectValuesforCauses,
                        ),
                        SizedBox(height: 16),
                        _buildOrgNameInput(context),
                        SizedBox(height: 16),
                        _buildOrgAddressInput(context),
                        SizedBox(height: 16),
                        _buildOrgEmailInput(context),
                        SizedBox(height: 16),
                        _buildOrgPhoneInput(context),
                        SizedBox(height: 16),
                        _buildOrgWebsiteInput(context),
                        SizedBox(height: 16),
                        _buildOrgContactInput(context),
                        SizedBox(height: 32),
                        _buildSaveButton(context),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSchoolLabel(BuildContext context) {
    return Text(
      "Green Lakes School District",
      style: TextStyle(fontSize: 16, color: Colors.black),
    );
  }

  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget buildUserCauseMultiselect(
      BuildContext context,
      MultiSelectController<causes> controller,
      List<causes>? selectedMultiSelectValuesforCauses) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: BlocSelector<VfCreateorgscreenBloc, VfCreateorgscreenState,
          VfCreateorgscreenModel?>(
        selector: (state) => state.vfCreateorgscreenModelObj,
        builder: (context, vfCreateorgscreenModelObj) {
          if (vfCreateorgscreenModelObj == null ||
              vfCreateorgscreenModelObj.causesList.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          List<DropdownItem<causes>> items =
              vfCreateorgscreenModelObj.causesList
                  .map((cause) => DropdownItem(
                        label: cause.name!,
                        value: cause,
                      ))
                  .toList();

          return Container(
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: MultiDropdown<causes>(
              items: items,
              controller: controller,
              enabled: true,
              searchEnabled: false,
              chipDecoration: const ChipDecoration(
                backgroundColor: Colors.grey,
                wrap: true,
                runSpacing: 2,
                spacing: 10,
              ),
              fieldDecoration: FieldDecoration(
                hintText: 'Select your causes',
                prefixIcon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onSelectionChange: (selectedItems) {
                context
                    .read<VfCreateorgscreenBloc>()
                    .add(UpdateMultiSelectValuesEvent(selectedItems));
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildIsSchoolCheckbox(BuildContext context) {
    return CustomCheckboxButton(
      alignment: Alignment.centerRight,
      text: "Is School",
      value: context
          .select((VfCreateorgscreenBloc bloc) => bloc.state.isSchoolCheckbox),
      textStyle: Theme.of(context).textTheme.bodyLarge,
      onChange: (value) {
        context.read<VfCreateorgscreenBloc>().add(
              ChangeIsSchoolCheckBoxEvent(
                  value: value,
                  parentOrgName: value ? "Northshore School District" : null),
            );
      },
    );
  }

  Widget _buildOrgNameInput(BuildContext context) {
    return _buildInputField(
      context,
      controller: context.select(
          (VfCreateorgscreenBloc bloc) => bloc.state.orgNameInputController),
      labelText: "Organization Name",
      validator: (value) =>
          value == null || value.isEmpty ? "Please enter a valid name" : null,
    );
  }

  Widget _buildOrgAddressInput(BuildContext context) {
    return _buildInputField(
      context,
      controller: context.select(
          (VfCreateorgscreenBloc bloc) => bloc.state.orgAddressInputController),
      labelText: "Organization Address",
    );
  }

  Widget _buildOrgEmailInput(BuildContext context) {
    return _buildInputField(
      context,
      controller: context.select(
          (VfCreateorgscreenBloc bloc) => bloc.state.orgEmailInputController),
      labelText: "Organization Email",
      keyboardType: TextInputType.emailAddress,
      validator: (value) => value != null && !isValidEmail(value)
          ? "Please enter a valid email"
          : null,
    );
  }

  Widget _buildOrgPhoneInput(BuildContext context) {
    return _buildInputField(
      context,
      controller: context.select(
          (VfCreateorgscreenBloc bloc) => bloc.state.orgPhoneInputController),
      labelText: "Organization Phone",
      keyboardType: TextInputType.phone,
      validator: (value) => value != null && !isValidPhone(value)
          ? "Please enter a valid phone number"
          : null,
    );
  }

  Widget _buildOrgWebsiteInput(BuildContext context) {
    return _buildInputField(
      context,
      controller: context.select(
          (VfCreateorgscreenBloc bloc) => bloc.state.orgWebsiteInputController),
      labelText: "Organization Website",
    );
  }

  Widget _buildOrgContactInput(BuildContext context) {
    return _buildInputField(
      context,
      controller: context.select(
          (VfCreateorgscreenBloc bloc) => bloc.state.orgPOCNameInputController),
      labelText: "Organization POC",
    );
  }

  Widget _buildInputField(BuildContext context,
      {required TextEditingController? controller,
      required String labelText,
      TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Save",
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          context.read<VfCreateorgscreenBloc>().add(SaveOrganizationEvent());
        }
      },
    );
  }
}
