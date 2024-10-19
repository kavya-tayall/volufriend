import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/vf_joinasscreen_bloc.dart';
import 'models/vf_joinasscreen_model.dart';
import '../../auth/bloc/login_user_bloc.dart';

class VfJoinasscreenScreen extends StatelessWidget {
  const VfJoinasscreenScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        print("Mohit");
        print(userState);
        if (userState is LoginUserWithHomeOrg) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            NavigatorService.pushNamed(AppRoutes.vfHomescreenContainerScreen);
          });
          return SizedBox.shrink();
        }

        return VfJoinasscreenScreenContent();
      },
    );
  }

  static Widget builder(BuildContext context) {
    return BlocProvider<VfJoinasscreenBloc>(
      create: (context) => VfJoinasscreenBloc(VfJoinasscreenState(
        vfJoinasscreenModelObj: VfJoinasscreenModel(joinAs: ''),
      ))
        ..add(VfJoinasscreenInitialEvent()),
      child: VfJoinasscreenScreen(),
    );
  }
}

class VfJoinasscreenScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VfJoinasscreenBloc, VfJoinasscreenState>(
      listener: (context, state) {
        if (state is JoinAsVolunteerState) {
          NavigatorService.pushNamed(AppRoutes.vfVolunteerWelcomeScreen);
        } else if (state is JoinAsOrganizationState) {
          NavigatorService.pushNamed(AppRoutes.vfWelcomescreenScreen);
        }
      },
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
                                  margin: EdgeInsets.only(left: 4.h),
                                  onPressed: () {
                                    context
                                        .read<VfJoinasscreenBloc>()
                                        .add(JoinAsVolunteerEvent());
                                  },
                                ),
                                SizedBox(height: 24.h),
                                CustomElevatedButton(
                                  text: "lbl_an_organization".tr,
                                  margin: EdgeInsets.only(left: 4.h),
                                  onPressed: () {
                                    context
                                        .read<VfJoinasscreenBloc>()
                                        .add(JoinAsOrganizationEvent());
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
