import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/vf_onboarding_3_bloc.dart';
import 'models/vf_onboarding_3_model.dart';

class VfOnboarding3Screen extends StatelessWidget {
  const VfOnboarding3Screen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    return BlocProvider<VfOnboarding3Bloc>(
      create: (context) => VfOnboarding3Bloc(
        VfOnboarding3State(
          vfOnboarding3ModelObj: VfOnboarding3Model(),
        ),
      )..add(VfOnboarding3InitialEvent()),
      child: VfOnboarding3Screen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VfOnboarding3Bloc, VfOnboarding3State>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: _buildAppBar(context),
            body: GestureDetector(
              // Detect swipe gestures for navigation
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity! > 0) {
                  // Swipe right to go to the previous screen
                  NavigatorService.pushNamed(AppRoutes.vfOnboarding2Screen);
                }
              },
              child: SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 14.h),
                    child: Column(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgOnboardingscreenframe1,
                          height: 400.h,
                          width: double.maxFinite,
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          "msg_track_celebrate".tr,
                          style: theme.textTheme.headlineLarge,
                        ),
                        SizedBox(height: 28.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: Text(
                            "msg_the_app_simplifies".tr,
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
                          height: 8.h,
                          child: AnimatedSmoothIndicator(
                            activeIndex: 2,
                            count: 3,
                            effect: ScrollingDotsEffect(
                              spacing: 8,
                              activeDotColor: theme.colorScheme.primary,
                              dotColor: theme.colorScheme.primary,
                              dotHeight: 8.h,
                              dotWidth: 8.h,
                            ),
                          ),
                        ),
                        SizedBox(height: 52.h),
                        CustomElevatedButton(
                          text: "msg_let_s_get_started".tr,
                          margin: EdgeInsets.only(left: 40.h, right: 56.h),
                          onPressed: () {
                            NavigatorService.pushNamed(
                              AppRoutes.vfCreateaccountscreenScreen,
                            );
                          },
                        )
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

  /// Navigates to the vfOnboarding2Screen when the action is triggered.
  void onTapVectorone(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.vfOnboarding2Screen,
    );
  }
}
