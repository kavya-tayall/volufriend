import 'package:flutter/material.dart';
import 'package:volufriend/presentation/vf_createeventscreen1_eventdetails_screen/vf_createeventscreen1_eventdetails_screen.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_text_field.dart';
import '../../widgets/custom_icon_button.dart';
import '../vf_homescreen_page/vf_homescreen_page.dart';
import 'bloc/vf_createeventscreen2_eventshifts_bloc.dart';
import 'models/vf_createeventscreen2_eventshifts_model.dart';
import '../../presentation/vf_createeventscreen1_eventdetails_screen/bloc/vf_createeventscreen1_eventdetails_bloc.dart';
import '../../presentation/vf_createeventscreen1_eventdetails_screen/models/vf_createeventscreen1_eventdetails_model.dart';
import '/crud_repository/volufriend_crud_repo.dart';
import '../../auth/bloc/login_user_bloc.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import '../vf_homescreen_container_screen/bloc/vf_homescreen_container_bloc.dart';

// ignore_for_file: must_be_immutable
class VfCreateeventscreen2EventshiftsScreen extends StatelessWidget {
  VfCreateeventscreen2EventshiftsScreen({Key? key}) : super(key: key);

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    print('Current context from shift: $context');
    // Access Event details from the first Bloc
    final EventBloc =
        BlocProvider.of<VfCreateeventscreen1EventdetailsBloc>(context);
    final EventState = EventBloc.state;

    final orgEvent =
        EventState.vfCreateeventscreen1EventdetailsModelObj?.orgEvent;
    // print('Orgstate from shift: $orgEvent');

    // Check if the VfCreateeventscreen2EventshiftsBloc is already provided
    final existingBloc = BlocProvider.of<VfCreateeventscreen2EventshiftsBloc>(
        context,
        listen: false);
    print('ExistingBloc: $existingBloc');
    // If an existing Bloc is not found, create a new one
    if (existingBloc != null) {
      // Dispatch the initial event if the Bloc already exists
      existingBloc
          .add(VfCreateeventscreen2EventshiftsInitialEvent(orgEvent: orgEvent));
      return BlocProvider.value(
        value: existingBloc,
        child: VfCreateeventscreen2EventshiftsScreen(),
      );
    } else {
      // Create a new BlocProvider if one does not exist
      return BlocProvider<VfCreateeventscreen2EventshiftsBloc>(
        create: (context) => VfCreateeventscreen2EventshiftsBloc(
          vfcrudService: VolufriendCrudService(),
        )..add(VfCreateeventscreen2EventshiftsInitialEvent(orgEvent: orgEvent)),
        child: VfCreateeventscreen2EventshiftsScreen(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: const Text("Manage Event Shifts"),
              backgroundColor: Theme.of(context).colorScheme.primary,
              elevation: 0, // Remove shadow for a cleaner look
            ),
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 24.h),
                decoration: AppDecoration.fillBlueGray,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Main Container for Shift Details
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.h, vertical: 16.h),
                      decoration: AppDecoration.fillGray,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Shift 1 Details
                          Text(
                            "lbl_shift_1".tr,
                            style: CustomTextStyles.titleSmallBlack900_1,
                          ),
                          SizedBox(height: 8.h),
                          _buildShift1Details(context),
                          SizedBox(height: 24.h),

