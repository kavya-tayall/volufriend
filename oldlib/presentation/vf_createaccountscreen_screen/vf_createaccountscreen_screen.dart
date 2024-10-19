import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth package
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/vf_createaccountscreen_bloc.dart';
import 'models/vf_createaccountscreen_model.dart';

// ignore_for_file: must_be_immutable
class VfCreateaccountscreenScreen extends StatelessWidget {
  VfCreateaccountscreenScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance; // Add FirebaseAuth instance

  static Widget builder(BuildContext context) {
    return BlocProvider<VfCreateaccountscreenBloc>(
      create: (context) => VfCreateaccountscreenBloc(VfCreateaccountscreenState(
        vfCreateaccountscreenModelObj: VfCreateaccountscreenModel(),
      ))
        ..add(VfCreateaccountscreenInitialEvent()),
      child: VfCreateaccountscreenScreen(),
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
                SizedBox(height: 56.h),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 48.h),
                    child: Column(
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgImage3,
                          height: 150.h,
                          width: 152.h,
                        ),
                        SizedBox(height: 40.h),
                        Text(
                          "lbl_get_started".tr,
                          style: theme.textTheme.headlineLarge,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          "msg_by_creating_a_free".tr,
                          style: theme.textTheme.titleSmall,
                        ),
                        SizedBox(height: 12.h),
                        _buildFirstNameField(context),
                        SizedBox(height: 16.h),
                        _buildLastNameField(context),
                        SizedBox(height: 16.h),
                        _buildEmailField(context),
                        SizedBox(height: 16.h),
                        _buildPhoneNumberField(context),
                        SizedBox(height: 16.h),
                        _buildPasswordField(context),
                        SizedBox(height: 8.h),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(left: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  height: 24.h,
                                  width: 24.h,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      CustomImageView(
                                        imagePath: ImageConstant.imgCheckmark,
                                        height: 24.h,
                                        width: double.maxFinite,
                                      ),
                                      Container(
                                        height: 18.h,
                                        width: 18.h,
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.primary,
                                          borderRadius: BorderRadius.circular(
                                            2.h,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 6.h),
                              Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "msg_by_checking_the2".tr,
                                        style: theme.textTheme.labelMedium,
                                      ),
                                      TextSpan(
                                        text: "lbl_terms".tr,
                                        style: theme.textTheme.labelMedium,
                                      ),
                                      TextSpan(
                                        text: "lbl_and".tr,
                                        style: theme.textTheme.labelMedium,
                                      ),
                                      TextSpan(
                                        text: "lbl_conditions".tr,
                                        style: theme.textTheme.labelMedium,
                                      ),
                                      TextSpan(
                                        text: "lbl".tr,
                                        style: theme.textTheme.labelMedium,
                                      )
                                    ],
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 48.h),
                        _buildRegisterButton(context),
                        SizedBox(height: 12.h),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.symmetric(horizontal: 40.h),
                          child: Row(
                            children: [
                              Text(
                                "msg_already_a_member".tr,
                                style: theme.textTheme.titleSmall,
                              ),
                              GestureDetector(
                                onTap: () {
                                  onTapTxtTitlesmalltwo(context);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(left: 14.h),
                                  child: Text(
                                    "lbl_log_in".tr,
                                    style: theme.textTheme.titleSmall,
                                  ),
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
  Widget _buildFirstNameField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.h),
      child: BlocSelector<VfCreateaccountscreenBloc, VfCreateaccountscreenState,
          TextEditingController?>(
        selector: (state) => state.firstNameFieldController,
        builder: (context, firstNameFieldController) {
          return CustomTextFormField(
            controller: firstNameFieldController,
            hintText: "msg_enter_your_first".tr,
            contentPadding: EdgeInsets.all(16.h),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "err_msg_please_enter_your_first_name";
              } else if (!isText(value)) {
                return "err_msg_please_enter_valid_text";
              }
              return null;
            },
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildLastNameField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.h),
      child: BlocSelector<VfCreateaccountscreenBloc, VfCreateaccountscreenState,
          TextEditingController?>(
        selector: (state) => state.lastNameFieldController,
        builder: (context, lastNameFieldController) {
          return CustomTextFormField(
            controller: lastNameFieldController,
            hintText: "msg_enter_your_last".tr,
            contentPadding: EdgeInsets.all(16.h),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "err_msg_please_enter_your_last_name";
              } else if (!isText(value)) {
                return "err_msg_please_enter_valid_text";
              }
              return null;
            },
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildEmailField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.h),
      child: BlocSelector<VfCreateaccountscreenBloc, VfCreateaccountscreenState,
          TextEditingController?>(
        selector: (state) => state.emailFieldController,
        builder: (context, emailFieldController) {
          return CustomTextFormField(
            controller: emailFieldController,
            hintText: "msg_enter_your_email".tr,
            textInputType: TextInputType.emailAddress,
            contentPadding: EdgeInsets.all(16.h),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !isValidEmail(value, isRequired: true)) {
                return "err_msg_please_enter_valid_email";
              }
              return null;
            },
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildPhoneNumberField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.h),
      child: BlocSelector<VfCreateaccountscreenBloc, VfCreateaccountscreenState,
          TextEditingController?>(
        selector: (state) => state.phoneNumberFieldController,
        builder: (context, phoneNumberFieldController) {
          return CustomTextFormField(
            controller: phoneNumberFieldController,
            hintText: "msg_enter_your_phone".tr,
            textInputType: TextInputType.phone,
            contentPadding: EdgeInsets.all(16.h),
            validator: (value) {
              if (value == null || value.isEmpty || !isValidPhone(value)) {
                return "err_msg_please_enter_valid_phone_number";
              }
              return null;
            },
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildPasswordField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.h,
        right: 2.h,
      ),
      child: BlocBuilder<VfCreateaccountscreenBloc, VfCreateaccountscreenState>(
        builder: (context, state) {
          return CustomTextFormField(
            controller: state.passwordFieldController,
            hintText: "msg_enter_your_password".tr,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.visiblePassword,
            suffix: InkWell(
              onTap: () {
                context.read<VfCreateaccountscreenBloc>().add(
                    ChangePasswordVisibilityEvent(
                        value: !state.isShowPassword));
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(16.h, 16.h, 12.h, 16.h),
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
            contentPadding: EdgeInsets.fromLTRB(16.h, 16.h, 12.h, 16.h),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !isValidPassword(value, isRequired: true)) {
                return "err_msg_please_enter_valid_password";
              }

              return null;
            },
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildRegisterButton(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_register".tr,
      margin: EdgeInsets.symmetric(horizontal: 6.h),
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          try {
            // Firebase user registration
            UserCredential userCredential =
                await _auth.createUserWithEmailAndPassword(
              email: context
                  .read<VfCreateaccountscreenBloc>()
                  .state
                  .emailFieldController!
                  .text,
              password: context
                  .read<VfCreateaccountscreenBloc>()
                  .state
                  .passwordFieldController!
                  .text,
            );
            // Registration successful, navigate to next screen
            NavigatorService.pushNamed(
              AppRoutes
                  .vfLoginaccountscreenScreen, // Make sure this route exists
            );
          } on FirebaseAuthException catch (e) {
            String errorMessage;
            if (e.code == 'weak-password') {
              errorMessage = 'The password provided is too weak.';
            } else if (e.code == 'email-already-in-use') {
              errorMessage = 'The account already exists for that email.';
            } else {
              errorMessage = 'An error occurred. Please try again.';
            }
            // Show a SnackBar with the error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage)),
            );
          } catch (e) {
            // General error handling
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('An error occurred. Please try again.')),
            );
          }
        }
      },
    );
  }

  /// Navigates to the vfLoginaccountscreenScreen when the action is triggered.
  onTapTxtTitlesmalltwo(BuildContext context) {
    NavigatorService.pushNamed(
      AppRoutes.vfLoginaccountscreenScreen,
    );
  }
}
