import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_text_field.dart';
import '../../widgets/custom_phone_number.dart';
import '../../widgets/custom_text_form_field.dart';
import '../vf_homescreen_page/vf_homescreen_page.dart';
import 'bloc/vf_createeventscreen3_eventadditionaldetails_bloc.dart';
import 'models/vf_createeventscreen3_eventadditionaldetails_model.dart';

// ignore_for_file: must_be_immutable
class VfCreateeventscreen3EventadditionaldetailsScreen extends StatelessWidget {
  VfCreateeventscreen3EventadditionaldetailsScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  static Widget builder(BuildContext context) {
    return BlocProvider<VfCreateeventscreen3EventadditionaldetailsBloc>(
      create: (context) => VfCreateeventscreen3EventadditionaldetailsBloc(
          VfCreateeventscreen3EventadditionaldetailsState(
        vfCreateeventscreen3EventadditionaldetailsModelObj:
            VfCreateeventscreen3EventadditionaldetailsModel(),
      ))
        ..add(VfCreateeventscreen3EventadditionaldetailsInitialEvent()),
      child: VfCreateeventscreen3EventadditionaldetailsScreen(),
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
                      decoration: AppDecoration.fillGray,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSchoolAndOrgHeader(context),
                          SizedBox(height: 18.h),
                          _buildAdditionalDetailsSection(context),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 4.h),
                            decoration: AppDecoration.fillCyan,
                            child: Column(
                              children: [
                                Text(
                                  "lbl_event_image".tr,
                                  style:
                                      CustomTextStyles.bodySmallRobotoGray800,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 6.h),
                            child: Text(
                              "msg_upload_event_image".tr,
                              style: CustomTextStyles.bodyLargeGray800,
                            ),
                          ),
                          _buildUploadImageSection(context),
                          SizedBox(height: 18.h),
                          _buildEventDetailsForm(context),
                          SizedBox(height: 40.h)
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
  Widget _buildSchoolAndOrgHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 6.h,
        right: 10.h,
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
  Widget _buildAdditionalDetailsTextArea(BuildContext context) {
    return BlocSelector<
        VfCreateeventscreen3EventadditionaldetailsBloc,
        VfCreateeventscreen3EventadditionaldetailsState,
        TextEditingController?>(
      selector: (state) => state.additionalDetailsTextAreaController,
      builder: (context, additionalDetailsTextAreaController) {
        return CustomTextFormField(
          controller: additionalDetailsTextAreaController,
          hintText: "msg_click_here_to_enter3".tr,
          maxLines: 4,
          contentPadding: EdgeInsets.all(10.h),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildAdditionalDetailsSection(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "msg_additional_details".tr,
            style: CustomTextStyles.bodySmallBlack900,
          ),
          SizedBox(height: 4.h),
          _buildAdditionalDetailsTextArea(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildNofilechosenval(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 44.h),
      child: BlocSelector<
          VfCreateeventscreen3EventadditionaldetailsBloc,
          VfCreateeventscreen3EventadditionaldetailsState,
          TextEditingController?>(
        selector: (state) => state.nofilechosenvalController,
        builder: (context, nofilechosenvalController) {
          return CustomTextFormField(
            width: 168.h,
            controller: nofilechosenvalController,
            hintText: "lbl_choose_file".tr,
            hintStyle: CustomTextStyles.titleMediumPoppinsPrimary,
            alignment: Alignment.centerLeft,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 30.h,
              vertical: 6.h,
            ),
            borderDecoration: TextFormFieldStyleHelper.outlinePrimaryTL5,
            filled: false,
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildUploadImageSection(BuildContext context) {
    return Container(
      height: 78.h,
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 6.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 78.h,
            width: 392.h,
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
              borderRadius: BorderRadius.circular(
                5.h,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 74.h,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: 54.h,
                    width: 82.h,
                    decoration: AppDecoration.fillIndigo.copyWith(
                      borderRadius: BorderRadiusStyle.roundedBorder5,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgUser,
                          height: 18.h,
                          width: 34.h,
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 38.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "msg_please_upload_square".tr,
                            textAlign: TextAlign.center,
                            style: CustomTextStyles.bodyMediumPoppinsBlack900,
                          ),
                          SizedBox(height: 4.h),
                          SizedBox(
                            height: 42.h,
                            width: double.maxFinite,
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Container(
                                  height: 36.h,
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imageNotFound,
                                        height: 36.h,
                                        width: 324.h,
                                        radius: BorderRadius.circular(
                                          5.h,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 14.h),
                                          child: Text(
                                            "lbl_no_file_chosen".tr,
                                            style: CustomTextStyles
                                                .bodyLargePoppinsGray80001,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                _buildNofilechosenval(context)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildCoordinatorNameInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 4.h),
      child: BlocSelector<
          VfCreateeventscreen3EventadditionaldetailsBloc,
          VfCreateeventscreen3EventadditionaldetailsState,
          TextEditingController?>(
        selector: (state) => state.coordinatorNameInputController,
        builder: (context, coordinatorNameInputController) {
          return CustomFloatingTextField(
            controller: coordinatorNameInputController,
            labelText: "msg_coordinator_name".tr,
            labelStyle: theme.textTheme.bodyLarge!,
            hintText: "msg_coordinator_name".tr,
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
  Widget _buildCoordinatorEmailInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 4.h),
      child: BlocSelector<
          VfCreateeventscreen3EventadditionaldetailsBloc,
          VfCreateeventscreen3EventadditionaldetailsState,
          TextEditingController?>(
        selector: (state) => state.coordinatorEmailInputController,
        builder: (context, coordinatorEmailInputController) {
          return CustomFloatingTextField(
            controller: coordinatorEmailInputController,
            labelText: "msg_coordinator_email".tr,
            labelStyle: theme.textTheme.bodyLarge!,
            hintText: "msg_coordinator_email".tr,
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
      ),
    );
  }

  /// Section Widget
  Widget _buildCoordinatorPhoneInput(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 4.h),
      child: BlocSelector<
          VfCreateeventscreen3EventadditionaldetailsBloc,
          VfCreateeventscreen3EventadditionaldetailsState,
          TextEditingController?>(
        selector: (state) => state.coordinatorPhoneInputController,
        builder: (context, coordinatorPhoneInputController) {
          return CustomFloatingTextField(
            controller: coordinatorPhoneInputController,
            labelText: "msg_coordinator_phone".tr,
            labelStyle: theme.textTheme.bodyLarge!,
            hintText: "msg_coordinator_phone".tr,
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
      ),
    );
  }

  /// Section Widget
  Widget _buildPhoneNumber(BuildContext context) {
    return BlocBuilder<VfCreateeventscreen3EventadditionaldetailsBloc,
        VfCreateeventscreen3EventadditionaldetailsState>(
      builder: (context, state) {
        return CustomPhoneNumber(
          country: state.selectedCountry ??
              CountryPickerUtils.getCountryByPhoneCode('1'),
          controller: state.phoneNumberController,
          onTap: (Country value) {
            context
                .read<VfCreateeventscreen3EventadditionaldetailsBloc>()
                .add(ChangeCountryEvent(value: value));
          },
        );
      },
    );
  }

  /// Section Widget
  Widget _buildPrevButton(BuildContext context) {
    return CustomElevatedButton(
      width: 106.h,
      text: "lbl_prev".tr,
      margin: EdgeInsets.only(bottom: 4.h),
    );
  }

  /// Section Widget
  Widget _buildSaveButton(BuildContext context) {
    return CustomElevatedButton(
      width: 106.h,
      text: "lbl_save".tr,
      alignment: Alignment.bottomCenter,
    );
  }

  /// Section Widget
  Widget _buildEventDetailsForm(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 6.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCoordinatorNameInput(context),
          SizedBox(height: 22.h),
          _buildCoordinatorEmailInput(context),
          SizedBox(height: 22.h),
          _buildCoordinatorPhoneInput(context),
          SizedBox(height: 30.h),
          Text(
            "lbl_phone_number".tr,
            style: CustomTextStyles.bodySmallPrimary,
          ),
          SizedBox(height: 6.h),
          _buildPhoneNumber(context),
          SizedBox(height: 68.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_buildPrevButton(context), _buildSaveButton(context)],
            ),
          )
        ],
      ),
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
