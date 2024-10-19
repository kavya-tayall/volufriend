import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'bloc/vf_onboarding_1_bloc.dart';
import 'models/vf_onboarding_1_model.dart';

class VfOnboarding1Screen extends StatelessWidget {
  const VfOnboarding1Screen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<VfOnboarding1Bloc>(
      create: (context) => VfOnboarding1Bloc(VfOnboarding1State(
        vfOnboarding1ModelObj: VfOnboarding1Model(),
      ))
        ..add(VfOnboarding1InitialEvent()),
      child: VfOnboarding1Screen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VfOnboarding1Bloc, VfOnboarding1State>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: _buildAppBar(context),
            body: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 8.h),
                child: Padding(
                  padding: EdgeInsets.only(left: 6.h),
                  child: Column(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgOnboardingscreenframe,
                        height: 370.h,
                        width: double.maxFinite,
                      ),
                      SizedBox(height: 54.h),
                      Text(
                        "msg_explore_engage".tr,
                        style: theme.textTheme.headlineLarge,
                      ),
                      SizedBox(height: 28.h),
                      SizedBox(
                        width: double.maxFinite,
                        child: Text(
                          "msg_connecting_volunteers".tr,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.titleLarge!.copyWith(
                            height: 1.27,
                          ),
                        ),
                      ),
                      SizedBox(height: 36.h),
                      SizedBox(
                        height: 12
                            .h, // Increase height to allow larger clickable area
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // First dot (current step)
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 4),
                              height:
                                  12.h, // Bigger to indicate the current step
                              width: 12.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            SizedBox(width: 8.h),

                            // Second dot (clickable, with color and animation effect)
                            GestureDetector(
                              onTap: () {
                                // Navigate to the second onboarding screen
                                NavigatorService.pushNamed(
                                    AppRoutes.vfOnboarding2Screen);
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: 10.h, // Slightly larger clickable area
                                width: 10.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme
                                      .colorScheme.secondary, // Brighter color
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
                                    "•", // Optional text to make it stand out more
                                    style: TextStyle(
                                      color: theme.colorScheme.onSecondary,
                                      fontSize:
                                          18, // Adjust size to match design
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.h),

                            // Third dot (regular size)
                            Container(
                              height: 8.h,
                              width: 8.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    theme.colorScheme.primary.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
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

  /// Navigates to the vfSplashScreen when the action is triggered.
  onTapVectorone(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.vfSplashScreen,
    );
  }
}
