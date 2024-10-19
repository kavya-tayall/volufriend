import 'package:flutter/material.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';
import '../presentation/openhamburgermenuscreennew_screen/openhamburgermenuscreennew_screen.dart';
import '../presentation/vf_approvehoursscreen_screen/vf_approvehoursscreen_screen.dart';
import '../presentation/vf_createaccountscreen_screen/vf_createaccountscreen_screen.dart';
import '../presentation/vf_createeventscreen1_eventdetails_screen/vf_createeventscreen1_eventdetails_screen.dart';
import '../presentation/vf_createeventscreen2_eventshifts_screen/vf_createeventscreen2_eventshifts_screen.dart';
import '../presentation/vf_createeventscreen3_eventadditionaldetails_screen/vf_createeventscreen3_eventadditionaldetails_screen.dart';
import '../presentation/vf_createorgscreen_screen/vf_createorgscreen_screen.dart';
import '../presentation/vf_edituserprofile_screen/vf_edituserprofile_screen.dart';
import '../presentation/vf_homescreen_container_screen/vf_homescreen_container_screen.dart';
import '../presentation/vf_joinasscreen_screen/vf_joinasscreen_screen.dart';
import '../presentation/vf_loginaccountscreen_screen/vf_loginaccountscreen_screen.dart';
import '../presentation/vf_onboarding_1_screen/vf_onboarding_1_screen.dart';
import '../presentation/vf_onboarding_2_screen/vf_onboarding_2_screen.dart';
import '../presentation/vf_onboarding_3_screen/vf_onboarding_3_screen.dart';
import '../presentation/vf_orgschedulescreen_screen/vf_orgschedulescreen_screen.dart';
import '../presentation/vf_splash_screen/vf_splash_screen.dart';
import '../presentation/vf_verificationscreen_screen/vf_verificationscreen_screen.dart';
import '../presentation/vf_welcomescreen_screen/vf_welcomescreen_screen.dart';

class AppRoutes {
  static const String vfSplashScreen = '/vf_splash_screen';

  static const String vfOnboarding1Screen = '/vf_onboarding_1_screen';

  static const String vfOnboarding2Screen = '/vf_onboarding_2_screen';

  static const String vfOnboarding3Screen = '/vf_onboarding_3_screen';

  static const String vfCreateaccountscreenScreen =
      '/vf_createaccountscreen_screen';

  static const String vfVerificationscreenScreen =
      '/vf_verificationscreen_screen';

  static const String vfLoginaccountscreenScreen =
      '/vf_loginaccountscreen_screen';

  static const String vfJoinasscreenScreen = '/vf_joinasscreen_screen';

  static const String vfWelcomescreenScreen = '/vf_welcomescreen_screen';

  static const String vfEdituserprofileScreen = '/vf_edituserprofile_screen';

  static const String openhamburgermenuscreennewScreen =
      '/openhamburgermenuscreennew_screen';

  static const String vfHomescreenContainerScreen =
      '/vf_homescreen_container_screen';

  static const String vfHomescreenPage = '/vf_homescreen_page';

  static const String vfCreateeventscreen1EventdetailsScreen =
      '/vf_createeventscreen1_eventdetails_screen';

  static const String vfCreateeventscreen2EventshiftsScreen =
      '/vf_createeventscreen2_eventshifts_screen';

  static const String vfCreateeventscreen3EventadditionaldetailsScreen =
      '/vf_createeventscreen3_eventadditionaldetails_screen';

  static const String vfCreateorgscreenScreen = '/vf_createorgscreen_screen';

  static const String vfApprovehoursscreenScreen =
      '/vf_approvehoursscreen_screen';

  static const String vfOrgschedulescreenScreen =
      '/vf_orgschedulescreen_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> get routes => {
        vfSplashScreen: VfSplashScreen.builder,
        vfOnboarding1Screen: VfOnboarding1Screen.builder,
        vfOnboarding2Screen: VfOnboarding2Screen.builder,
        vfOnboarding3Screen: VfOnboarding3Screen.builder,
        vfCreateaccountscreenScreen: VfCreateaccountscreenScreen.builder,
        vfVerificationscreenScreen: VfVerificationscreenScreen.builder,
        vfLoginaccountscreenScreen: VfLoginaccountscreenScreen.builder,
        vfJoinasscreenScreen: VfJoinasscreenScreen.builder,
        vfWelcomescreenScreen: VfWelcomescreenScreen.builder,
        vfEdituserprofileScreen: VfEdituserprofileScreen.builder,
        openhamburgermenuscreennewScreen:
            OpenhamburgermenuscreennewScreen.builder,
        vfHomescreenContainerScreen: VfHomescreenContainerScreen.builder,
        vfCreateeventscreen1EventdetailsScreen:
            VfCreateeventscreen1EventdetailsScreen.builder,
        vfCreateeventscreen2EventshiftsScreen:
            VfCreateeventscreen2EventshiftsScreen.builder,
        vfCreateeventscreen3EventadditionaldetailsScreen:
            VfCreateeventscreen3EventadditionaldetailsScreen.builder,
        vfCreateorgscreenScreen: VfCreateorgscreenScreen.builder,
        vfApprovehoursscreenScreen: VfApprovehoursscreenScreen.builder,
        vfOrgschedulescreenScreen: VfOrgschedulescreenScreen.builder,
        appNavigationScreen: AppNavigationScreen.builder,
        initialRoute: VfSplashScreen.builder
      };
}
