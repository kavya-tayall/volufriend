import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import 'bloc/vf_splash_bloc.dart';
import 'models/vf_splash_model.dart';

class VfSplashScreen extends StatelessWidget {
  const VfSplashScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<VfSplashBloc>(
      create: (context) => VfSplashBloc(VfSplashState(
        vfSplashModelObj: VfSplashModel(),
      ))
        ..add(VfSplashInitialEvent()),
      child: VfSplashScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VfSplashBloc, VfSplashState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  SizedBox(height: 252.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: _buildSplashScreenColumn(context),
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

  /// Section Widget
  Widget _buildSplashScreenColumn(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 30.h),
      child: Column(
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgFrame3842,
            height: 188.h,
            width: double.maxFinite,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgFrame3841,
            height: 188.h,
            width: double.maxFinite,
          )
        ],
      ),
    );
  }
}
