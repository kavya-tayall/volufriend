import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_checkbox_button.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_text_field.dart';
import '../vf_homescreen_page/vf_homescreen_page.dart';
import 'bloc/vf_createorgscreen_bloc.dart';
import 'models/vf_createorgscreen_model.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import '/crud_repository/volufriend_crud_repo.dart';
import '../../auth/bloc/login_user_bloc.dart';
import '../../presentation/app_navigation_screen/bloc/app_navigation_bloc.dart';

// ignore_for_file: must_be_immutable
class VfCreateorgscreenScreen extends StatelessWidget {
  VfCreateorgscreenScreen({Key? key})
      : super(
          key: key,
        );
  final controller = MultiSelectController<causes>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final userState = userBloc.state;

    if (userState is NoHomeOrg || userState is LoginUserWithHomeOrg) {
      final userId = userState.userId; // Access userId from the user object

      return BlocProvider<VfCreateorgscreenBloc>(
        create: (context) => VfCreateorgscreenBloc(
          VfCreateorgscreenState(
            userId: userId,
            vfCreateorgscreenModelObj: VfCreateorgscreenModel(),
          ),
          context.read<VolufriendCrudService>(), // Access the service here
        )..add(VfCreateorgscreenInitialEvent()),
        child: VfCreateorgscreenScreen(),
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
        body: BlocBuilder<VfCreateorgscreenBloc, VfCreateorgscreenState>(
          builder: (context, state) {
            if (state.isSaved) {
              // Perform navigation after successful save
              final sourceScreen = context.select<AppNavigationBloc, String?>(
                (bloc) => bloc.state.sourceScreen,
              );

              if (sourceScreen != null) {
                NavigatorService.pushNamed(sourceScreen);
              } else {
                NavigatorService.pushNamed(AppRoutes.vfHomescreenPage);
              }
            } else if (state.errorMessage != null) {
              // Handle error case
              showErrorDialog(context, state.errorMessage!);
            }
            return Form(
              key: _formKey,
              child: SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: AppDecoration.fillBlueGray,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: 16.h),
                          decoration: AppDecoration.fillGray,
                          child: Column(
                            children: [
                              SizedBox(height: 16.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildIsSchoolCheckbox(context),
                                  if (state.isSchoolCheckbox ?? false)
                                    _buildSchoolLabel(context),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              buildUserCauseMultiselect(
                                context,
                                controller,
                                state.selectedMultiSelectValuesforCauses,
                              ),
                              SizedBox(height: 16.h),
                              _buildOrgNameInput(context),
                              SizedBox(height: 16.h),
                              _buildOrgAddressInput(context),
                              SizedBox(height: 16.h),
                              _buildOrgEmailInput(context),
                              SizedBox(height: 16.h),
                              _buildOrgPhoneInput(context),
                              SizedBox(height: 16.h),
                              _buildOrgWebsiteInput(context),
                              SizedBox(height: 16.h),
                              _buildOrgContactInput(context),
                              SizedBox(height: 16.h),
                              _buildOrgPictureUrlInput(context),
                              SizedBox(height: 32.h),
                              _buildSaveButton(context),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        /* bottomNavigationBar: SizedBox(
        width: double.maxFinite,
        child: _buildBottomNavigationBar(context),
      ), */
      ),
    );
  }

  // Widget for displaying a label when isSchoolCheckbox is true
  Widget _buildSchoolLabel(BuildContext context) {
    return Text(
      "Northshore School District",
      style: TextStyle(
        fontSize: 16.h,
        color: Colors.black,
      ),
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
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
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
      padding: EdgeInsets.only(
        left: 8.h,
        right: 4.h,
      ),
      child: BlocSelector<VfCreateorgscreenBloc, VfCreateorgscreenState,
          VfCreateorgscreenModel?>(
        selector: (state) {
          return state.vfCreateorgscreenModelObj;
        },
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

          List<DropdownItem<causes>> preSelectItems =
              selectedMultiSelectValuesforCauses
                      ?.map((cause) => DropdownItem(
                            label: cause.name!,
                            value: cause,
                          ))
                      .toList() ??
                  [];
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
                context.read<VfCreateorgscreenBloc>().add(
                      UpdateMultiSelectValuesEvent(selectedItems),
                    );
              },
            ),
          );
        },
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgMegaphone,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 20.h,
          bottom: 20.h,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "lbl_title".tr,
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgSearch,
          margin: EdgeInsets.only(
            top: 20.h,
            right: 16.h,
            bottom: 20.h,
          ),
        )
      ],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildSchoolOrgHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 4.h,
        right: 8.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 12.h,
      ),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder24,
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "lbl_hi_john_doe".tr,
            style: theme.textTheme.titleMedium,
          ),
          Text(
            "msg_bothell_high_school".tr,
            style: theme.textTheme.titleMedium,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildIsSchoolCheckbox(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: BlocSelector<VfCreateorgscreenBloc, VfCreateorgscreenState, bool?>(
        selector: (state) => state.isSchoolCheckbox,
        builder: (context, isSchoolCheckbox) {
          return CustomCheckboxButton(
            alignment: Alignment.centerRight,
            text: "lbl_is_school".tr,
            value: isSchoolCheckbox,
            textStyle: CustomTextStyles.bodyMediumBlack900,
            onChange: (value) {
              context.read<VfCreateorgscreenBloc>().add(
                    ChangeIsSchoolCheckBoxEvent(
                      value: value,
                      parentOrgName:
                          value ? "Northshore School District" : null,
                    ),
                  );
            },
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildMultiSelectListItem(BuildContext context) {
    return SizedBox(
      height: 64.h,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(
              horizontal: 8.h,
              vertical: 12.h,
            ),
            decoration: AppDecoration.outlinePrimary.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.h,
                    vertical: 4.h,
                  ),
                  decoration: AppDecoration.fillGray20001.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "lbl_in_person".tr,
                        style: theme.textTheme.bodySmall,
                      ),
                      SizedBox(width: 6.h),
                      CustomImageView(
                        imagePath: ImageConstant.imgClosePrimary,
                        height: 20.h,
                        width: 20.h,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 14.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.h,
                    vertical: 4.h,
                  ),
                  decoration: AppDecoration.fillGray20001.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "lbl_virtual".tr,
                        style: theme.textTheme.bodySmall,
                      ),
                      SizedBox(width: 4.h),
                      CustomImageView(
                        imagePath: ImageConstant.imgClosePrimary,
                        height: 20.h,
                        width: 20.h,
                      )
                    ],
                  ),
                ),
                Spacer(),
                CustomImageView(
                  imagePath: ImageConstant.imgIcArrowDropDown48px,
                  height: 20.h,
                  width: 20.h,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(left: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 4.h),
              decoration: AppDecoration.surface,
              child: Text(
                "msg_causes_you_work".tr,
                textAlign: TextAlign.center,
                style: CustomTextStyles.bodySmallRobotoPrimary,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildOrgNameInput(BuildContext context) {
    return BlocSelector<VfCreateorgscreenBloc, VfCreateorgscreenState,
        TextEditingController?>(
      selector: (state) => state.orgNameInputController,
      builder: (context, orgNameInputController) {
        return CustomFloatingTextField(
          controller: orgNameInputController,
          labelText: "msg_organization_name".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_organization_name".tr,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
          onChanged: (value) {
            context
                .read<VfCreateorgscreenBloc>()
                .add(UpdateOrgFieldEvent(field: 'orgname', value: value));
          },
          validator: (value) {
            if (!isText(value)) {
              return "err_msg_please_enter_valid_text";
            }
            return null;
          },
        );
      },
    );
  }

  /// Section Widget
  Widget _buildOrgAddressInput(BuildContext context) {
    return BlocSelector<VfCreateorgscreenBloc, VfCreateorgscreenState,
        TextEditingController?>(
      selector: (state) {
        final controller = state.orgAddressInputController;
        return controller;
      },
      builder: (context, orgAddressInputController) {
        return CustomFloatingTextField(
          controller: orgAddressInputController,
          labelText: "msg_organization_address".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_organization_address".tr,
          filled: false,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildOrgEmailInput(BuildContext context) {
    return BlocSelector<VfCreateorgscreenBloc, VfCreateorgscreenState,
        TextEditingController?>(
      selector: (state) => state.orgEmailInputController,
      builder: (context, orgEmailInputController) {
        return CustomFloatingTextField(
          controller: orgEmailInputController,
          labelText: "msg_organization_email".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_organization_email".tr,
          textInputType: TextInputType.emailAddress,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
          filled: false,
          validator: (value) {
            if (value == null || (!isValidEmail(value, isRequired: true))) {
              return "err_msg_please_enter_valid_email";
            }
            return null;
          },
        );
      },
    );
  }

  /// Section Widget
  Widget _buildOrgPhoneInput(BuildContext context) {
    return BlocSelector<VfCreateorgscreenBloc, VfCreateorgscreenState,
        TextEditingController?>(
      selector: (state) => state.orgPhoneInputController,
      builder: (context, orgPhoneInputController) {
        return CustomFloatingTextField(
          controller: orgPhoneInputController,
          labelText: "msg_organization_phone".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_organization_phone".tr,
          textInputType: TextInputType.phone,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
          filled: false,
          validator: (value) {
            if (!isValidPhone(value)) {
              return "err_msg_please_enter_valid_phone_number";
            }
            return null;
          },
        );
      },
    );
  }

  /// Section Widget
  Widget _buildOrgContactInput(BuildContext context) {
    return BlocSelector<VfCreateorgscreenBloc, VfCreateorgscreenState,
        TextEditingController?>(
      selector: (state) => state.orgPOCNameInputController,
      builder: (context, orgPOCNameInputController) {
        return CustomFloatingTextField(
          controller: orgPOCNameInputController,
          labelText: "msg_organization_poc".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_organization_poc".tr,
          textInputAction: TextInputAction.done,
          filled: false,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildOrgPictureUrlInput(BuildContext context) {
    return BlocSelector<VfCreateorgscreenBloc, VfCreateorgscreenState,
        TextEditingController?>(
      selector: (state) => state.orgPicUrlInputController,
      builder: (context, orgPicUrlInputController) {
        return CustomFloatingTextField(
          controller: orgPicUrlInputController,
          labelText: "msg_organization_picurl".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_organization_picurl".tr,
          textInputAction: TextInputAction.done,
          filled: false,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildOrgWebsiteInput(BuildContext context) {
    return BlocSelector<VfCreateorgscreenBloc, VfCreateorgscreenState,
        TextEditingController?>(
      selector: (state) => state.orgWebsiteInputController,
      builder: (context, orgWebsiteInputController) {
        return CustomFloatingTextField(
          controller: orgWebsiteInputController,
          labelText: "msg_organization_website".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_organization_website".tr,
          textInputAction: TextInputAction.done,
          filled: false,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
        );
      },
    );
  }

  //

  Widget _buildSaveButton(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_save".tr,
      onPressed: () {
        if (_formKey.currentState?.validate() ?? false) {
          context.read<VfCreateorgscreenBloc>().add(SaveOrganizationEvent());

          final sourceScreen = context.select<AppNavigationBloc, String?>(
            (bloc) => bloc.state.sourceScreen,
          );
          print("soruce screen");
          print(sourceScreen);
          // check user status and set global Login Object
          final OrgProfileBloc = context.read<VfCreateorgscreenBloc>();
          final OrgProfileState = OrgProfileBloc.state;
          final userHomeOrg = UserHomeOrg(
              userid: OrgProfileState.userId!, orgid: OrgProfileState.OrgId);

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
}
