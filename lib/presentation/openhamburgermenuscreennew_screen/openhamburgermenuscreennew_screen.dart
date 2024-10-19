import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Assuming you're using Firebase for authentication
import 'package:volufriend/crud_repository/models/volufrienduser.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/openhamburgermenuscreennew_bloc.dart';
import 'models/openhamburgermenuscreennew_model.dart';
import '../../auth/bloc/login_user_bloc.dart';

class OpenhamburgermenuscreennewScreen extends StatelessWidget {
  const OpenhamburgermenuscreennewScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<OpenhamburgermenuscreennewBloc>(
      create: (context) =>
          OpenhamburgermenuscreennewBloc(OpenhamburgermenuscreennewState(
        openhamburgermenuscreennewModelObj: OpenhamburgermenuscreennewModel(),
      ))
            ..add(OpenhamburgermenuscreennewInitialEvent()),
      child: OpenhamburgermenuscreennewScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenhamburgermenuscreennewBloc,
        OpenhamburgermenuscreennewState>(
      builder: (context, state) {
        String username = getUserName(context);
        String organization = getOrgName(context);

        return SafeArea(
          child: Scaffold(
            backgroundColor: appTheme.whiteA700,
            body: Column(
              children: [
                SizedBox(height: 20.h),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 22.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildUserProfile(context, username, organization),
                        SizedBox(height: 40.h),
                        _buildMenuOption(
                          context,
                          iconPath: ImageConstant.imgHomeBlack900,
                          label: "lbl_home".tr,
                          onTap: () => onTapHomeicon(context),
                        ),
                        /*
                        _buildMenuOption(
                          context,
                          iconPath: ImageConstant.imgBookmarkTeal900,
                          label: "lbl_schedule".tr,
                        ),*/
                        _buildMenuOption(
                          context,
                          iconPath: ImageConstant.imgLockTeal900,
                          label: "lbl_settings".tr,
                          onTap: () => onTapSettingsicon(context),
                        ),
                        _buildMenuOption(
                          context,
                          iconPath: ImageConstant.imgCallTeal900,
                          label: "lbl_support".tr,
                        ),
                        _buildMenuOption(
                          context,
                          iconPath: ImageConstant.imgNotificationIconTeal900,
                          label: "About Us".tr,
                        ),
                        SizedBox(height: 40.h),
                        _buildLogoutButton(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserProfile(
      BuildContext context, String username, String organization) {
    return Container(
      padding: EdgeInsets.all(24.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
        borderRadius: BorderRadius.circular(12.h),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center, // Align avatar with text
        children: [
          CircleAvatar(
            radius: 25.h,
            backgroundColor: appTheme.teal900,
          ),
          SizedBox(width: 14.h),
          Expanded(
            // To prevent overflow by expanding into available space
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: CustomTextStyles.titleMediumMontserratBlack90018,
                  overflow: TextOverflow.ellipsis, // Truncate long usernames
                ),
                SizedBox(height: 6.h),
                Text(
                  organization.tr,
                  style: CustomTextStyles.bodySmallMontserratBlack900,
                  overflow:
                      TextOverflow.ellipsis, // Handle long organization names
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuOption(BuildContext context,
      {required String iconPath, required String label, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: [
            CustomImageView(
              imagePath: iconPath,
              height: 24.h,
              width: 24.h,
            ),
            SizedBox(width: 16.h),
            Text(
              label,
              style: CustomTextStyles.titleMediumMontserratTeal900,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: CustomElevatedButton(
        text: "lbl_log_out".tr,
        buttonStyle: CustomButtonStyles.fillPrimaryTL12,
        buttonTextStyle: CustomTextStyles.titleMediumMontserrat,
        onPressed: () => onTapLogout(context),
      ),
    );
  }

  /// Handles the logout functionality.
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

  /// Navigates to the vfHomescreenContainerScreen when the action is triggered.
  onTapHomeicon(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.vfHomescreenContainerScreen,
    );
  }

  onTapSettingsicon(BuildContext context) {
    // Add functionality here
    NavigatorService.pushNamed(
      AppRoutes.vfSettingsScreen,
    );
  }

  static String getUserName(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final userState = userBloc.state;
    if (userState is LoginUserWithHomeOrg) {
      print("User is logged in with home org");
      return userState.user.username ?? "";
    } else
      return "";
  }

  static String getOrgName(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final userState = userBloc.state;
    if (userState is LoginUserWithHomeOrg) {
      return userState.user.orgname ?? "";
    } else
      return "";
  }
}
