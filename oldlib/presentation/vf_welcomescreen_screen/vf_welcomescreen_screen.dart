import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/vf_welcomescreen_bloc.dart';
import 'models/vf_welcomescreen_model.dart';

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
                        decoration: AppDecoration.fillBlueGray.copyWith(
                          borderRadius: BorderRadiusStyle.customBorderTL28,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "lbl_welcome".tr,
                              style: theme.textTheme.headlineLarge,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.h),
                              child: Text(
                                "lbl_john_doe".tr,
                                style: theme.textTheme.headlineLarge,
                              ),
                            ),
                            SizedBox(height: 96.h),
                            SizedBox(
                              width: double.maxFinite,
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    left: 26.h,
                                    right: 30.h,
                                  ),
                                  child: Column(
                                    children: [
                                      _buildSetupNewOrganizationButton(context),
                                      SizedBox(height: 74.h),
                                      _buildBrowseOtherOrganizationsButton(
                                          context),
                                      SizedBox(height: 22.h),
                                      _buildWatchDemoButton(context),
                                      SizedBox(height: 22.h),
                                      _buildContactSupportButton(context),
                                      SizedBox(height: 22.h),
                                      _buildAboutUsButton(context)
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
  Widget _buildSetupNewOrganizationButton(BuildContext context) {
    return CustomElevatedButton(
      text: "msg_setup_new_organization".tr,
      margin: EdgeInsets.only(right: 6.h),
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
    );
  }

  /// Section Widget
  Widget _buildBrowseOtherOrganizationsButton(BuildContext context) {
    return CustomElevatedButton(
      text: "msg_browser_other_organizations".tr,
      margin: EdgeInsets.only(right: 6.h),
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
  Widget _buildWatchDemoButton(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_watch_demo".tr,
      margin: EdgeInsets.only(right: 6.h),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgSave,
          height: 18.h,
          width: 18.h,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildContactSupportButton(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_contact_support".tr,
      margin: EdgeInsets.only(right: 6.h),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgSave,
          height: 18.h,
          width: 18.h,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAboutUsButton(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_about_us".tr,
      margin: EdgeInsets.only(right: 6.h),
      leftIcon: Container(
        margin: EdgeInsets.only(right: 8.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgIcon,
          height: 18.h,
          width: 18.h,
        ),
      ),
    );
  }
}
