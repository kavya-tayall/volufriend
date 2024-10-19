import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'bloc/vf_onboarding_2_bloc.dart';
import 'models/vf_onboarding_2_model.dart';

class VfOnboarding2Screen extends StatelessWidget {
  const VfOnboarding2Screen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<VfOnboarding2Bloc>(
      create: (context) => VfOnboarding2Bloc(VfOnboarding2State(
        vfOnboarding2ModelObj: VfOnboarding2Model(),
      ))
        ..add(VfOnboarding2InitialEvent()),
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
            body: SizedBox(
              width: double.maxFinite,
              child: SingleChildScrollView(
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

  /// Navigates to the vfOnboarding1Screen when the action is triggered.
  onTapVectorone(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.vfOnboarding1Screen,
    );
  }
}
