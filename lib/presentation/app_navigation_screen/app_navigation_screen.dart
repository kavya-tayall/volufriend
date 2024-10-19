import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'bloc/app_navigation_bloc.dart';
import 'models/app_navigation_model.dart';

class AppNavigationScreen extends StatelessWidget {
  const AppNavigationScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<AppNavigationBloc>(
      create: (context) => AppNavigationBloc(AppNavigationState(
        appNavigationModelObj: AppNavigationModel(),
      ))
        ..add(AppNavigationInitialEvent()),
      child: AppNavigationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppNavigationBloc, AppNavigationState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: Color(0XFFFFFFFF),
            body: SizedBox(
              width: 375.h,
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0XFFFFFFFF),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.h),
                          child: Text(
                            "App Navigation",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0XFF000000),
                              fontSize: 20.fSize,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.only(left: 20.h),
                          child: Text(
                            "Check your app's UI from the below demo screens of your app.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0XFF888888),
                              fontSize: 16.fSize,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Divider(
                          height: 1.h,
                          thickness: 1.h,
                          color: Color(0XFF000000),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0XFFFFFFFF),
                        ),
                        child: Column(
                          children: [
                            _buildScreenTitle(
                              context,
                              screenTitle: "vf_Splash_Screen",
                              onTapScreenTitle: () =>
                                  onTapScreenTitle(AppRoutes.vfSplashScreen),
                            ),
                            _buildScreenTitle(
                              context,
                              screenTitle: "vf_onboarding_1_screen",
                              onTapScreenTitle: () => onTapScreenTitle(
                                  AppRoutes.vfOnboarding1Screen),
                            ),
                            _buildScreenTitle(
                              context,
                              screenTitle: "vf_onboarding_2_screen",
                              onTapScreenTitle: () => onTapScreenTitle(
                                  AppRoutes.vfOnboarding2Screen),
                            ),
                            _buildScreenTitle(
                              context,
                              screenTitle: "vf_onboarding_3_screen",
                              onTapScreenTitle: () => onTapScreenTitle(
                                  AppRoutes.vfOnboarding3Screen),
                            ),
                            _buildScreenTitle(
                              context,
                              screenTitle: "vf_CreateAccountScreen",
                              onTapScreenTitle: () => onTapScreenTitle(
                                  AppRoutes.vfCreateaccountscreenScreen),
                            ),
                            _buildScreenTitle(
                              context,
                              screenTitle: "vf_VerificationScreen",
                              onTapScreenTitle: () => onTapScreenTitle(
                                  AppRoutes.vfVerificationscreenScreen),
                            ),
                            _buildScreenTitle(
                              context,
                              screenTitle: "vf_LoginAccountScreen",
                              onTapScreenTitle: () => onTapScreenTitle(
                                  AppRoutes.vfLoginaccountscreenScreen),
                            ),
                            _buildScreenTitle(
                              context,
                              screenTitle: "vf_JoinAsScreen",
                              onTapScreenTitle: () => onTapScreenTitle(
                                  AppRoutes.vfJoinasscreenScreen),
                            ),
                            _buildScreenTitle(
                              context,
                              screenTitle: "vf_WelcomeScreen",
                              onTapScreenTitle: () => onTapScreenTitle(
                                  AppRoutes.vfWelcomescreenScreen),
                            ),
                            _buildScreenTitle(
                              context,
                              screenTitle: "vf_EditUserProfile",
                              onTapScreenTitle: () => onTapScreenTitle(
                                  AppRoutes.vfEdituserprofileScreen),
                            ),
                            _buildScreenTitle(
                              context,
                              screenTitle: "OpenHamburgerMenuScreenNew",
                              onTapScreenTitle: () => onTapScreenTitle(
                                  AppRoutes.openhamburgermenuscreennewScreen),
                            ),
                            _buildScreenTitle(
                              context,
                              screenTitle: "vf_HomeScreen - Container",
                              onTapScreenTitle: () => onTapScreenTitle(
                                  AppRoutes.vfHomescreenContainerScreen),
                            ),
                            _buildScreenTitle(
                              context,
                              screenTitle: "vf_CreateEventScreen1-EventDetails",
                              onTapScreenTitle: () => onTapScreenTitle(AppRoutes
                                  .vfCreateeventscreen1EventdetailsScreen),
                            ),
                            _buildScreenTitle(
                              context,
                              screenTitle: "vf_CreateEventScreen2-EventShifts",
                              onTapScreenTitle: () => onTapScreenTitle(AppRoutes
                                  .vfCreateeventscreen2EventshiftsScreen),
                            ),
                            _buildScreenTitle(
                              context,
                              screenTitle:
                                  "vf_CreateEventScreen3-EventAdditionalDetails",
                              onTapScreenTitle: () => onTapScreenTitle(AppRoutes
                                  .vfCreateeventscreen3EventadditionaldetailsScreen),
                            ),
                            _buildScreenTitle(
                              context,
                              screenTitle: "vf_CreateOrgScreen",
                              onTapScreenTitle: () => onTapScreenTitle(
                                  AppRoutes.vfCreateorgscreenScreen),
                            ),
                            _buildScreenTitle(
                              context,
                              screenTitle: "vf_ApproveHoursScreen",
                              onTapScreenTitle: () => onTapScreenTitle(
                                  AppRoutes.vfApprovehoursscreenScreen),
                            ),
                            _buildScreenTitle(
                              context,
                              screenTitle: "vf_OrgScheduleScreen",
                              onTapScreenTitle: () => onTapScreenTitle(
                                  AppRoutes.vfOrgschedulescreenScreen),
                            )
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

  /// Common widget
  Widget _buildScreenTitle(
    BuildContext context, {
    required String screenTitle,
    Function? onTapScreenTitle,
  }) {
    return GestureDetector(
      onTap: () {
        onTapScreenTitle?.call();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFFFFFFF),
        ),
        child: Column(
          children: [
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Text(
                screenTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0XFF000000),
                  fontSize: 20.fSize,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(height: 5.h),
            Divider(
              height: 1.h,
              thickness: 1.h,
              color: Color(0XFF888888),
            )
          ],
        ),
      ),
    );
  }

  /// Common click event
  void onTapScreenTitle(String routeName) {
    NavigatorService.pushNamed(routeName);
  }
}
