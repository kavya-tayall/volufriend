import 'package:flutter/material.dart';
import '../../core/app_export.dart';

import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_text_field.dart';

import 'bloc/vf_createeventscreen2_eventshifts_bloc.dart';

import '../../presentation/vf_createeventscreen1_eventdetails_screen/bloc/vf_createeventscreen1_eventdetails_bloc.dart';

import 'package:volufriend/widgets/vf_app_bar_with_title_back_button.dart';

class VfCreateeventscreen2EventshiftsScreen extends StatelessWidget {
  VfCreateeventscreen2EventshiftsScreen({Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    final EventBloc =
        BlocProvider.of<VfCreateeventscreen1EventdetailsBloc>(context);
    final EventState = EventBloc.state;
    final orgEvent =
        EventState.vfCreateeventscreen1EventdetailsModelObj?.orgEvent;
    final existingBloc = BlocProvider.of<VfCreateeventscreen2EventshiftsBloc>(
        context,
        listen: false);

    existingBloc
        .add(VfCreateeventscreen2EventshiftsInitialEvent(orgEvent: orgEvent));
    return BlocProvider.value(
      value: existingBloc,
      child: VfCreateeventscreen2EventshiftsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: VfAppBarWithTitleBackButton(
              title: context
                          .read<VfCreateeventscreen1EventdetailsBloc>()
                          .state
                          .formContext ==
                      "create"
                  ? "Create Event - Shifts"
                  : "Edit Event - Shifts",
              showSearchIcon: false,
              showFilterIcon: false,
              onBackPressed: () {
                Navigator.of(context).pop();
              },
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.h),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.h),
                      decoration: AppDecoration.fillGray.copyWith(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "lbl_shift_1".tr,
                            style: CustomTextStyles.titleSmallBlack900_1,
                          ),
                          SizedBox(height: 12.h),
                          _buildShift1Details(context),
                          SizedBox(height: 24.h),
                          Text(
                            "lbl_shift_2".tr,
                            style: CustomTextStyles.titleSmallBlack900_1,
                          ),
                          SizedBox(height: 12.h),
                          _buildShift2Details(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
              child: Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () {
                        context
                            .read<VfCreateeventscreen2EventshiftsBloc>()
                            .add(SaveShiftDetailsEvent());
                        NavigatorService.pushNamed(
                            AppRoutes.vfCreateeventscreen1EventdetailsScreen);
                      },
                      text: "lbl_prev".tr,
                    ),
                  ),
                  SizedBox(width: 16.h), // Spacing between buttons
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: () {
                        context
                            .read<VfCreateeventscreen2EventshiftsBloc>()
                            .add(SaveShiftDetailsEvent());
                        NavigatorService.pushNamed(AppRoutes
                            .vfCreateeventscreen3EventadditionaldetailsScreen);
                      },
                      text: "lbl_next".tr,
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

  Widget _buildShift1ActivityInput(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shift1ActivityInputController,
      builder: (context, shift1ActivityInputController) {
        return CustomFloatingTextField(
          controller: shift1ActivityInputController,
          labelText: "lbl_activity".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_activity".tr,
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.h),
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
              initialEntryMode: TimePickerEntryMode.input,
              builder: (context, child) {
                return MediaQuery(
                    data: MediaQuery.of(context)
                        .copyWith(alwaysUse24HourFormat: false),
                    child: child!);
              },
            );
            if (pickedTime != null) {
              final formattedTime = pickedTime.format(context);
              shift1StartTimeController?.text = formattedTime;
              context
                  .read<VfCreateeventscreen2EventshiftsBloc>()
                  .add(UpdateShift1StartTimeEvent(starttime: formattedTime));
            }
          },
          child: AbsorbPointer(
            child: CustomFloatingTextField(
              width: 134.h,
              controller: shift1StartTimeController,
              labelText: "lbl_start_time".tr,
              labelStyle: theme.textTheme.bodyLarge!,
              hintText: "msg_start_time".tr,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.h),
            ),
          ),
        );
      },
    );
  }

  Widget _buildShift1EndTime(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.h),
      child: BlocSelector<VfCreateeventscreen2EventshiftsBloc,
          VfCreateeventscreen2EventshiftsState, TextEditingController?>(
        selector: (state) => state.shift1EndTimeController,
        builder: (context, shift1EndTimeController) {
          return GestureDetector(
            onTap: () async {
              // Get the start time from the controller
              String? startTimeText = context
                  .read<VfCreateeventscreen2EventshiftsBloc>()
                  .state
                  .shift1StartTimeController
                  ?.text;
              TimeOfDay initialEndTime = TimeOfDay.now();

              if (startTimeText != null && startTimeText.isNotEmpty) {
                final startTime = TimeOfDay(
                  hour: int.parse(startTimeText.split(":")[0]),
                  minute: int.parse(startTimeText.split(":")[1].split(" ")[0]),
                );
                // Set the initial end time to be at least 30 minutes after start time
                initialEndTime = TimeOfDay(
                  hour: (startTime.hour + 1) % 24,
                  minute: startTime.minute,
                );
              }

              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: initialEndTime,
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
                shift1EndTimeController?.text = formattedTime;
                context
                    .read<VfCreateeventscreen2EventshiftsBloc>()
                    .add(UpdateShift1EndTimeEvent(endtime: formattedTime));
              }
            },
            child: AbsorbPointer(
              child: CustomFloatingTextField(
                width: 134.h,
                controller: shift1EndTimeController,
                labelText: "lbl_end_time".tr,
                labelStyle: Theme.of(context).textTheme.bodyLarge!,
                hintText: "msg_end_time".tr,
                contentPadding: EdgeInsets.all(16.h),
              ),
            ),
          );
        },
      ),
    );
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
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.h),
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

  /// Section Widget: Shift 2 Activity Input
  Widget _buildShift2ActivityInput(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shift2ActivityInputController,
      builder: (context, shift2ActivityInputController) {
        return CustomFloatingTextField(
          controller: shift2ActivityInputController,
          labelText: "lbl_activity".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_activity".tr,
          contentPadding: EdgeInsets.all(16.h), // Uniform padding
          filled: false,
        );
      },
    );
  }

  Widget _buildShift2StartTime(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shift2StartTimeController,
      builder: (context, shift2StartTimeController) {
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
              final formatted24HourTime = pickedTime.format(context);
              shift2StartTimeController?.text = formatted24HourTime;
              context.read<VfCreateeventscreen2EventshiftsBloc>().add(
                    UpdateShift2StartTimeEvent(starttime: formatted24HourTime),
                  );
            }
          },
          child: AbsorbPointer(
            child: CustomFloatingTextField(
              width: 134.h,
              controller: shift2StartTimeController,
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

  /// Section Widget: Shift 2 End Time
  Widget _buildShift2EndTime(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.h), // Left padding only for separation
      child: BlocSelector<VfCreateeventscreen2EventshiftsBloc,
          VfCreateeventscreen2EventshiftsState, TextEditingController?>(
        selector: (state) => state.shift2EndTimeController,
        builder: (context, shift2EndTimeController) {
          return GestureDetector(
            onTap: () {
              _selectShift2EndTime(context,
                  shift2EndTimeController!); // Call the async function here
            },
            child: AbsorbPointer(
              child: CustomFloatingTextField(
                width: 134.h,
                controller: shift2EndTimeController,
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

  void _selectShift2EndTime(BuildContext context,
      TextEditingController shift2EndTimeController) async {
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
      final formatted24HourTime = pickedTime.format(context);
      shift2EndTimeController.text = formatted24HourTime;
      context.read<VfCreateeventscreen2EventshiftsBloc>().add(
            UpdateShift2EndTimeEvent(endtime: formatted24HourTime),
          );
    }
  }

  /// Section Widget: Shift 2 Max Participants
  Widget _buildShift2MaxParticipants(BuildContext context) {
    return BlocSelector<VfCreateeventscreen2EventshiftsBloc,
        VfCreateeventscreen2EventshiftsState, TextEditingController?>(
      selector: (state) => state.shift2MaxParticipantsController,
      builder: (context, shift2MaxParticipantsController) {
        return CustomFloatingTextField(
          width: 134.h,
          controller: shift2MaxParticipantsController,
          labelText: "lbl_max_participants".tr,
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
          contentPadding: EdgeInsets.all(16.h), // Uniform padding
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
