import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/vf_joinasscreen_bloc.dart';
import 'models/vf_joinasscreen_model.dart';

class VfJoinasscreenScreen extends StatelessWidget {
  const VfJoinasscreenScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<VfJoinasscreenBloc>(
      create: (context) => VfJoinasscreenBloc(VfJoinasscreenState(
        vfJoinasscreenModelObj: VfJoinasscreenModel(),
      ))
        ..add(VfJoinasscreenInitialEvent()),
      child: VfJoinasscreenScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VfJoinasscreenBloc, VfJoinasscreenState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(height: 68.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgJoinasframe2,
                            height: 200.h,
                            width: double.maxFinite,
                            margin: EdgeInsets.only(
                              left: 36.h,
                              right: 24.h,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          CustomImageView(
                            imagePath: ImageConstant.imgJoinasframe1,
                            height: 296.h,
                            width: double.maxFinite,
                          ),
                          SizedBox(height: 64.h),
                          Container(
                            width: double.maxFinite,
                            margin: EdgeInsets.only(
                              left: 50.h,
                              right: 54.h,
                            ),
                            child: Column(
                              children: [
                                CustomElevatedButton(
                                  text: "lbl_a_volunteer".tr,
                                  margin: EdgeInsets.only(left: 4.h)
                                ),
                                SizedBox(height: 24.h),
                                CustomElevatedButton(
                                  text: "lbl_an_organization".tr,
                                  margin: EdgeInsets.only(left: 4.h)
                                )
                              ],
                            ),
                          )
                        ],
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
}
