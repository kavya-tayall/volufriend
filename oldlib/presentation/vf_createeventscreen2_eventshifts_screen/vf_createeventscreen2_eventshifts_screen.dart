import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_text_field.dart';
import '../../widgets/custom_icon_button.dart';
import '../vf_homescreen_page/vf_homescreen_page.dart';
import 'bloc/vf_createeventscreen2_eventshifts_bloc.dart';
import 'models/vf_createeventscreen2_eventshifts_model.dart';

// ignore_for_file: must_be_immutable
class VfCreateeventscreen2EventshiftsScreen extends StatelessWidget {
  VfCreateeventscreen2EventshiftsScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    return BlocProvider<VfCreateeventscreen2EventshiftsBloc>(
      create: (context) => VfCreateeventscreen2EventshiftsBloc(
          VfCreateeventscreen2EventshiftsState(
        vfCreateeventscreen2EventshiftsModelObj:
            VfCreateeventscreen2EventshiftsModel(),
      ))
        ..add(VfCreateeventscreen2EventshiftsInitialEvent()),
      child: VfCreateeventscreen2EventshiftsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: _buildAppBar(context),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h),
                child: Column(
                  children: [
                    // Main content container
                    Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.all(16.h),
                      decoration: AppDecoration.fillGray,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSchoolAndOrgHeader(context),
                          SizedBox(height: 16.h),
                          _buildShiftSection(
                              context, "lbl_shift_1", _buildShiftDetails),
                          SizedBox(height: 24.h),
                          _buildShiftSection(
                              context, "lbl_shift_2", _buildShiftDetails1),
                          SizedBox(height: 40.h),
                          _buildNavigationButtons(context),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
              child: _buildBottomBar(context),
            ),
          ),
        );
      },
    );
  }

  Widget _buildShiftSection(BuildContext context, String shiftLabel,
      Widget Function(BuildContext) shiftDetailsBuilder) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          shiftLabel.tr,
          style: CustomTextStyles.titleSmallBlack900_1,
        ),
        SizedBox(height: 8.h),
        shiftDetailsBuilder(context),
      ],
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
  Widget _buildShiftActivityInput(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shiftActivityInputController,
      builder: (context, shiftActivityInputController) {
        return CustomFloatingTextField(
          controller: shiftActivityInputController,
          labelText: "lbl_shift_activity".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_shift_activity".tr,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildShiftStartTime(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shiftStartTimeController,
      builder: (context, shiftStartTimeController) {
        return CustomFloatingTextField(
          width: 134.h,
          controller: shiftStartTimeController,
          labelText: "lbl_start_time".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_start_time".tr,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildShiftEndTime(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.h),
      child: BlocSelector<VfCreateeventscreen2EventshiftsBloc,
          VfCreateeventscreen2EventshiftsState, TextEditingController?>(
        selector: (state) => state.shiftEndTimeController,
        builder: (context, shiftEndTimeController) {
          return CustomFloatingTextField(
            width: 134.h,
            controller: shiftEndTimeController,
            labelText: "lbl_end_time".tr,
            labelStyle: theme.textTheme.bodyLarge!,
            hintText: "msg_end_time".tr,
            contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildShiftMaxParticipants(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shiftMaxParticipantsController,
      builder: (context, shiftMaxParticipantsController) {
        return CustomFloatingTextField(
          width: 144.h,
          controller: shiftMaxParticipantsController,
          labelText: "lbl_max_participants".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_max_participants".tr,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildShiftDetails(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 2.h,
        vertical: 4.h,
      ),
      decoration: AppDecoration.outlineBlack9001,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShiftActivityInput(context),
          SizedBox(height: 26.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                _buildShiftStartTime(context),
                _buildShiftEndTime(context)
              ],
            ),
          ),
          SizedBox(height: 26.h),
          _buildShiftMaxParticipants(context),
          SizedBox(height: 16.h)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildShiftActivityInput1(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shiftActivityInput1Controller,
      builder: (context, shiftActivityInput1Controller) {
        return CustomFloatingTextField(
          controller: shiftActivityInput1Controller,
          labelText: "lbl_shift_activity".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_shift_activity".tr,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildShiftStartTime1(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shiftStartTime1Controller,
      builder: (context, shiftStartTime1Controller) {
        return CustomFloatingTextField(
          width: 134.h,
          controller: shiftStartTime1Controller,
          labelText: "lbl_start_time".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_start_time".tr,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildShiftEndTime1(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.h),
      child: BlocSelector<VfCreateeventscreen2EventshiftsBloc,
          VfCreateeventscreen2EventshiftsState, TextEditingController?>(
        selector: (state) => state.shiftEndTime1Controller,
        builder: (context, shiftEndTime1Controller) {
          return CustomFloatingTextField(
            width: 134.h,
            controller: shiftEndTime1Controller,
            labelText: "lbl_end_time".tr,
            labelStyle: theme.textTheme.bodyLarge!,
            hintText: "msg_end_time".tr,
            contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildShiftMaxParticipants1(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shiftMaxParticipants1Controller,
      builder: (context, shiftMaxParticipants1Controller) {
        return CustomFloatingTextField(
          controller: shiftMaxParticipants1Controller,
          labelText: "msg_max_participants".tr,
          labelStyle: CustomTextStyles.bodySmallRobotoPrimary,
          hintText: "lbl_max_participants".tr,
          hintStyle: CustomTextStyles.bodySmallRobotoPrimary,
          textInputAction: TextInputAction.done,
          alignment: Alignment.topLeft,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 12.h,
          ),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildShiftDetails1(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(
        horizontal: 2.h,
        vertical: 4.h,
      ),
      decoration: AppDecoration.outlineBlack9001,
      child: Column(
        children: [
          _buildShiftActivityInput1(context),
          SizedBox(height: 26.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                _buildShiftStartTime1(context),
                _buildShiftEndTime1(context)
              ],
            ),
          ),
          SizedBox(height: 26.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              children: [
                SizedBox(
                  height: 64.h,
                  width: 144.h,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      _buildShiftMaxParticipants1(context),
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: Text(
                          "msg_max_participants".tr,
                          style: theme.textTheme.bodyLarge,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 6.h),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 14.h),
                      padding: EdgeInsets.only(left: 6.h),
                      child: Row(
                        children: [
                          CustomIconButton(
                            height: 24.h,
                            width: 24.h,
                            padding: EdgeInsets.all(6.h),
                            decoration: IconButtonStyleHelper.outlinePrimary,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgButton,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.h),
                            child: Text(
                              "lbl_100".tr,
                              style:
                                  CustomTextStyles.titleLargeOpenSansBlack900,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.h),
                            child: CustomIconButton(
                              height: 24.h,
                              width: 24.h,
                              padding: EdgeInsets.all(6.h),
                              decoration: IconButtonStyleHelper.outlinePrimary,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgPlusPrimary,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8.h)
        ],
      ),
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
  Widget _buildNextButton(BuildContext context) {
    return CustomElevatedButton(
      width: 106.h,
      text: "lbl_next".tr,
      alignment: Alignment.bottomCenter,
    );
  }

  /// Section Widget
  Widget _buildNavigationButtons(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildPrevButton(context), _buildNextButton(context)],
      ),
    );
  }

  /// Section Widget
  Widget _buildBottomBar(BuildContext context) {
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
