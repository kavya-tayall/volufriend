import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/vf_welcomescreen_bloc.dart';
import 'models/vf_welcomescreen_model.dart';
import '../../presentation/app_navigation_screen/bloc/app_navigation_bloc.dart';

class VfWelcomescreenScreen extends StatelessWidget {
  const VfWelcomescreenScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<VfWelcomescreenBloc>(
      create: (context) => VfWelcomescreenBloc(VfWelcomescreenState(
        vfWelcomescreenModelObj: VfWelcomescreenModel(),
      ))
        ..add(VfWelcomescreenInitialEvent()),
      child: VfWelcomescreenScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VfWelcomescreenBloc, VfWelcomescreenState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(height: 80.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.all(24.h),
                        decoration: AppDecoration.fillPrimary.copyWith(
                          borderRadius: BorderRadiusStyle.customBorderTL28,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "lbl_welcome".tr,
                                style: CustomTextStyles.headlineLargeWhiteA700,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.h),
                                child: Text(
                                  "lbl_john_doe".tr,
                                  style:
                                      CustomTextStyles.headlineLargeWhiteA700,
                                ),
                              ),
                            ),
                            SizedBox(height: 96.h),
                            _buildSetupNewOrganization(context),
                            SizedBox(height: 74.h),
                            _buildBrowseOtherOrganizations(context),
                            SizedBox(height: 22.h),
                            _buildWatchDemo(context),
                            SizedBox(height: 22.h),
                            _buildContactSupport(context),
                            SizedBox(height: 22.h),
                            _buildAboutUs(context),
                            SizedBox(height: 228.h)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildSetupNewOrganization(BuildContext context) {
    return CustomElevatedButton(
      text: "msg_setup_new_organization".tr,
      margin: EdgeInsets.only(
        left: 26.h,
        right: 36.h,
      ),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 10.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgClose,
          height: 18.h,
          width: 18.h,
        ),
      ),
      buttonStyle: CustomButtonStyles.fillWhiteA,
      buttonTextStyle: CustomTextStyles.titleSmallTeal900,
      onPressed: () {
        // Handle button press
        // Trigger the BLoC event
        context.read<AppNavigationBloc>().add(
              AppNavigationInitialEvent(
                  sourceScreen: AppRoutes.vfWelcomescreenScreen),
            );
        NavigatorService.pushNamed(
          AppRoutes.vfCreateorgscreenScreen,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildBrowseOtherOrganizations(BuildContext context) {
    return CustomElevatedButton(
      text: "msg_browser_other_organizations".tr,
      margin: EdgeInsets.only(
        left: 26.h,
        right: 36.h,
      ),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgFavorite,
          height: 18.h,
          width: 18.h,
        ),
      ),
      buttonStyle: CustomButtonStyles.fillWhiteA,
      buttonTextStyle: CustomTextStyles.titleSmallTeal900,
    );
  }

  /// Section Widget
  Widget _buildWatchDemo(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_watch_demo".tr,
      margin: EdgeInsets.only(
        left: 26.h,
        right: 36.h,
      ),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgSave,
          height: 18.h,
          width: 18.h,
        ),
      ),
      buttonStyle: CustomButtonStyles.fillWhiteA,
      buttonTextStyle: CustomTextStyles.titleSmallTeal900,
    );
  }

  /// Section Widget
  Widget _buildContactSupport(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_contact_support".tr,
      margin: EdgeInsets.only(
        left: 26.h,
        right: 36.h,
      ),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgSave,
          height: 18.h,
          width: 18.h,
        ),
      ),
      buttonStyle: CustomButtonStyles.fillWhiteA,
      buttonTextStyle: CustomTextStyles.titleSmallTeal900,
    );
  }

  /// Section Widget
  Widget _buildAboutUs(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_about_us".tr,
      margin: EdgeInsets.only(
        left: 26.h,
        right: 36.h,
      ),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgIconTeal900,
          height: 18.h,
          width: 18.h,
        ),
      ),
      buttonStyle: CustomButtonStyles.fillWhiteA,
      buttonTextStyle: CustomTextStyles.titleSmallTeal900,
    );
  }
}
