import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth package
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_checkbox_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/vf_loginaccountscreen_bloc.dart';
import 'models/vf_loginaccountscreen_model.dart';

// ignore_for_file: must_be_immutable
class VfLoginaccountscreenScreen extends StatelessWidget {
  VfLoginaccountscreenScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance; // Add FirebaseAuth instance

  static Widget builder(BuildContext context) {
    return BlocProvider<VfLoginaccountscreenBloc>(
      create: (context) => VfLoginaccountscreenBloc(VfLoginaccountscreenState(
        vfLoginaccountscreenModelObj: VfLoginaccountscreenModel(),
      ))
        ..add(VfLoginaccountscreenInitialEvent()),
      child: VfLoginaccountscreenScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                SizedBox(height: 58.h),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 54.h),
                    child: Column(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgImage3,
                          height: 140.h,
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: 76.h),
                        ),
                        SizedBox(height: 46.h),
                        Text(
                          "lbl_welcome_back".tr,
                          style: theme.textTheme.headlineLarge,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "msg_sign_in_to_access".tr,
                          style: theme.textTheme.titleSmall,
                        ),
                        SizedBox(height: 46.h),
                        BlocSelector<VfLoginaccountscreenBloc,
                            VfLoginaccountscreenState, TextEditingController?>(
                          selector: (state) => state.emailController,
                          builder: (context, emailController) {
                            return CustomTextFormField(
                              controller: emailController,
                              hintText: "msg_enter_your_email".tr,
                              textInputType: TextInputType.emailAddress,
                              contentPadding: EdgeInsets.all(16.h),
                              validator: (value) {
                                if (value == null ||
                                    (!isValidEmail(value, isRequired: true))) {
                                  return "err_msg_please_enter_valid_email";
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        SizedBox(height: 16.h),
                        BlocBuilder<VfLoginaccountscreenBloc,
                            VfLoginaccountscreenState>(
                          builder: (context, state) {
                            return CustomTextFormField(
                              controller: state.passwordController,
                              hintText: "msg_enter_your_password".tr,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.visiblePassword,
                              suffix: InkWell(
                                onTap: () {
                                  context.read<VfLoginaccountscreenBloc>().add(
                                      ChangePasswordVisibilityEvent(
                                          value: !state.isShowPassword));
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      16.h, 16.h, 12.h, 16.h),
                                  child: CustomImageView(
                                    imagePath: ImageConstant.imgIcon,
                                    height: 24.h,
                                    width: 24.h,
                                  ),
                                ),
                              ),
                              suffixConstraints: BoxConstraints(
                                maxHeight: 56.h,
                              ),
                              obscureText: state.isShowPassword,
                              contentPadding:
                                  EdgeInsets.fromLTRB(16.h, 16.h, 12.h, 16.h),
                              validator: (value) {
                                if (value == null ||
                                    (!isValidPassword(value,
                                        isRequired: true))) {
                                  return "err_msg_please_enter_valid_password";
                                }
                                return null;
                              },
                            );
                          },
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(right: 6.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildRememberMeCheckbox(context),
                              Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "lbl_forgot_password".tr,
                                  style:
                                      CustomTextStyles.titleSmallLightblue90001,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 230.h),
                        CustomElevatedButton(
                          text: "lbl_login2".tr,
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              try {
                                // Firebase user login
                                UserCredential userCredential =
                                    await _auth.signInWithEmailAndPassword(
                                  email: context
                                      .read<VfLoginaccountscreenBloc>()
                                      .state
                                      .emailController!
                                      .text,
                                  password: context
                                      .read<VfLoginaccountscreenBloc>()
                                      .state
                                      .passwordController!
                                      .text,
                                );
                                // Login successful, navigate to the welcome screen or another screen
                                NavigatorService.pushNamed(
                                  AppRoutes
                                      .vfJoinasscreenScreen, // Update this to your actual route
                                );
                              } on FirebaseAuthException catch (e) {
                                String errorMessage;
                                if (e.code == 'user-not-found') {
                                  errorMessage =
                                      'No user found for that email.';
                                } else if (e.code == 'wrong-password') {
                                  errorMessage = 'Wrong password provided.';
                                } else {
                                  errorMessage = e.toString();
                                }
                                // Show a SnackBar with the error message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(errorMessage)),
                                );
                              } catch (e) {
                                // General error handling
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'An error occurred. Please try again.')),
                                );
                              }
                            }
                          },
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(
                            left: 56.h,
                            right: 62.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "lbl_new_member".tr,
                                style: theme.textTheme.titleSmall,
                              ),
                              SizedBox(width: 10.h),
                              GestureDetector(
                                onTap: () {
                                  onTapTxtTitlesmall(context);
                                },
                                child: Text(
                                  "lbl_register_now".tr,
                                  style:
                                      CustomTextStyles.titleSmallLightblue90001,
                                ),
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
      ),
    );
  }

  /// Section Widget
  Widget _buildRememberMeCheckbox(BuildContext context) {
    return BlocSelector<VfLoginaccountscreenBloc, VfLoginaccountscreenState,
        bool?>(
      selector: (state) => state.rememberMeCheckbox,
      builder: (context, rememberMeCheckbox) {
        return CustomCheckboxButton(
          text: "lbl_remember_me".tr,
          value: rememberMeCheckbox,
          onChange: (value) {
            context
                .read<VfLoginaccountscreenBloc>()
                .add(ChangeCheckBoxEvent(value: value));
          },
        );
      },
    );
  }

  /// Navigates to the vfCreateaccountscreenScreen when the action is triggered.
  onTapTxtTitlesmall(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.vfCreateaccountscreenScreen,
    );
  }
}
