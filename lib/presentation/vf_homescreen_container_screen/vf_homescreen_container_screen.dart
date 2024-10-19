import 'package:flutter/material.dart';
import 'package:volufriend/presentation/vf_notificationspage_screen/vf_notificationspage_screen.dart';
import 'package:volufriend/presentation/vf_volunteeringcalendarpage_screen/vf_volunteeringcalendarpage_screen.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../vf_homescreen_page/vf_homescreen_page.dart';
import 'bloc/vf_homescreen_container_bloc.dart';
import 'models/vf_homescreen_container_model.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../auth/bloc/login_user_bloc.dart';
import '../openhamburgermenuscreennew_screen/openhamburgermenuscreennew_screen.dart';
import '../vf_orgschedulescreen_screen/vf_orgschedulescreen_screen.dart'; // Add this import
import '../../presentation/app_navigation_screen/bloc/app_navigation_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

// ignore_for_file: must_be_immutable
class VfHomescreenContainerScreen extends StatelessWidget {
  VfHomescreenContainerScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    // Simply provide the existing bloc without re-dispatching the initialization event
    return BlocProvider<VfHomescreenContainerBloc>.value(
      value: BlocProvider.of<VfHomescreenContainerBloc>(context),
      child: VfHomescreenContainerScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get the current route to check if headers should be hidden

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        // Handle user state and navigation separately
        _handleUserState(context, state);
      },
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                // Wrap the navigator in a BlocBuilder to refresh UI based on state changes
                child: BlocBuilder<AppNavigationBloc, AppNavigationState>(
                  builder: (context, navState) {
                    // Rebuild the UI when navigation state changes
                    List<Widget> children = [];
                    String currentRoute = navState.destinationScreen ?? "";
                    print("Current Route: $currentRoute");
                    if (!_shouldHideHeaders(currentRoute)) {
                      children.add(_buildAppBar(context));
                      children.add(_buildSchoolOrgHeader(context));
                    }
                    children.add(Expanded(
                        child:
                            _buildNavigator())); // Ensure _buildNavigator reflects the latest navigation state
                    return Column(children: children);
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: _buildBottomNavigationBar(context),
          drawer: _buildDrawer(context),
        ),
      ),
    );
  }

  /// Method to determine whether to hide headers based on the route
  bool _shouldHideHeaders(String currentRoute) {
    List<String> routesToHideHeaders = [
      AppRoutes.vfLoginaccountscreenScreen,
      AppRoutes.vfJoinasscreenScreen,
      AppRoutes.vfOrgschedulescreenScreen
      // Add other routes where headers should be hidden
    ];

    // If the current route is in the list, hide headers
    return routesToHideHeaders.contains(currentRoute);
  }

  /// Handles navigation based on the user state.
  void _handleUserState(BuildContext context, UserState state) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state is LoginUserWithHomeOrg) {
        Navigator.pushNamed(context, AppRoutes.vfHomescreenPage);
      } else if (state is LoginRequired) {
        Navigator.pushNamed(context, AppRoutes.vfLoginaccountscreenScreen);
      } else if (state is NoHomeOrg) {
        Navigator.pushNamed(context, AppRoutes.vfJoinasscreenScreen);
      }
    });
  }

  /// Builds the navigator for the main content area.
  Widget _buildNavigator() {
    return Navigator(
      key: navigatorKey,
      initialRoute: AppRoutes.vfHomescreenPage,
      onGenerateRoute: (routeSetting) => PageRouteBuilder(
        pageBuilder: (ctx, ani, ani1) =>
            getCurrentPage(ctx, routeSetting.name!),
        transitionDuration: Duration.zero, // Set to zero for no transition
      ),
    );
  }

  /// Builds the drawer.
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: OpenhamburgermenuscreennewScreen.builder(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.menu,
                color: Colors.black), // Black color for a sleek look
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Opens the drawer
            },
          );
        },
      ),
      title: Text(
        "Your Title",
        style: TextStyle(
          fontSize: 22, // Slightly larger font size
          fontWeight: FontWeight.w600, // Semi-bold font weight
          color: Colors.black, // Dark text color for contrast
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(Icons.logout,
              color: Colors.black), // Black icon for notifications
          onPressed: () {
            // Define the action for the notifications icon here
            onTapLogout(context);
          },
        ),
      ],
      backgroundColor: Colors.transparent, // Make the background transparent
      elevation: 0, // Remove shadow for a flat look
      toolbarHeight: 70, // Increase height for a more spacious look
    );
  }

  Widget _buildSchoolOrgHeader(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        // Default values for the user and organization name
        String username = ""; // Default username
        String organization = ""; // Default organization name

        // Check if user is logged in and update the username and organization
        if (state is LoginUserWithHomeOrg) {
          username = state.user.username ?? "";
          organization = state.user.orgname ?? "";
        }

        return Container(
          margin: EdgeInsets.symmetric(
              horizontal: 16, vertical: 8), // Margin for spacing
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.blueAccent, // Keep the original background color
            borderRadius:
                BorderRadius.circular(24), // Rounded corners for a modern look
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withOpacity(0.1), // Soft shadow for subtle elevation
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Username
              Flexible(
                child: Text(
                  username.isNotEmpty
                      ? username
                      : "Username", // Fallback if empty
                  style: TextStyle(
                    fontSize: 18, // Slightly smaller for a compact look
                    fontWeight: FontWeight.bold,
                    color: Colors
                        .white, // White text for contrast with the background
                  ),
                  overflow: TextOverflow.ellipsis, // Prevent text overflow
                ),
              ),

              // Organization
              Flexible(
                child: Text(
                  organization.isNotEmpty
                      ? organization
                      : "Organization", // Fallback if empty
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withOpacity(
                        0.9), // Slightly lighter white for subtlety
                  ),
                  textAlign:
                      TextAlign.right, // Align text to the right for balance
                  overflow: TextOverflow.ellipsis, // Prevent text overflow
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Bottom Navigation Bar Widget
  Widget _buildBottomNavigationBar(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          String userRole = getUserRole(context);
          // Dispatch the navigation event
          context.read<AppNavigationBloc>().add(
                AppNavigationPushEvent(
                  destinationScreen: getCurrentRoute(type, userRole),
                ),
              );
          Navigator.pushNamed(
              navigatorKey.currentContext!, getCurrentRoute(type, userRole));
        },
      ),
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type, String userRole) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.vfHomescreenPage;
      case BottomBarEnum.Notifications:
        return AppRoutes.vfNotificationspageScreen;
      case BottomBarEnum.Schedule:
        return userRole == "Volunteer"
            ? AppRoutes.vfVolunteeringcalendarpageScreen
            : AppRoutes.vfVolunteeringcalendarpageScreen;

      case BottomBarEnum.Stats:
        return "/";
      case BottomBarEnum.Profile:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(BuildContext context, String currentRoute) {
    switch (currentRoute) {
      case AppRoutes.vfHomescreenPage:
        return VfHomescreenPage.builder(context);
      case AppRoutes.vfVolunteeringcalendarpageScreen:
        return VfVolunteeringcalendarpageScreen.builder(context);
      case AppRoutes.vfNotificationspageScreen:
        return VfNotificatioPageScreen.builder(context);
      case AppRoutes.vfOrgschedulescreenScreen:
        return VfVolunteeringcalendarpageScreen.builder(context);

      default:
        return DefaultWidget();
    }
  }

  // Helper method to get user role
  static String getUserRole(BuildContext context) {
    // Access the bloc for user role
    final userBloc = BlocProvider.of<UserBloc>(context);
    final userState = userBloc.state;

    if (userState is LoginUserWithHomeOrg) {
      return userState.user.userHomeOrg?.role == "Volunteer"
          ? "Volunteer"
          : "Organization";
    }
    return "";
  }

  static String getUserId(BuildContext context) {
    // Access the bloc for user role

    final userBloc = BlocProvider.of<UserBloc>(context);
    final userState = userBloc.state;
    final userId = userState.userId ?? '';
    return userId;
  }

  static String getOrgUserId(BuildContext context) {
    // Access the bloc for user role

    final userBloc = BlocProvider.of<UserBloc>(context);
    final userState = userBloc.state;
    if (userState is LoginUserWithHomeOrg) {
      print('User is logged in with home org');
      final userHomeOrg = userState.user.userHomeOrg;
      return userHomeOrg?.useridinorg ?? '';
    }
    return '';
  }

  onTapLogout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Assuming Firebase Auth
      BlocProvider.of<UserBloc>(context).add(LogoutEvent());

      NavigatorService.pushNamedAndRemoveUntil(
        AppRoutes.vfLoginaccountscreenScreen,
        // This clears all previous routes
      );
    } catch (e) {
      // Handle error if sign out fails
      print("Logout Failed: $e");
    }
  }
}
