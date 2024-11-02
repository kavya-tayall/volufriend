import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/vf_edituserprofile_bloc.dart';
import 'models/vf_edituserprofile_model.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:intl/intl.dart';
import '/crud_repository/volufriend_crud_repo.dart';
import '../../auth/bloc/login_user_bloc.dart';
import '../../presentation/vf_joinasscreen_screen/bloc/vf_joinasscreen_bloc.dart';
import '../../presentation/app_navigation_screen/bloc/app_navigation_bloc.dart';
import '../../widgets/vf_app_bar_with_title_back_button.dart';

class VfEdituserprofileScreen extends StatelessWidget {
  VfEdituserprofileScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final controller = MultiSelectController<causes>();

  static Widget builder(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final userState = userBloc.state;

    if (userState is NoHomeOrg) {
      final user = userState.user;
      final String userId = user.userid!;
      String contextType = "Volunteer";

      return BlocProvider<VfEdituserprofileBloc>(
        create: (context) => VfEdituserprofileBloc(
          VfEdituserprofileState(
            userId: userId,
            vfEdituserprofileModelObj: VfEdituserprofileModel(),
            contextType: contextType,
          ),
          context.read<VolufriendCrudService>(),
        )..add(VfEdituserprofileInitialEvent()),
        child: VfEdituserprofileScreen(),
      );
    } else if (userState is LoginUserWithHomeOrg) {
      final user = userState.user;
      final String userId = user.userid!;
      final String contextType = "Volunteer";

      return BlocProvider<VfEdituserprofileBloc>(
        create: (context) => VfEdituserprofileBloc(
          VfEdituserprofileState(
            userId: userId,
            vfEdituserprofileModelObj: VfEdituserprofileModel(),
            contextType: contextType,
          ),
          context.read<VolufriendCrudService>(),
        )..add(VfEdituserprofileInitialEvent()),
        child: VfEdituserprofileScreen(),
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
          title: "Edit User Profile",
          showFilterIcon: false,
          showSearchIcon: false,
          onBackPressed: () => Navigator.of(context).pop(),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<VfEdituserprofileBloc, VfEdituserprofileState>(
                builder: (context, state) {
                  if (state.isSaving) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (state.isSaved) {
                    Navigator.pop(context);
                  }

                  if (state.isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.errorMessage != null) {
                    return Center(child: Text('Error: ${state.errorMessage}'));
                  } else {
                    return Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: _buildReadOnlyLabel(
                                    context, state.contextType),
                              ),
                              const SizedBox(height: 8),
                              _buildLabel('Your Default Volunteer Organization',
                                  context),
                              _buildOrganizationDropdown(context, state),
                              const SizedBox(height: 12),
                              _buildLabel(
                                  'Two Causes You Care About Most', context),
                              buildUserCauseMultiselect1(
                                context,
                                controller,
                                state.selectedMultiSelectValuesforCauses,
                              ),
                              const SizedBox(height: 12),
                              _buildInputField(
                                context,
                                'First Name',
                                state.firstNameFieldController ??
                                    TextEditingController(),
                              ),
                              const SizedBox(height: 12),
                              _buildInputField(
                                context,
                                'Last Name',
                                state.lastNameFieldController ??
                                    TextEditingController(),
                              ),
                              const SizedBox(height: 12),
                              _buildInputField(
                                context,
                                'Email',
                                state.emailFieldController ??
                                    TextEditingController(),
                                textInputType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 12),
                              _buildInputField(
                                context,
                                'Phone Number',
                                state.phoneNumberFieldController ??
                                    TextEditingController(),
                                textInputType: TextInputType.phone,
                              ),
                              const SizedBox(height: 12),
                              _buildDOBField(
                                context,
                                state.DOBFieldController ??
                                    TextEditingController(),
                              ),
                              const SizedBox(height: 12),
                              _buildGenderField(context),
                              const SizedBox(height: 24),
                              _buildSaveButton(context),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
            ),
      ),
    );
  }

  Widget _buildInputField(
      BuildContext context, String hintText, TextEditingController controller,
      {TextInputType textInputType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: CustomTextFormField(
        controller: controller,
        validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
        hintText: hintText,
        textInputType: textInputType,
        borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadiusStyle.roundedBorder5,
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      title: AppbarTitle(
        text: "Edit User Profile",
        margin: const EdgeInsets.only(left: 16.0),
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildTabbedHeader(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Row(
        children: [
          Icon(Icons.person, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            'User Profile',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
          ),
        ],
      ),
    );
  }

  Widget buildUserCauseMultiselect1(
      BuildContext context,
      MultiSelectController<causes> controller,
      List<causes>? selectedMultiSelectValuesforCauses) {
    print('controller from param: $selectedMultiSelectValuesforCauses');

    return Padding(
      padding: EdgeInsets.only(
        left: 8.h,
        right: 4.h,
      ),
      child: BlocSelector<VfEdituserprofileBloc, VfEdituserprofileState,
          VfEdituserprofileModel?>(
        selector: (state) {
          return state.vfEdituserprofileModelObj;
        },
        builder: (context, vfEdituserprofileModelObj) {
          if (vfEdituserprofileModelObj == null ||
              vfEdituserprofileModelObj.causesList.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          List<DropdownItem<causes>> items =
              vfEdituserprofileModelObj.causesList
                  .map((cause) => DropdownItem(
                        label: cause.name!,
                        value: cause,
                      ))
                  .toList();

          List<DropdownItem<causes>> preSelectItems =
              selectedMultiSelectValuesforCauses
                      ?.map((cause) => DropdownItem(
                            label: cause.name!,
                            value: cause,
                          ))
                      .toList() ??
                  [];
          print('controller: $controller');
          // Initialize the controller with previously selected causes
          if (controller.selectedItems.isEmpty) {
            if (preSelectItems.isNotEmpty) {
              // Initialize the controller with previously selected causes based on causeId
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final preSelectCauseIds =
                    preSelectItems.map((item) => item.value.id).toSet();
                controller.selectWhere(
                    (element) => preSelectCauseIds.contains(element.value.id));
              });
            }
          }

          return Container(
            height: 64.h,
            width: double.infinity,
            margin: EdgeInsets.only(left: 8.h, right: 4.h),
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
                hintStyle: theme.textTheme.bodySmall,
                prefixIcon: CustomImageView(
                  imagePath: ImageConstant.imgIcArrowDropDown48px,
                  height: 20.h,
                  width: 20.h,
                ),
                showClearIcon: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    color: theme.primaryColor,
                  ),
                ),
              ),
              dropdownDecoration: const DropdownDecoration(
                marginTop: 8,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              onSelectionChange: (selectedItems) {
                print('Selected value: $selectedItems'); // Debug print
                context.read<VfEdituserprofileBloc>().add(
                      UpdateMultiSelectValuesEvent(selectedItems),
                    );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildOrganizationDropdown(
      BuildContext context, VfEdituserprofileState state) {
    return BlocSelector<VfEdituserprofileBloc, VfEdituserprofileState,
        VfEdituserprofileModel?>(
      selector: (state) => state.vfEdituserprofileModelObj,
      builder: (context, vfEdituserprofileModelObj) {
        List<SelectionPopupModel> items = vfEdituserprofileModelObj
                ?.organizationList
                .map((org) => SelectionPopupModel(id: org.id, title: org.name!))
                .toList() ??
            [];
        final selectedDropDownValueforHomeOrg = context
            .read<VfEdituserprofileBloc>()
            .state
            .selectedDropDownValueforHomeOrg;

        SelectionPopupModel? initialValue;
        if (selectedDropDownValueforHomeOrg != null) {
          initialValue = items.firstWhere(
            (item) => item.id == selectedDropDownValueforHomeOrg.id,
            orElse: () => SelectionPopupModel(id: '', title: ''),
          );
        }

        return CustomDropDown(
          icon: Container(
            margin: const EdgeInsets.only(left: 16),
            child: CustomImageView(
              imagePath: ImageConstant.imgIcarrowdropdown48pxPrimary,
              height: 24,
              width: 24,
            ),
          ),
          hintText: "Select your organization",
          items: items,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          onChanged: (selectedValue) {
            context
                .read<VfEdituserprofileBloc>()
                .add(UpdateDropDownSelectionEvent(selectedValue));
          },
          initialValue: initialValue?.id == '' ? null : initialValue,
        );
      },
    );
  }

  Widget _buildGenderField(BuildContext context) {
    return BlocSelector<VfEdituserprofileBloc, VfEdituserprofileState,
        VfEdituserprofileModel?>(
      selector: (state) => state.vfEdituserprofileModelObj,
      builder: (context, vfEdituserprofileModelObj) {
        List<SelectionPopupModel> genderItems = [
          SelectionPopupModel(id: 'Male', title: 'Male', value: 'Male'),
          SelectionPopupModel(id: 'Female', title: 'Female', value: 'Female'),
          SelectionPopupModel(id: 'Other', title: 'Other', value: 'Other'),
        ];

        final selectedGender = context
            .read<VfEdituserprofileBloc>()
            .state
            .selectedDropDownValueforGender;

        SelectionPopupModel? initialValue;
        if (selectedGender != null) {
          initialValue = genderItems.firstWhere(
            (item) => item.id == selectedGender.id,
            orElse: () =>
                SelectionPopupModel(id: '', title: '', value: 'Unknown'),
          );
        }

        return CustomDropDown(
          icon: Container(
            margin: const EdgeInsets.only(left: 16),
            child: CustomImageView(
              imagePath: ImageConstant.imgIcarrowdropdown48pxPrimary,
              height: 24,
              width: 24,
            ),
          ),
          hintText: "Select Gender",
          items: genderItems,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          onChanged: (SelectionPopupModel? selectedValue) {
            if (selectedValue != null) {
              context.read<VfEdituserprofileBloc>().add(
                    UpdateGenderDropDownSelectionEvent(selectedValue),
                  );
            }
          },
          initialValue: initialValue?.id == '' ? null : initialValue,
        );
      },
    );
  }

  Widget _buildDOBField(
      BuildContext context, TextEditingController controller) {
    return GestureDetector(
      onTap: () async {
        // Calculate the range for date selection (12 years to 60 years ago)
        DateTime maxDate = DateTime.now().subtract(Duration(days: 12 * 365));
        DateTime minDate = DateTime.now().subtract(Duration(days: 60 * 365));

        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate:
              maxDate, // Default to the maximum age date (12 years ago)
          firstDate: minDate, // Earliest date (60 years ago)
          lastDate: maxDate, // Latest date (12 years ago)
        );

        if (pickedDate != null) {
          final formattedDate = DateFormat('MM/dd/yyyy').format(pickedDate);
          controller.text = formattedDate;
        }
      },
      child: AbsorbPointer(
        child: CustomTextFormField(
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Required';
            }
            final dateRegex = RegExp(
                r'^(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])/([0-9]{4})$');
            if (!dateRegex.hasMatch(value)) {
              return 'Enter date in mm/dd/yyyy format';
            }
            // Additional check to ensure age is between 12 and 60 years
            final inputDate = DateFormat('MM/dd/yyyy').parse(value);
            DateTime maxDateForValidation =
                DateTime.now().subtract(Duration(days: 12 * 365));
            DateTime minDateForValidation =
                DateTime.now().subtract(Duration(days: 60 * 365));
            if (inputDate.isAfter(maxDateForValidation)) {
              return 'Age must be at least 12 years';
            }
            if (inputDate.isBefore(minDateForValidation)) {
              return 'Age must be at most 60 years';
            }
            return null;
          },
          hintText: 'Date of Birth (mm/dd/yyyy)',
          textInputType: TextInputType.datetime,
          borderDecoration: OutlineInputBorder(
            borderRadius: BorderRadiusStyle.roundedBorder5,
          ),
        ),
      ),
    );
  }

  Widget _buildReadOnlyLabel(BuildContext context, String contextType) {
    TextEditingController controller = TextEditingController(text: contextType);
    return Container(
      width: 100,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: controller,
        readOnly: true,
        style: Theme.of(context).textTheme.bodyMedium,
        decoration: const InputDecoration.collapsed(hintText: null),
      ),
    );
  }

  Widget _buildFirstNameField(
      BuildContext context, TextEditingController controller) {
    return CustomTextFormField(
      controller: controller,
      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
      hintText: 'First Name',
      borderDecoration: OutlineInputBorder(
        borderRadius: BorderRadiusStyle.roundedBorder5,
      ),
    );
  }

  Widget _buildLastNameField(
      BuildContext context, TextEditingController controller) {
    return CustomTextFormField(
      controller: controller,
      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
      hintText: 'Last Name',
      borderDecoration: OutlineInputBorder(
        borderRadius: BorderRadiusStyle.roundedBorder5,
      ),
    );
  }

  Widget _buildEmailField(
      BuildContext context, TextEditingController controller) {
    return CustomTextFormField(
      controller: controller,
      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
      hintText: 'Email',
      textInputType: TextInputType.emailAddress,
      borderDecoration: OutlineInputBorder(
        borderRadius: BorderRadiusStyle.roundedBorder5,
      ),
    );
  }

  Widget _buildPhoneNumberField(
      BuildContext context, TextEditingController controller) {
    return CustomTextFormField(
      controller: controller,
      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
      hintText: 'Phone Number',
      textInputType: TextInputType.phone,
      borderDecoration: OutlineInputBorder(
        borderRadius: BorderRadiusStyle.roundedBorder5,
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return CustomElevatedButton(
      width: double.infinity,
      text: "Save",
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          context.read<VfEdituserprofileBloc>().add(SaveUserProfileEvent());
          final sourceScreen = context.select<AppNavigationBloc, String?>(
            (bloc) => bloc.state.sourceScreen,
          );

          final userProfileBloc = context.read<VfEdituserprofileBloc>();
          final userProfileState = userProfileBloc.state;
          final userHomeOrg = UserHomeOrg(
            userid: userProfileState.userId!,
          );

          final loginUser = LoginUser(
            userHomeOrg: userHomeOrg,
            isLoggedIn: true,
          );

          context.read<UserBloc>().add(CheckUserStatus(user: loginUser));

          if (sourceScreen != null) {
            NavigatorService.pushNamed(sourceScreen);
          } else {
            NavigatorService.pushNamed(AppRoutes.vfHomescreenPage);
          }
        }
      },
    );
  }

  void onTapArrowleftone(BuildContext context) {
    NavigatorService.goBack();
  }
}
