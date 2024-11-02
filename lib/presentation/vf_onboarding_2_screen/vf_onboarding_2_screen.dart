import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // For handling swipe gestures
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'bloc/vf_onboarding_2_bloc.dart';
import 'models/vf_onboarding_2_model.dart';

class VfOnboarding2Screen extends StatelessWidget {
  const VfOnboarding2Screen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<VfOnboarding2Bloc>(
      create: (context) => VfOnboarding2Bloc(
        VfOnboarding2State(
          vfOnboarding2ModelObj: VfOnboarding2Model(),
        ),
      )..add(VfOnboarding2InitialEvent()),
      child: VfOnboarding2Screen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VfOnboarding2Bloc, VfOnboarding2State>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: _buildAppBar(context),
            body: GestureDetector(
              // Add swipe gestures for navigation
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! < 0) {
                  // Swipe left to go to the next screen
                  NavigatorService.pushNamed(AppRoutes.vfOnboarding3Screen);
                } else if (details.primaryVelocity! > 0) {
                  // Swipe right to go back to the previous screen
                  NavigatorService.pushNamed(AppRoutes.vfOnboarding1Screen);
                }
              },
              child: SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 8.h),
                  child: Padding(
                    padding: EdgeInsets.only(left: 14.h),
                    child: Column(
                      children: [
                        CustomImageView(
                          imagePath:
                              ImageConstant.imgOnboardingscreenframe400x396,
                          height: 400.h,
                          width: double.maxFinite,
                        ),
                        SizedBox(height: 30.h),
                        Text(
                          "msg_create_contribute".tr,
                          style: theme.textTheme.headlineLarge,
                        ),
                        SizedBox(height: 30.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            "msg_support_communities".tr,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.titleLarge!.copyWith(
                              height: 1.27,
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        SizedBox(
                          height: 20
                              .h, // Increased height for larger clickable area
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // First dot
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                height: 8.h,
                                width: 8.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme.colorScheme.primary
                                      .withOpacity(0.5),
                                ),
                              ),
                              SizedBox(width: 8.h),

                              // Second dot (prominent size, no click action)
                              Container(
                                height: 12.h, // Larger size to draw attention
                                width: 12.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme.colorScheme.primary,
                                  boxShadow: [
                                    BoxShadow(
                                      color: theme.colorScheme.primary
                                          .withOpacity(0.5),
                                      blurRadius: 8, // Glow effect
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.h),

                              // Third dot (clickable with same color as second dot on first page)
                              GestureDetector(
                                onTap: () {
                                  // Navigate to the third onboarding screen
                                  NavigatorService.pushNamed(
                                      AppRoutes.vfOnboarding3Screen);
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  height: 18.h, // Enlarged clickable area
                                  width: 18.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: theme.colorScheme.secondary,
                                    boxShadow: [
                                      BoxShadow(
                                        color: theme.colorScheme.secondary
                                            .withOpacity(0.5),
                                        blurRadius: 8, // Glow effect
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      "•",
                                      style: TextStyle(
                                        color: theme.colorScheme.onSecondary,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 54.h,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgVector,
        margin: EdgeInsets.only(
          left: 24.h,
          top: 12.h,
          bottom: 13.h,
        ),
        onTap: () {
          onTapVectorone(context);
        },
      ),
    );
  }

  /// Navigates to the vfOnboarding1Screen when the action is triggered.
  onTapVectorone(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.vfOnboarding1Screen);
  }
}
