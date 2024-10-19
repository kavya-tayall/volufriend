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

// ignore_for_file: must_be_immutable
class VfCreateorgscreenScreen extends StatelessWidget {
  VfCreateorgscreenScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<VfCreateorgscreenBloc>(
      create: (context) => VfCreateorgscreenBloc(VfCreateorgscreenState(
        vfCreateorgscreenModelObj: VfCreateorgscreenModel(),
      ))
        ..add(VfCreateorgscreenInitialEvent()),
      child: VfCreateorgscreenScreen(),
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
                padding: EdgeInsets.symmetric(vertical: 64.h),
                decoration: AppDecoration.fillBlueGray,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: 2.h),
                      decoration: AppDecoration.fillGray,
                      child: Column(
                        children: [
                          _buildSchoolOrgHeader(context),
                          SizedBox(height: 48.h),
                          Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.only(right: 8.h),
                            child: Column(
                              children: [
                                _buildIsSchoolCheckbox(context),
                                SizedBox(height: 16.h),
                                _buildMultiSelectListItem(context),
                                SizedBox(height: 14.h),
                                _buildOrgNameInput(context),
                                SizedBox(height: 22.h),
                                _buildOrgAddressInput(context),
                                SizedBox(height: 22.h),
                                _buildOrgEmailInput(context),
                                SizedBox(height: 22.h),
                                _buildOrgPhoneInput(context),
                                SizedBox(height: 22.h),
                                _buildOrgWebsiteInput(context),
                                SizedBox(height: 32.h),
                                BlocSelector<
                                    VfCreateorgscreenBloc,
                                    VfCreateorgscreenState,
                                    VfCreateorgscreenModel?>(
                                  selector: (state) =>
                                      state.vfCreateorgscreenModelObj,
                                  builder:
                                      (context, vfCreateorgscreenModelObj) {
                                    return CustomDropDown(
                                      width: 316.h,
                                      icon: Container(
                                        margin: EdgeInsets.only(left: 16.h),
                                        child: CustomImageView(
                                          imagePath: ImageConstant
                                              .imgCheckmarkBlack900,
                                          height: 20.h,
                                          width: 20.h,
                                        ),
                                      ),
                                      hintText: "msg_cause_you_work_for".tr,
                                      alignment: Alignment.centerLeft,
                                      items: vfCreateorgscreenModelObj
                                              ?.dropdownItemList ??
                                          [],
                                      prefix: Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 4.h,
                                          vertical: 6.h,
                                        ),
                                        child: CustomImageView(
                                          imagePath: ImageConstant
                                              .imgArrowdownBlack900,
                                          height: 20.h,
                                          width: 20.h,
                                        ),
                                      ),
                                      prefixConstraints: BoxConstraints(
                                        maxHeight: 32.h,
                                      ),
                                      contentPadding: EdgeInsets.all(4.h),
                                      borderDecoration:
                                          DropDownStyleHelper.underLineBlueGray,
                                      filled: false,
                                    );
                                  },
                                ),
                                SizedBox(height: 42.h),
                                _buildSaveButton(context)
                              ],
                            ),
                          ),
                          SizedBox(height: 38.h)
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h)
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          width: double.maxFinite,
          child: _buildBottomNavigationBar(context),
        ),
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
      child: Padding(
        padding: EdgeInsets.only(right: 34.h),
        child:
            BlocSelector<VfCreateorgscreenBloc, VfCreateorgscreenState, bool?>(
          selector: (state) => state.isSchoolCheckbox,
          builder: (context, isSchoolCheckbox) {
            return CustomCheckboxButton(
              alignment: Alignment.centerRight,
              text: "lbl_is_school".tr,
              value: isSchoolCheckbox,
              textStyle: CustomTextStyles.bodyMediumBlack900,
              onChange: (value) {
                context
                    .read<VfCreateorgscreenBloc>()
                    .add(ChangeCheckBoxEvent(value: value));
              },
            );
          },
        ),
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
      selector: (state) => state.orgAddressInputController,
      builder: (context, orgAddressInputController) {
        return CustomFloatingTextField(
          controller: orgAddressInputController,
          labelText: "msg_organization_address".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_organization_address".tr,
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
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildSaveButton(BuildContext context) {
    return CustomElevatedButton(
      width: 106.h,
      text: "lbl_save".tr,
    );
  }

  /// Section Widget
  Widget _buildBottomNavigationBar(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          Navigator.pushNamed(
              navigatorKey.currentContext!, getCurrentRoute(type));
        },
      ),
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.vfHomescreenPage;
      case BottomBarEnum.Notifications:
        return "/";
      case BottomBarEnum.Schedule:
        return "/";
      case BottomBarEnum.Stats:
        return "/";
      case BottomBarEnum.Profile:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(
    BuildContext context,
    String currentRoute,
  ) {
    switch (currentRoute) {
      case AppRoutes.vfHomescreenPage:
        return VfHomescreenPage.builder(context);
      default:
        return DefaultWidget();
    }
  }
}
