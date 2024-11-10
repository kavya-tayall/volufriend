import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volufriend/crud_repository/models/LoginUserModel.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import '../../core/app_export.dart';
import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_checkbox_button.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'bloc/vf_loginaccountscreen_bloc.dart';
import 'models/vf_loginaccountscreen_model.dart';
import '../../auth/bloc/login_user_bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class VfLoginaccountscreenScreen extends StatelessWidget {
  VfLoginaccountscreenScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
        body: BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state is NoHomeOrg) {
              NavigatorService.pushNamed(AppRoutes.vfJoinasscreenScreen);
            } else if (state is LoginUserWithHomeOrg) {
              LoginUserWithHomeOrg state =
                  context.read<UserBloc>().state as LoginUserWithHomeOrg;

              String? userId = state.userId;
              String? role = state.user.role;
              String homeOrg = state.user.userHomeOrg?.parentorg ?? '';

              print("setting up FCM");
              if (userId != null && role != null && homeOrg != null) {
                setupFCM(
                  userId,
                  role,
                  homeOrg,
                );
              } else {
                // Handle the case where one of the values is null
              }

              NavigatorService.pushNamed(AppRoutes.vfHomescreenContainerScreen);
            } else if (state is LoginFail) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.redAccent,
                ),
              );
            }
          },
          child: Form(
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
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            "msg_sign_in_to_access".tr,
                            style: CustomTextStyles.titleSmallGray90003_1,
                          ),
                          SizedBox(height: 46.h),
                          _buildEmailField(context),
                          SizedBox(height: 16.h),
                          _buildPasswordField(context),
                          SizedBox(height: 6.h),
                          _buildRememberMeAndForgotPassword(context),
                          SizedBox(height: 230.h),
                          _buildLoginButton(context),
                          SizedBox(height: 10.h),
                          _buildRegisterNow(context),
                        ],
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
  }

  Widget _buildEmailField(BuildContext context) {
    return BlocSelector<VfLoginaccountscreenBloc, VfLoginaccountscreenState,
        TextEditingController?>(
      selector: (state) => state.emailController,
      builder: (context, emailController) {
        return CustomTextFormField(
          controller: emailController,
          hintText: "msg_enter_your_email".tr,
          textInputType: TextInputType.emailAddress,
          contentPadding: EdgeInsets.all(16.h),
          borderDecoration: TextFormFieldStyleHelper.outlinePrimary,
          filled: false,
          validator: (value) {
            if (value == null || !isValidEmail(value, isRequired: true)) {
              return "err_msg_please_enter_valid_email";
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return BlocBuilder<VfLoginaccountscreenBloc, VfLoginaccountscreenState>(
      builder: (context, state) {
        return CustomTextFormField(
          controller: state.passwordController,
          hintText: "msg_enter_your_password".tr,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          suffix: InkWell(
            onTap: () {
              context.read<VfLoginaccountscreenBloc>().add(
                  ChangePasswordVisibilityEvent(value: !state.isShowPassword));
            },
            child: Icon(
              state.isShowPassword ? Icons.visibility : Icons.visibility_off,
              size: 24.h,
            ),
          ),
          obscureText: state.isShowPassword,
          contentPadding: EdgeInsets.fromLTRB(16.h, 16.h, 12.h, 16.h),
          borderDecoration: TextFormFieldStyleHelper.outlinePrimary,
          filled: false,
          validator: (value) {
            if (value == null || !isValidPassword(value, isRequired: true)) {
              return "err_msg_please_enter_valid_password";
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildRememberMeAndForgotPassword(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildRememberMeCheckbox(context),
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: () {
                // Handle forgot password action
              },
              child: Text(
                "lbl_forgot_password".tr,
                style: CustomTextStyles.titleSmallLightblue90001,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return CustomElevatedButton(
      text: "lbl_login2".tr,
      onPressed: () async {
        if (_formKey.currentState?.validate() ?? false) {
          try {
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
            String? userId = userCredential.user?.uid;
            print('userid: $userId');

            if (userId != null) {
              // Change to Login State
              context.read<UserBloc>().add(LoginUserEvent(userId: userId));
            } else {
              print("Failed to retrieve User ID");
            }
          } on FirebaseAuthException catch (e) {
            String errorMessage;
            if (e.code == 'user-not-found') {
              errorMessage = 'No user found for that email.';
            } else if (e.code == 'wrong-password') {
              errorMessage = 'Wrong password provided.';
            } else {
              errorMessage = e.toString();
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage),
                backgroundColor: Colors.redAccent,
              ),
            );
          } catch (e) {
            print(e.toString());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text('An error occurred. Please try again.' + e.toString()),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        }
      },
    );
  }

  Widget _buildRegisterNow(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(left: 56.h, right: 62.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "lbl_new_member".tr,
            style: CustomTextStyles.titleSmallGray90003_1,
          ),
          SizedBox(width: 10.h),
          GestureDetector(
            onTap: () {
              onTapTxtTitlesmall(context);
            },
            child: Text(
              "lbl_register_now".tr,
              style: CustomTextStyles.titleSmallLightblue90001,
            ),
          ),
        ],
      ),
    );
  }

  /// Navigates to the vfCreateaccountscreenScreen when the action is triggered.
  onTapTxtTitlesmall(BuildContext context) {
    NavigatorService.pushNamed(AppRoutes.vfCreateaccountscreenScreen);
  }

  Widget _buildRememberMeCheckbox(BuildContext context) {
    return BlocSelector<VfLoginaccountscreenBloc, VfLoginaccountscreenState,
        bool?>(
      selector: (state) => state.rememberMeCheckbox,
      builder: (context, rememberMeCheckbox) {
        return CustomCheckboxButton(
          text: "lbl_remember_me".tr,
          value: rememberMeCheckbox,
          textStyle: CustomTextStyles.titleSmallGray90003_1,
          onChange: (value) {
            context
                .read<VfLoginaccountscreenBloc>()
                .add(ChangeCheckBoxEvent(value: value));
          },
        );
      },
    );
  }

  /// Set up Firebase Cloud Messaging
  Future<void> setupFCM(String userId, String role, String homeOrg) async {
    String parentOrg = homeOrg;
    String modifiedOrg = parentOrg.replaceAll(RegExp(r'\s+'), '_');
    print("modifiedOrg: $modifiedOrg");
    print("role: $role");

// Subscribe to the topic
    final messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic(modifiedOrg);

    // subscribeToTopic("mohit");

    messaging.getToken().then((token) {
      registerToken(userId, token);
    });

    // Listen for token refresh events
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
      // Send the new token to your backend
      registerToken(userId, newToken);
      // FirebaseMessaging.instance.subscribeToTopic("events");
    });
  }

  /// Register the token to the backend
  void registerToken(String userId, String? token) {
    if (token != null) {
      print("Registering token: $token");
      // Call the method in your service to send the token to the backend
      VolufriendCrudService()
          .sendFcmToken(userId: userId, token: token)
          .then((result) {
        // Optionally handle the result
        if (result == 200) {
          print("Token registered successfully.");
        } else {
          print("Failed to register token. " + result.toString());
        }
      }).catchError((error) {
        print("Error registering token: $error");
      });
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    try {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
      String msg = "Subscribed to $topic";
      print(msg);
    } catch (e) {
      String msg = "Subscribe failed: $e";
      print(msg);
    }
  }
}
