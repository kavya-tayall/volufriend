import 'package:flutter/material.dart';
import 'package:volufriend/crud_repository/models/LoginUserModel.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/vf_volunteerWelcomescreen_bloc.dart';
import 'models/vf_volunteerWelcomescreen_model.dart';
import '../../auth/bloc/login_user_bloc.dart';
import '../../presentation/app_navigation_screen/bloc/app_navigation_bloc.dart';

class VfVolunteerWelcomeScreen extends StatelessWidget {
  const VfVolunteerWelcomeScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    // Retrieve the NoHomeOrg state
    final noHomeOrgState =
        BlocProvider.of<UserBloc>(context).state as NoHomeOrg;

    // Print the value to the console
    print('noHomeOrgState: $noHomeOrgState');

    return BlocProvider<VfvolunteerWelcomescreenBloc>(
      create: (context) {
        final isNoHomeOrgState = noHomeOrgState != null;
        return VfvolunteerWelcomescreenBloc(
          VfvolunteerWelcomescreenState(
            vfvolunteerWelcomescreenModelObj: VfvolunteerWelcomescreenModel(),
            isNoHomeOrgState: isNoHomeOrgState, // Pass the state
          ),
        )..add(VfVolunteerWelcomeInitialEvent(
            noHomeOrgState.user, noHomeOrgState));
      },
      child: VfVolunteerWelcomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VfvolunteerWelcomescreenBloc,
        VfvolunteerWelcomescreenState>(
      builder: (context, state) {
        // Access the VfvolunteerWelcomescreenModel object
        final model = state.vfvolunteerWelcomescreenModelObj;
        final username = model.loginUser?.username ?? '';
        final isNoHomeOrgState = state.isNoHomeOrgState; // Access the state
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
                                "lbl_welcome_volunteer".tr,
                                style: CustomTextStyles.headlineLargeWhiteA700,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.h),
                                child: Text(
                                  username,
                                  style:
                                      CustomTextStyles.headlineLargeWhiteA700,
                                ),
                              ),
                            ),
                            SizedBox(height: 96.h),
                            _buildCompleteProfile(context),
                            SizedBox(height: 74.h),
                            _buildStartVolunteering(context, isNoHomeOrgState),
                            SizedBox(height: 22.h),
                            _buildWatchVolunteerDemo(context),
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
  Widget _buildCompleteProfile(BuildContext context) {
    return CustomElevatedButton(
      text: "msg_complete_profile".tr,
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
                  sourceScreen: AppRoutes.vfVolunteerWelcomeScreen),
            );
        NavigatorService.pushNamed(
          AppRoutes.vfEdituserprofileScreen,
        );
      },
    );
  }

  /// Section Widget
  Widget _buildStartVolunteering(BuildContext context, bool isNoHomeOrgState) {
    print("isNoHomeOrgState: $isNoHomeOrgState"); // Debug print

    return CustomElevatedButton(
      text: "msg_start_volunteering".tr,
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
      isDisabled: isNoHomeOrgState,
      onPressed: () {
        // Handle button press
        print('Button Pressed');
      },
    );
  }

  /// Section Widget
  Widget _buildWatchVolunteerDemo(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_watch_volunteer_demo".tr,
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
