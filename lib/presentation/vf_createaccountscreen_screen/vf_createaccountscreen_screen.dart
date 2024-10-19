import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth package
import 'package:volufriend/auth/bloc/login_user_bloc.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_checkbox_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/vf_createaccountscreen_bloc.dart';
import '../../crud/add_new_user/bloc/bloc.dart'; // Import your AddNewUserBloc
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
                SizedBox(
                    height:
                        56.h), // Increased spacing for better layout balance
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                        horizontal:
                            24.h), // Reduced padding for a cleaner layout
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Align elements in the center
                      children: [
                        CustomImageView(
                          imagePath: ImageConstant.imgImage3,
                          height: 120
                              .h, // Reduced height to avoid dominating the layout
                          width: 120.h,
                        ),
                        SizedBox(height: 30.h), // Adjusted spacing
                        Text(
                          "lbl_get_started".tr,
                          style: theme.textTheme.headlineLarge?.copyWith(
                              fontSize:
                                  24), // Increased font size for visual hierarchy
                        ),
                        SizedBox(height: 12.h), // Increased for breathing room
                        Text(
                          "msg_by_creating_a_free".tr,
                          style: CustomTextStyles.titleSmallGray90003_1,
                        ),
                        SizedBox(
                            height: 16.h), // More space between title and form
                        _buildFirstNameField(context),
                        SizedBox(height: 14.h),
                        _buildLastNameField(context),
                        SizedBox(height: 14.h),
                        _buildEmailField(context),
                        SizedBox(height: 14.h),
                        _buildPhoneNumberField(context),
                        SizedBox(height: 14.h),
                        _buildPasswordField(context),
                        SizedBox(
                            height: 12.h), // Adjusted space before checkbox
                        _buildTermsConditionsCheckbox(context),
                        SizedBox(
                            height: 32
                                .h), // Reduced padding before the button for compactness
                        _buildRegisterButton(context),
                        SizedBox(height: 16.h),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  10.h), // Adjusted margin for better alignment
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center aligned text and button
                            children: [
                              Text(
                                "msg_already_a_member".tr,
                                style: CustomTextStyles.titleSmallGray90003_1,
                              ),
                              GestureDetector(
                                onTap: () {
                                  onTapTxtTitlesmalltwo(context);
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 8
                                          .h), // Slightly reduced padding for tighter layout
                                  child: Text(
                                    "lbl_log_in".tr,
                                    style: CustomTextStyles
                                        .titleSmallLightblue90001,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                            height: 16
                                .h), // Added extra padding at the bottom for balance
                      ],
                    ),
                  ),
                ),
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
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 18.h,
            ),
            borderDecoration: TextFormFieldStyleHelper.outlinePrimary,
            filled: false,
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
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 18.h,
            ),
            borderDecoration: TextFormFieldStyleHelper.outlinePrimary,
            filled: false,
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
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 18.h,
            ),
            borderDecoration: TextFormFieldStyleHelper.outlinePrimary,
            filled: false,
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
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 18.h,
            ),
            borderDecoration: TextFormFieldStyleHelper.outlinePrimary,
            filled: false,
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
            borderDecoration: TextFormFieldStyleHelper.outlinePrimary,
            filled: false,
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
  Widget _buildTermsConditionsCheckbox(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.h),
      child: BlocSelector<VfCreateaccountscreenBloc, VfCreateaccountscreenState,
          bool?>(
        selector: (state) => state.termsAndConditionsCheckbox,
        builder: (context, termsConditionsCheckbox) {
          return CustomCheckboxButton(
            text: "msg_by_checking_the".tr,
            value: termsConditionsCheckbox,
            padding: EdgeInsets.symmetric(vertical: 4.h),
            onChange: (value) {
              context
                  .read<VfCreateaccountscreenBloc>()
                  .add(ChangeCheckBoxEvent(value: value));
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
            // Registration successful, dispatch AddNewUser event
            // Get the user ID (uid)
            String? newuserId = userCredential.user?.uid;

            if (newuserId != null) {
              final firstName = context
                  .read<VfCreateaccountscreenBloc>()
                  .state
                  .firstNameFieldController!
                  .text;
              final lastName = context
                  .read<VfCreateaccountscreenBloc>()
                  .state
                  .lastNameFieldController!
                  .text;
              final email = context
                  .read<VfCreateaccountscreenBloc>()
                  .state
                  .emailFieldController!
                  .text;
              final phone = context
                  .read<VfCreateaccountscreenBloc>()
                  .state
                  .phoneNumberFieldController!
                  .text;
              final pictureUrl = ''; // Replace with actual value if available
              final role = ''; // Replace with actual role if needed
              final String dobString = '1900-01-01T01:01:01.209021';
              final DateTime dob = DateTime.parse(dobString);
              final schoolhomeorgid = '';
              final gender = '';
              final DateTime createdAt = DateTime.now();
              final DateTime updatedAt = DateTime.now();
              context.read<AddNewUserBloc>().add(
                    AddNewUser(
                      userId: newuserId,
                      firstName: firstName,
                      lastName: lastName,
                      dob: dob,
                      email: email,
                      gender: gender, // Replace with actual gender if needed
                      phone: phone,
                      pictureUrl: pictureUrl,
                      role: role,
                      createdAt: createdAt,
                      updatedAt: updatedAt,
                      schoolhomeorgid: schoolhomeorgid,
                    ),
                  );
              context.read<UserBloc>().add(RegisterUserEvent(
                    userId: newuserId, // Replace with actual user ID logic
                  ));

              NavigatorService.pushNamed(
                AppRoutes
                    .vfLoginaccountscreenScreen, // Make sure this route exists
              );
            } else {
              print("Failed to retrieve User ID");
            }
            ;
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
            print(e);
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