                          // Shift 2 Details
                          Text(
                            "lbl_shift_2".tr,
                            style: CustomTextStyles.titleSmallBlack900_1,
                          ),
                          SizedBox(height: 8.h),
                          _buildShift2Details(context),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h), // Consistent spacing
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomElevatedButton(
                    onPressed: () {
                      context.read<VfCreateeventscreen2EventshiftsBloc>().add(
                            SaveShiftDetailsEvent(),
                          );
                      NavigatorService.pushNamed(
                          AppRoutes.vfCreateeventscreen1EventdetailsScreen);
                    },
                    text: "lbl_prev".tr,
                    width: 120.h,
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      context.read<VfCreateeventscreen2EventshiftsBloc>().add(
                            SaveShiftDetailsEvent(),
                          );
                      NavigatorService.pushNamed(AppRoutes
                          .vfCreateeventscreen3EventadditionaldetailsScreen);
                    },
                    text: "lbl_next".tr,
                    width: 120.h,
                  ),
                ],
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
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgMegaphone,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 16.h,
          bottom: 16.h,
        ),
      ),
      centerTitle: true,
      title: AppbarTitle(
        text: "lbl_title".tr,
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgSearch,
          margin: EdgeInsets.only(
            top: 16.h,
            right: 16.h,
            bottom: 16.h,
          ),
        )
      ],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget: Shift 1 Activity Input
  Widget _buildShift1ActivityInput(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shift1ActivityInputController,
      builder: (context, shift1ActivityInputController) {
        return CustomFloatingTextField(
          controller: shift1ActivityInputController,
          labelText: "lbl_shift_activity".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_shift_activity".tr,
          contentPadding: EdgeInsets.all(16.h), // Uniform padding
          filled: false,
        );
      },
    );
  }

  Widget _buildShift1StartTime(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shift1StartTimeController,
      builder: (context, shift1StartTimeController) {
        return GestureDetector(
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              builder: (BuildContext context, Widget? child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: false),
                  child: child!,
                );
              },
              initialEntryMode: TimePickerEntryMode.input,
            );
            if (pickedTime != null) {
              // Simply format and set the selected time without any validation
              final formatted24HourTime = pickedTime.format(context);

              shift1StartTimeController?.text = formatted24HourTime;
              context.read<VfCreateeventscreen2EventshiftsBloc>().add(
                    UpdateShift1StartTimeEvent(starttime: formatted24HourTime),
                  );
            }
          },
          child: AbsorbPointer(
            child: CustomFloatingTextField(
              width: 134.h,
              controller: shift1StartTimeController,
              labelText: "lbl_start_time".tr,
              labelStyle: theme.textTheme.bodyLarge!,
              hintText: "msg_start_time".tr,
              contentPadding: EdgeInsets.all(16.h),
            ),
          ),
        );
      },
    );
  }

  /// Section Widget: Shift 1 End Time
  Widget _buildShift1EndTime(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.h), // Left padding only for separation
      child: BlocSelector<VfCreateeventscreen2EventshiftsBloc,
          VfCreateeventscreen2EventshiftsState, TextEditingController?>(
        selector: (state) => state.shift1EndTimeController,
        builder: (context, shift1EndTimeController) {
          return GestureDetector(
            onTap: () {
              _selectShift1EndTime(context,
                  shift1EndTimeController!); // Call the async function here
            },
            child: AbsorbPointer(
              child: CustomFloatingTextField(
                width: 134.h,
                controller: shift1EndTimeController,
                labelText: "lbl_end_time".tr,
                labelStyle: Theme.of(context).textTheme.bodyLarge!,
                hintText: "msg_end_time".tr,
                contentPadding: EdgeInsets.all(16.h), // Uniform padding
              ),
            ),
          );
        },
      ),
    );
  }

  void _selectShift1EndTime(BuildContext context,
      TextEditingController shift1EndTimeController) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
      initialEntryMode: TimePickerEntryMode.input,
    );

    if (pickedTime != null) {
      // Simply format and set the selected time without checking for start time
      final formatted24HourTime = pickedTime.format(context);
      shift1EndTimeController?.text = formatted24HourTime;
      context.read<VfCreateeventscreen2EventshiftsBloc>().add(
            UpdateShift1EndTimeEvent(endtime: formatted24HourTime),
          );
    }
  }

  /// Section Widget: Shift 1 Max Participants
  Widget _buildShift1MaxParticipants(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shift1MaxParticipantsController,
      builder: (context, shift1MaxParticipantsController) {
        return CustomFloatingTextField(
          width: 134.h,
          controller: shift1MaxParticipantsController,
          labelText: "lbl_max_participants".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_max_participants".tr,
          contentPadding: EdgeInsets.all(16.h), // Uniform padding
          filled: false,
        );
      },
    );
  }

  /// Section Widget: Shift 1 Minimum Age Input
  Widget _buildShift1MinimumAgeInput(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shift1MinimumAgeController,
      builder: (context, shift1MinimumAgeController) {
        return CustomFloatingTextField(
          width: 134.h,
          controller: shift1MinimumAgeController,
          labelText: "lbl_minimum_age".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_minimum_age".tr,
          contentPadding:
              EdgeInsets.all(16.h), // Adjusted padding for consistency
          filled: false,
        );
      },
    );
  }

  /// Section Widget: Shift 1 Details
  Widget _buildShift1Details(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.h), // Consistent padding
      decoration: AppDecoration.outlineBlack9001,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShift1ActivityInput(context),
          SizedBox(height: 16.h), // Consistent space between rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space evenly
            children: [
              _buildShift1StartTime(context),
              _buildShift1EndTime(context),
            ],
          ),
          SizedBox(height: 16.h), // Consistent space between rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space evenly
            children: [
              _buildShift1MaxParticipants(context),
              _buildShift1MinimumAgeInput(context),
            ],
          ),
        ],
      ),
    );
  }

  /// Section Widget: Shift 2 Activity Input
  Widget _buildShift2ActivityInput(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shift2ActivityInputController,
      builder: (context, shift2ActivityInput1Controller) {
        return CustomFloatingTextField(
          controller: shift2ActivityInput1Controller,
          labelText: "lbl_activity".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "lbl_activity".tr,
          contentPadding: EdgeInsets.all(16.h), // Uniform padding
          filled: false,
        );
      },
    );
  }

  /// Section Widget: Shift 2 Start Time
  Widget _buildShift2StartTime(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shift2StartTimeController,
      builder: (context, shift2StartTime1Controller) {
        return GestureDetector(
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              builder: (BuildContext context, Widget? child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: false),
                  child: child!,
                );
              },
              initialEntryMode: TimePickerEntryMode.input,
            );
            if (pickedTime != null) {
              final formattedTime = pickedTime.format(context);
              shift2StartTime1Controller?.text = formattedTime;
              context.read<VfCreateeventscreen2EventshiftsBloc>().add(
                    UpdateShift2StartTimeEvent(starttime: formattedTime),
                  );
            }
          },
          child: AbsorbPointer(
            child: CustomFloatingTextField(
              width: 134.h,
              controller: shift2StartTime1Controller,
              labelText: "lbl_start_time".tr,
              labelStyle: theme.textTheme.bodyLarge!,
              hintText: "lbl_start_time".tr,
              contentPadding: EdgeInsets.all(16.h), // Uniform padding
            ),
          ),
        );
      },
    );
  }

  /// Section Widget: Shift 2 End Time
  Widget _buildShift2EndTime(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.h), // Left padding only for separation
      child: BlocSelector<VfCreateeventscreen2EventshiftsBloc,
          VfCreateeventscreen2EventshiftsState, TextEditingController?>(
        selector: (state) => state.shift2EndTimeController,
        builder: (context, shift2EndTimeController) {
          return GestureDetector(
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                builder: (BuildContext context, Widget? child) {
                  return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: false),
                    child: child!,
                  );
                },
                initialEntryMode: TimePickerEntryMode.input,
              );
              if (pickedTime != null) {
                // Set the selected time without validation
                final formattedTime = pickedTime.format(context);
                shift2EndTimeController?.text = formattedTime;
                context.read<VfCreateeventscreen2EventshiftsBloc>().add(
                      UpdateShift2EndTimeEvent(endtime: formattedTime),
                    );
              }
            },
            child: AbsorbPointer(
              child: CustomFloatingTextField(
                width: 134.h,
                controller: shift2EndTimeController,
                labelText: "lbl_end_time".tr,
                labelStyle: theme.textTheme.bodyLarge!,
                hintText: "msg_end_time".tr,
                contentPadding: EdgeInsets.all(16.h), // Uniform padding
              ),
            ),
          );
        },
      ),
    );
  }

  /// Section Widget: Shift 2 Max Participants
  Widget _buildShift2MaxParticipants(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shift2MaxParticipantsController,
      builder: (context, shiftMax2Participants1Controller) {
        return CustomFloatingTextField(
          width: 134.h,
          controller: shiftMax2Participants1Controller,
          labelText: "msg_max_participants".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_max_participants".tr,
          contentPadding: EdgeInsets.all(16.h), // Uniform padding
          filled: false,
        );
      },
    );
  }

  /// Section Widget: Shift 2 Minimum Age Input
  Widget _buildShift2MinimumAgeInput(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shift2MinimumAgeController,
      builder: (context, shift2MinimumAgeController) {
        return CustomFloatingTextField(
          width: 134.h,
          controller: shift2MinimumAgeController,
          labelText: "lbl_minimum_age".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_minimum_age".tr,
          contentPadding:
              EdgeInsets.all(16.h), // Adjusted padding for consistency
          filled: false,
        );
      },
    );
  }

  /// Section Widget: Shift 2 Details
  Widget _buildShift2Details(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.h), // Consistent padding
      decoration: AppDecoration.outlineBlack9001,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShift2ActivityInput(context),
          SizedBox(height: 16.h), // Consistent space between rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space evenly
            children: [
              _buildShift2StartTime(context),
              _buildShift2EndTime(context),
            ],
          ),
          SizedBox(height: 16.h), // Consistent space between rows
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space evenly
            children: [
              _buildShift2MaxParticipants(context),
              _buildShift2MinimumAgeInput(context),
            ],
          ),
        ],
      ),
    );
  }
}
