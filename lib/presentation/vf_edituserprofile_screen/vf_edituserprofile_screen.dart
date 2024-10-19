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
import '../../widgets/custom_floating_text_field.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/vf_edituserprofile_bloc.dart';
import 'models/vf_edituserprofile_model.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import '/crud_repository/volufriend_crud_repo.dart';
import '../../auth/bloc/login_user_bloc.dart';
import '../../presentation/vf_joinasscreen_screen/bloc/vf_joinasscreen_bloc.dart';
import '../../presentation/app_navigation_screen/bloc/app_navigation_bloc.dart';

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
      String contextType;
      contextType = "Volunteer";

      return BlocProvider<VfEdituserprofileBloc>(
        create: (context) => VfEdituserprofileBloc(
          VfEdituserprofileState(
            userId: userId,
            vfEdituserprofileModelObj: VfEdituserprofileModel(),
            contextType: contextType,
          ),
          context.read<VolufriendCrudService>(), // Access the service here
        )..add(VfEdituserprofileInitialEvent()),
        child: VfEdituserprofileScreen(),
      );
    } else {
      // Handle the case where user data is not available
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
        appBar: _buildAppBar(context),
        body: BlocBuilder<VfEdituserprofileBloc, VfEdituserprofileState>(
          builder: (context, state) {
            if (state.isSaving) {
              return Center(child: CircularProgressIndicator());
            }

            if (state.isSaved) {
              // Navigate back or show a success message
              Navigator.pop(context);
            }
            if (state.isLoading) {
              // Show loading indicator while data is being fetched
              return Center(child: CircularProgressIndicator());
            } else if (state.errorMessage != null) {
              // Show error message if there's an error
              return Center(child: Text('Error: ${state.errorMessage}'));
            } else {
              // Once data is loaded, show the form
              //print(state.phoneNumberFieldController);
              return Form(
                key: _formKey,
                child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      decoration: AppDecoration.fillBlueGray,
                      child: Column(
                        children: [
                          SizedBox(height: 64.h),
                          Container(
                            width: double.infinity,
                            decoration: AppDecoration.fillGray,
                            child: Column(
                              children: [
                                _buildUserTabRow(context),
                                SizedBox(
                                  width: double.infinity,
                                  child: Divider(
                                    color: appTheme.whiteA700,
                                  ),
                                ),
                                SizedBox(height: 18.h),

                                buildUserCauseMultiselect1(context, controller,
                                    state.selectedMultiSelectValuesforCauses),
                                SizedBox(height: 18.h),
                                _buildGenderField(context),
                                SizedBox(height: 18.h),
                                _buildDOBField(
                                    context,
                                    state.DOBFieldController ??
                                        TextEditingController()),
                                SizedBox(height: 18.h),
                                // Assuming you have a string

                                _buildReadOnlyLabel(context, state.contextType),
                                SizedBox(height: 18.h),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 8.h,
                                    right: 4.h,
                                  ),
                                  child: BlocSelector<
                                      VfEdituserprofileBloc,
                                      VfEdituserprofileState,
                                      VfEdituserprofileModel?>(
                                    selector: (state) =>
                                        state.vfEdituserprofileModelObj,
                                    builder:
                                        (context, vfEdituserprofileModelObj) {
                                      List<SelectionPopupModel> items =
                                          vfEdituserprofileModelObj
                                                  ?.organizationList
                                                  .map((org) =>
                                                      SelectionPopupModel(
                                                        id: org.id,
                                                        title: org.name!,
                                                      ))
                                                  .toList() ??
                                              [];
                                      final selectedDropDownValueforHomeOrg =
                                          context
                                              .read<VfEdituserprofileBloc>()
                                              .state
                                              .selectedDropDownValueforHomeOrg;

                                      // Determine the initial selection value
                                      SelectionPopupModel? initialValue;
                                      if (selectedDropDownValueforHomeOrg !=
                                          null) {
                                        initialValue = items.firstWhere(
                                          (item) =>
                                              item.id ==
                                              selectedDropDownValueforHomeOrg
                                                  .id,
                                          orElse: () => SelectionPopupModel(
                                              id: '', title: ''),
                                        );
                                      }

                                      return CustomDropDown(
                                        icon: Container(
                                          margin: EdgeInsets.only(left: 16.h),
                                          child: CustomImageView(
                                            imagePath: ImageConstant
                                                .imgIcarrowdropdown48pxPrimary,
                                            height: 24.h,
                                            width: 24.h,
                                          ),
                                        ),
                                        hintText: "msg_your_organization".tr,
                                        items: items,
                                        contentPadding: EdgeInsets.symmetric(
                                          horizontal: 14.h,
                                          vertical: 18.h,
                                        ),
                                        onChanged: (selectedValue) {
                                          // Handle dropdown change
                                          context
                                              .read<VfEdituserprofileBloc>()
                                              .add(
                                                UpdateDropDownSelectionEvent(
                                                    selectedValue),
                                              );
                                        },
                                        // Initial selection, using the first item as default
                                        initialValue: initialValue == null ||
                                                initialValue.id == ''
                                            ? null
                                            : initialValue,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                _buildFirstNameField(
                                    context,
                                    state.firstNameFieldController ??
                                        TextEditingController()),
                                SizedBox(height: 26.h),
                                _buildLastNameField(
                                    context,
                                    state.lastNameFieldController ??
                                        TextEditingController()),
                                SizedBox(height: 34.h),
                                _buildEmailField(
                                    context,
                                    state.emailFieldController ??
                                        TextEditingController()),
                                SizedBox(height: 26.h),
                                _buildPhoneNumberField(
                                    context,
                                    state.phoneNumberFieldController ??
                                        TextEditingController()),
                                SizedBox(height: 58.h),
                                _buildSaveButton(context),
                                SizedBox(height: 136.h)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 20.h,
          bottom: 20.h,
        ),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      title: AppbarTitle(
        text: "lbl_scrheadline".tr,
        margin: EdgeInsets.only(left: 16.h),
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildOrganizationButton(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        height: 48.h,
        text: "lbl_organization".tr,
        buttonStyle: CustomButtonStyles.fillWhiteA1,
        buttonTextStyle: CustomTextStyles.titleSmallBluegray90002,
      ),
    );
  }

  Widget _buildUserTabRow(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: AppDecoration.surface,
              child: Column(
                children: [
                  SizedBox(height: 14.h),
                  Text(
                    "lbl_user".tr,
                    style: CustomTextStyles.titleSmallPrimary,
                  ),
                  CustomImageView(
                    imagePath: ImageConstant.imgTelevision,
                    height: 14.h,
                    width: 30.h,
                  ),
                ],
              ),
            ),
          ),
          _buildOrganizationButton(context),
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

  Widget _buildGenderField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.h, right: 4.h),
      child: BlocSelector<VfEdituserprofileBloc, VfEdituserprofileState,
          VfEdituserprofileModel?>(
        selector: (state) => state.vfEdituserprofileModelObj,
        builder: (context, vfEdituserprofileModelObj) {
          // Define gender options
          List<SelectionPopupModel> genderItems = [
            SelectionPopupModel(id: 'Male', title: 'Male', value: 'Male'),
            SelectionPopupModel(id: 'Female', title: 'Female', value: 'Female'),
            SelectionPopupModel(id: 'Other', title: 'Other', value: 'Other'),
          ];

          // Retrieve the initially selected gender from the state
          final selectedGender = context
              .read<VfEdituserprofileBloc>()
              .state
              .selectedDropDownValueforGender;

          // Determine the initial selection value
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
              margin: EdgeInsets.only(left: 16.h),
              child: CustomImageView(
                imagePath: ImageConstant.imgIcarrowdropdown48pxPrimary,
                height: 24.h,
                width: 24.h,
              ),
            ),
            hintText: "Select Gender",
            items: genderItems,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.h,
              vertical: 18.h,
            ),
            onChanged: (SelectionPopupModel? selectedValue) {
              // Handle gender selection change
              if (selectedValue != null) {
                context.read<VfEdituserprofileBloc>().add(
                      UpdateGenderDropDownSelectionEvent(selectedValue),
                    );
              }
            },
            // Initial selection, using the first item as default if needed
            initialValue: initialValue?.id == '' ? null : initialValue,
          );
        },
      ),
    );
  }

  Widget _buildDOBField(
      BuildContext context, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(left: 8.h, right: 4.h),
      child: CustomTextFormField(
        controller: controller,
        validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
        hintText: 'Date of Birth',
        textInputType: TextInputType.datetime,
        borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadiusStyle.roundedBorder5,
        ),
      ),
    );
  }

  Widget _buildReadOnlyLabel(
    BuildContext context,
    String JoinAsRoleFromState,
  ) {
    // Create a TextEditingController and initialize it with the string
    TextEditingController controller =
        TextEditingController(text: JoinAsRoleFromState);

    return Padding(
      padding: EdgeInsets.only(left: 8.h, right: 4.h),
      child: CustomTextFormField(
        controller: controller,
        readOnly: true,
        borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        hintText: 'Read Only Field',
      ),
    );
  }

  Widget _buildFirstNameField(
      BuildContext context, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(left: 8.h, right: 4.h),
      child: CustomTextFormField(
        controller: controller,
        validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
        hintText: 'First Name',
        borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadiusStyle.roundedBorder5,
        ),
      ),
    );
  }

  Widget _buildLastNameField(
      BuildContext context, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(left: 8.h, right: 4.h),
      child: CustomTextFormField(
        controller: controller,
        validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
        hintText: 'Last Name',
        borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadiusStyle.roundedBorder5,
        ),
      ),
    );
  }

  Widget _buildEmailField(
      BuildContext context, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(left: 8.h, right: 4.h),
      child: CustomTextFormField(
        controller: controller,
        validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
        hintText: 'Email',
        textInputType: TextInputType.emailAddress,
        borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadiusStyle.roundedBorder5,
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField(
      BuildContext context, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(left: 8.h, right: 4.h),
      child: CustomTextFormField(
        controller: controller,
        validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
        hintText: 'Phone Number',
        textInputType: TextInputType.phone,
        borderDecoration: OutlineInputBorder(
          borderRadius: BorderRadiusStyle.roundedBorder5,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildSaveButton(BuildContext context) {
    return CustomElevatedButton(
      width: 106.h,
      text: "lbl_save".tr,
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          // Trigger the SaveUserProfileEvent with the updated user data
          context.read<VfEdituserprofileBloc>().add(SaveUserProfileEvent());
          final sourceScreen = context.select<AppNavigationBloc, String?>(
            (bloc) => bloc.state.sourceScreen,
          );

          // check user status and set global Login Object
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
            // Handle case where sourceScreen is null
            NavigatorService.pushNamed(
                AppRoutes.vfHomescreenPage); // Fallback route
          }
        }
      },
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone(BuildContext context) {
    NavigatorService.goBack();
  }
}
