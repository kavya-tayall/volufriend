import 'package:flutter/material.dart';
import 'package:volufriend/presentation/vf_eventlist_screen/vf_eventsearchscreen.dart';
import 'package:volufriend/presentation/vf_settings_screen/vf_settingsscreen.dart';
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
import '../presentation/vf_volunteerwelcome/vf_volunteerWelcomescreen_screen.dart';
import '../presentation/vf_eventlist_screen/vf_eventlistscreen.dart';
import '../presentation/vf_volunteerhomepage_screen/vf_volunteerhomepage_screen.dart';
import '../presentation/vf_eventsignupscreen_screen/vf_eventsignupscreen_screen.dart';
import '../presentation/vf_myupcomingevents_screen/vf_myupcomingeventscreen_screen.dart';
import '../presentation/vf_viewvolunteeringprofilescreen_screen/vf_viewvolunteeringprofilepage_screen.dart';
import '../presentation/vf_userattendancereport_screen/vf_userattendancereportpage_screen.dart';
import '../presentation/vf_volunteeringcalendarpage_screen/vf_volunteeringcalendarpage_screen.dart';
import '../presentation/vf_notificationspage_screen/vf_notificationspage_screen.dart';
import '../presentation/vf_eventdetailspage_screen/vf_eventdetailspage_screen.dart';
import '../presentation/vf_eventlist_screen/vf_eventlistscreenforapprove.dart';
import 'package:volufriend/presentation/vf_eventlist_screen/vf_eventListforDetails.dart';

class AppRoutes {
  static const String vfEventListForDetails = '/vf_eventlistfordetails';
  static const String vfEventListForApprove = '/vf_eventlistforapprove';

  static const String vfSettingsScreen = '/vf_settingsscreen';

  static const String vfEventsearchScreen = '/vf_eventsearchscreen';

  static const String vfEventdetailspageScreen = '/vf_eventdetailspage_screen';

  static const String vfNotificationspageScreen =
      '/vf_notificationspage_screen';
  static const String vfVolunteeringcalendarpageScreen =
      '/vf_volunteeringcalendarpage_screen';
  static const String vfuserattendancereportpageScreen =
      '/vf_userattendancereportpage_screen';

  static const String vfViewvolunteeringprofilescreenScreen =
      '/vf_viewvolunteeringprofilescreen_screen';

  static const String vfMyupcomingeventscreenScreen =
      '/vf_myupcomingeventscrn_screen';

  static const String vfEventsignupscreenScreen =
      '/vf_eventsignupscreen_screen';

  static const String vfVolunteerhomepageScreen =
      '/vf_volunteerhomepage_screen';
  static const String vfEventListScreen = '/vf_eventlistscreen';

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

  static const String vfVolunteerWelcomeScreen =
      '/vf_volunteerWelcomescreen_screen';

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
        vfEventListForDetails: VfEventListDetailsScreen.builder,
        vfApprovehoursscreenScreen: VfApprovehoursscreenScreen.builder,
        vfSettingsScreen: VfSettingsScreen.builder,
        vfEventsearchScreen: VfEventSearchScreen.builder,
        vfEventdetailspageScreen: VfEventdetailspageScreen.builder,
        vfNotificationspageScreen: VfNotificatioPageScreen.builder,
        vfVolunteeringcalendarpageScreen:
            VfVolunteeringcalendarpageScreen.builder,
        vfuserattendancereportpageScreen:
            VfUserAttendanceReportPageScreen.builder,
        vfViewvolunteeringprofilescreenScreen: VfVolunteerProfileScreen.builder,
        vfMyupcomingeventscreenScreen: VfMyupcomingeventscreenScreen.builder,
        vfEventsignupscreenScreen: VfEventsignupscreenScreen.builder,
        vfVolunteerhomepageScreen: VfVolunteerHomepageScreen.builder,
        vfEventListScreen: VfEventListScreen.builder,
        vfSplashScreen: VfSplashScreen.builder,
        vfOnboarding1Screen: VfOnboarding1Screen.builder,
        vfOnboarding2Screen: VfOnboarding2Screen.builder,
        vfOnboarding3Screen: VfOnboarding3Screen.builder,
        vfCreateaccountscreenScreen: VfCreateaccountscreenScreen.builder,
        vfVerificationscreenScreen: VfVerificationscreenScreen.builder,
        vfLoginaccountscreenScreen: VfLoginaccountscreenScreen.builder,
        vfJoinasscreenScreen: VfJoinasscreenScreen.builder,
        vfWelcomescreenScreen: VfWelcomescreenScreen.builder,
        vfVolunteerWelcomeScreen: VfVolunteerWelcomeScreen.builder,
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

  // Method to get the screen name from the route
  static String? getScreenNameForRoute(String route) {
    return routes.entries
        .firstWhere((entry) => entry.key == route,
            orElse: () => MapEntry('', (context) => Container()))
        ?.key;
  }
}
