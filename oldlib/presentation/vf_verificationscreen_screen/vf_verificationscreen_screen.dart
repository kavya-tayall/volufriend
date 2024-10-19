import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/appbar_leading_iconbutton.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_pin_code_text_field.dart';
import 'bloc/vf_verificationscreen_bloc.dart';
import 'models/vf_verificationscreen_model.dart';

class VfVerificationscreenScreen extends StatelessWidget {
  const VfVerificationscreenScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<VfVerificationscreenBloc>(
      create: (context) => VfVerificationscreenBloc(VfVerificationscreenState(
        vfVerificationscreenModelObj: VfVerificationscreenModel(),
      ))
        ..add(VfVerificationscreenInitialEvent()),
      child: VfVerificationscreenScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 14.h),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "lbl_almost_there".tr,
                  style: theme.textTheme.headlineSmall,
                ),
                SizedBox(height: 24.h),
                Text(
                  "msg_please_enter_the".tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall!.copyWith(
                    height: 1.43,
                  ),
                ),
                SizedBox(height: 46.h),
                Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: BlocSelector<VfVerificationscreenBloc,
                      VfVerificationscreenState, TextEditingController?>(
                    selector: (state) => state.otpController,
                    builder: (context, otpController) {
                      return CustomPinCodeTextField(
                        context: context,
                        controller: otpController,
                        onChanged: (value) {
                          otpController?.text = value;
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 52.h),
                CustomElevatedButton(
                  height: 40.h,
                  width: 86.h,
                  text: "lbl_verify".tr,
                  buttonStyle: CustomButtonStyles.fillGray,
                  buttonTextStyle: CustomTextStyles.titleSmallGray90002,
                  alignment: Alignment.center,
                ),
                SizedBox(height: 34.h),
                Padding(
                  padding: EdgeInsets.only(left: 6.h),
                  child: Text(
                    "msg_didn_t_receive_any".tr,
                    style: CustomTextStyles.titleSmallGray900,
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.symmetric(horizontal: 18.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Spacer(),
                      Text(
                        "msg_request_new_code".tr,
                        style: theme.textTheme.titleSmall,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 6.h),
                        child: Text(
                          "lbl_00_30".tr,
                          style: CustomTextStyles.titleSmallPrimary,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 6.h),
                        child: Text(
                          "lbl_seconds".tr,
                          style: theme.textTheme.titleSmall,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 312.h),
                CustomElevatedButton(
                  text: "lbl_verify".tr,
                  margin: EdgeInsets.symmetric(horizontal: 32.h),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 74.h,
      leading: AppbarLeadingIconbutton(
        imagePath: ImageConstant.imgVector,
        margin: EdgeInsets.only(
          left: 44.h,
          top: 12.h,
          bottom: 13.h,
        ),
      ),
    );
  }
}
