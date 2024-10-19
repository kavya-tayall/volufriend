import 'package:flutter/material.dart';
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

// ignore_for_file: must_be_immutable
class VfEdituserprofileScreen extends StatelessWidget {
  VfEdituserprofileScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<VfEdituserprofileBloc>(
      create: (context) => VfEdituserprofileBloc(VfEdituserprofileState(
        vfEdituserprofileModelObj: VfEdituserprofileModel(),
      ))
        ..add(VfEdituserprofileInitialEvent()),
      child: VfEdituserprofileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Container(
                width: double.maxFinite,
                decoration: AppDecoration.fillBlueGray,
                child: Column(
                  children: [
                    SizedBox(height: 64.h),
                    Container(
                      width: double.maxFinite,
                      decoration: AppDecoration.fillGray,
                      child: Column(
                        children: [
                          _buildUserTabRow(context),
                          SizedBox(
                            width: double.maxFinite,
                            child: Divider(
                              color: appTheme.whiteA700,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          _buildUserCauseMultiselect(context),
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
                              builder: (context, vfEdituserprofileModelObj) {
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
                                  items: vfEdituserprofileModelObj
                                          ?.dropdownItemList ??
                                      [],
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 14.h,
                                    vertical: 18.h,
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
                          _buildFirstNameField(context),
                          SizedBox(height: 26.h),
                          _buildLastNameField(context),
                          SizedBox(height: 34.h),
                          _buildEmailField(context),
                          SizedBox(height: 26.h),
                          _buildPhoneNumberField(context),
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
        ),
      ),
    );
  }

  /// Section Widget
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

  /// Section Widget
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

  /// Section Widget
  Widget _buildUserTabRow(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: double.maxFinite,
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
                  )
                ],
              ),
            ),
          ),
          _buildOrganizationButton(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUserCauseMultiselect(BuildContext context) {
    return Container(
      height: 64.h,
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 8.h,
        right: 4.h,
      ),
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
  Widget _buildFirstNameField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8.h,
        right: 4.h,
      ),
      child: BlocSelector<VfEdituserprofileBloc, VfEdituserprofileState,
          TextEditingController?>(
        selector: (state) => state.firstNameFieldController,
        builder: (context, firstNameFieldController) {
          return CustomFloatingTextField(
            controller: firstNameFieldController,
            labelText: "lbl_first_name".tr,
            labelStyle: CustomTextStyles.bodyLargeGray800,
            hintText: "lbl_first_name".tr,
            contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
            validator: (value) {
              if (!isText(value)) {
                return "err_msg_please_enter_valid_text";
              }
              return null;
            },
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildLastNameField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8.h,
        right: 4.h,
      ),
      child: BlocSelector<VfEdituserprofileBloc, VfEdituserprofileState,
          TextEditingController?>(
        selector: (state) => state.lastNameFieldController,
        builder: (context, lastNameFieldController) {
          return CustomFloatingTextField(
            controller: lastNameFieldController,
            labelText: "lbl_last_name".tr,
            labelStyle: CustomTextStyles.bodyLargeGray800,
            hintText: "lbl_last_name".tr,
            contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
            validator: (value) {
              if (!isText(value)) {
                return "err_msg_please_enter_valid_text";
              }
              return null;
            },
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildEmailField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8.h,
        right: 4.h,
      ),
      child: BlocSelector<VfEdituserprofileBloc, VfEdituserprofileState,
          TextEditingController?>(
        selector: (state) => state.emailFieldController,
        builder: (context, emailFieldController) {
          return CustomTextFormField(
            controller: emailFieldController,
            hintText: "msg_enter_your_email".tr,
            textInputType: TextInputType.emailAddress,
            contentPadding: EdgeInsets.all(16.h),
            borderDecoration: TextFormFieldStyleHelper.outlinePrimary,
            filled: false,
            validator: (value) {
              if (value == null || (!isValidEmail(value, isRequired: true))) {
                return "err_msg_please_enter_valid_email";
              }
              return null;
            },
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildPhoneNumberField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 8.h,
        right: 4.h,
      ),
      child: BlocSelector<VfEdituserprofileBloc, VfEdituserprofileState,
          TextEditingController?>(
        selector: (state) => state.phoneNumberFieldController,
        builder: (context, phoneNumberFieldController) {
          return CustomTextFormField(
            controller: phoneNumberFieldController,
            hintText: "msg_enter_your_phone".tr,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.phone,
            contentPadding: EdgeInsets.all(16.h),
            borderDecoration: TextFormFieldStyleHelper.outlinePrimary,
            filled: false,
            validator: (value) {
              if (!isValidPhone(value)) {
                return "err_msg_please_enter_valid_phone_number";
              }
              return null;
            },
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildSaveButton(BuildContext context) {
    return CustomElevatedButton(
      width: 106.h,
      text: "lbl_save".tr,
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone(BuildContext context) {
    NavigatorService.goBack();
  }
}
