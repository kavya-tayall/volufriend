import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/openhamburgermenuscreennew_bloc.dart';
import 'models/openhamburgermenuscreennew_model.dart';

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
        return SafeArea(
          child: Scaffold(
            backgroundColor: appTheme.whiteA700,
            body: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 22.h),
                      child: Container(
                        width: double.maxFinite,
                        margin: EdgeInsets.only(left: 10.h),
                        decoration: AppDecoration.fillPrimary,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 292.h,
                              decoration: AppDecoration.surface,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(24.h),
                                    decoration: AppDecoration.outlineBlack900,
                                    width: double.maxFinite,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 98.h,
                                          width: 98.h,
                                          decoration: BoxDecoration(
                                            color: appTheme.teal900,
                                            borderRadius: BorderRadius.circular(
                                              24.h,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 14.h),
                                        Expanded(
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 14.h),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "lbl_john_doe".tr,
                                                    style: CustomTextStyles
                                                        .titleMediumMontserratBlack90018,
                                                  ),
                                                  SizedBox(height: 6.h),
                                                  Text(
                                                    "msg_bothell_high_school"
                                                        .tr,
                                                    style: CustomTextStyles
                                                        .bodySmallMontserratBlack900,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 54.h),
                                  SizedBox(
                                    width: double.maxFinite,
                                    child: GestureDetector(
                                      onTap: () {
                                        onTapHomeicon(context);
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24.h),
                                        child: Row(
                                          children: [
                                            CustomImageView(
                                              imagePath: ImageConstant.imgHome,
                                              height: 22.h,
                                              width: 20.h,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 14.h),
                                              child: Text(
                                                "lbl_home".tr,
                                                style: CustomTextStyles
                                                    .titleMediumMontserratBlack900,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 38.h),
                                  Container(
                                    width: double.maxFinite,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 24.h),
                                    child: Row(
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant.imgBookmark,
                                          height: 20.h,
                                          width: 14.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 18.h),
                                          child: Text(
                                            "lbl_schedule".tr,
                                            style: CustomTextStyles
                                                .titleMediumMontserratTeal900,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 42.h),
                                  Container(
                                    width: double.maxFinite,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 24.h),
                                    child: Row(
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant.imgLock,
                                          height: 20.h,
                                          width: 20.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 14.h),
                                          child: Text(
                                            "lbl_settings".tr,
                                            style: CustomTextStyles
                                                .titleMediumMontserratTeal900,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 42.h),
                                  Container(
                                    width: double.maxFinite,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 24.h),
                                    child: Row(
                                      children: [
                                        CustomImageView(
                                          imagePath: ImageConstant.imgCall,
                                          height: 20.h,
                                          width: 18.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 14.h),
                                          child: Text(
                                            "lbl_support".tr,
                                            style: CustomTextStyles
                                                .titleMediumMontserratTeal900,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 40.h),
                                  Container(
                                    width: double.maxFinite,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 24.h),
                                    child: Row(
                                      children: [
                                        CustomImageView(
                                          imagePath:
                                              ImageConstant.imgNotificationIcon,
                                          height: 20.h,
                                          width: 16.h,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 16.h),
                                          child: Text(
                                            "lbl_notifications".tr,
                                            style: CustomTextStyles
                                                .titleMediumMontserratTeal900,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 354.h),
                                  Container(
                                    width: double.maxFinite,
                                    padding: EdgeInsets.all(24.h),
                                    decoration: AppDecoration.outlineBlack,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomElevatedButton(
                                          height: 56.h,
                                          text: "lbl_log_out".tr,
                                          buttonStyle: CustomButtonStyles
                                              .fillPrimaryTL12,
                                          buttonTextStyle: CustomTextStyles
                                              .titleMediumMontserrat,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
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

  /// Navigates to the vfHomescreenContainerScreen when the action is triggered.
  onTapHomeicon(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.vfHomescreenContainerScreen,
    );
  }
}
