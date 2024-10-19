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
                        height: 8.h,
                        child: AnimatedSmoothIndicator(
                          activeIndex: 0,
                          count: 3,
                          effect: ScrollingDotsEffect(
                            spacing: 8,
                            activeDotColor: theme.colorScheme.primary,
                            dotColor: theme.colorScheme.primary,
                            dotHeight: 8.h,
                            dotWidth: 8.h,
                          ),
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