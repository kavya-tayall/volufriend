import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:intl/intl.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'bloc/vf_orgschedulescreen_bloc.dart';
import 'models/vf_orgschedulescreen_model.dart';
import '../../crud_repository/models/volufriendusermodels.dart';

class VfOrgschedulescreenScreen extends StatelessWidget {
  const VfOrgschedulescreenScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<VfOrgschedulescreenBloc>(
      create: (context) => VfOrgschedulescreenBloc(VfOrgschedulescreenState())
        ..add(VfOrgschedulescreenInitialEvent()),
      child: VfOrgschedulescreenScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Container(
            width: double.maxFinite,
            decoration: AppDecoration.fillBlueGray,
            child: ListView(
              children: [
                SizedBox(height: 32.h), // Reduced initial top padding
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                      horizontal: 2.h), // Reduced horizontal padding
                  decoration: AppDecoration.fillGray,
                  child: Column(
                    children: [
                      _buildCalendarCard(context),
                      SizedBox(
                          height:
                              16.h), // Reduced spacing below the calendar card

                      // Dynamic display of event cards based on selected day
                      BlocBuilder<VfOrgschedulescreenBloc,
                          VfOrgschedulescreenState>(
                        builder: (context, state) {
                          if (state.eventsForSelectedDay == null ||
                              state.eventsForSelectedDay!.isEmpty) {
                            return Center(
                              child: Text("No events scheduled for this day."),
                            );
                          }

                          final events = state.eventsForSelectedDay!;

                          return ListView.builder(
                            shrinkWrap: true,
                            physics:
                                NeverScrollableScrollPhysics(), // Prevent nested scroll
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              final event = events[index];
                              return Container(
                                width: double.maxFinite,
                                padding: EdgeInsets.all(
                                    12.h), // Reduced padding around each tile
                                margin: EdgeInsets.only(
                                    bottom:
                                        8.h), // Reduced margin between tiles
                                decoration: AppDecoration.fillGray,
                                child:
                                    _buildSelectedEventDetails(context, event),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 64.h), // Reduced bottom spacing
                    ],
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
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 40.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(
          left: 16.h,
          top: 20.h,
          bottom: 20.h,
        ),
        onTap: () {
          onTapArrowleftone(context);
        },
      ),
      title: AppbarTitle(
        text: "lbl_scrheadline".tr,
        margin: EdgeInsets.only(left: 16.h),
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildCalendarCard(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: BlocBuilder<VfOrgschedulescreenBloc, VfOrgschedulescreenState>(
        builder: (context, state) {
          return Container(
            height: 90.h,
            width: 368.h,
            margin: EdgeInsets.symmetric(horizontal: 8.h),
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.single,
                firstDate: DateTime(DateTime.now().year - 5),
                lastDate: DateTime(DateTime.now().year + 5),
                centerAlignModePicker: true,
                firstDayOfWeek: 0, // Week starts on Sunday
                controlsHeight: 38,
                selectedDayHighlightColor: Theme.of(context)
                    .primaryColor, // Highlight for selected day

                weekdayLabelTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 12.h,
                ),
                selectedDayTextStyle: TextStyle(
                  color: Theme.of(context)
                      .colorScheme
                      .onPrimary, // Text color for selected day
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.h,
                ),
                controlsTextStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  fontSize: 12.h,
                ),
                weekdayLabels: [
                  "SUN",
                  "MON",
                  "TUE",
                  "WED",
                  "THU",
                  "FRI",
                  "SAT"
                ],
                // Selected day decoration with rounded corners
              ),
              value: state.selectedDatesFromCalendar ?? [],
              onValueChanged: (dates) {
                context.read<VfOrgschedulescreenBloc>().add(
                      CalendarDateChangedEvent(selectedDates: dates),
                    );
              },
            ),
          );
        },
      ),
    );
  }

// Helper function to determine if a day belongs to the selected week
  bool _isInSelectedWeek(DateTime? day, List<DateTime?> selectedDates) {
    if (day == null || selectedDates.isEmpty || selectedDates.first == null)
      return false;
    final firstSelectedDay = selectedDates.first!;

    // Get the start and end of the selected week
    final startOfWeek =
        firstSelectedDay.subtract(Duration(days: firstSelectedDay.weekday % 7));
    final endOfWeek = startOfWeek.add(Duration(days: 6));

    return day.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
        day.isBefore(endOfWeek.add(Duration(days: 1)));
  }

  Widget _buildSelectedEventDetails(BuildContext context, Voluevents event) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 4.h), // Reduced vertical padding between tiles
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).colorScheme.surface, // Main container color
              borderRadius: BorderRadius.circular(
                  16), // Rounded corners for the main rectangle
            ),
            child: Row(
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center vertically
              children: [
                // Smaller vertical rectangle for weekday and date
                Padding(
                  padding:
                      EdgeInsets.only(left: 4), // Left padding for alignment
                  child: Container(
                    width: 60, // Compact width
                    height: 80, // Adjust height to be compact but proportional
                    padding: EdgeInsets.symmetric(
                        vertical: 12.h), // More compact padding
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .primaryColor, // Vertical rectangle color
                      borderRadius: BorderRadius.circular(
                          12), // Rounded corners for the vertical rectangle
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceBetween, // Align content to the top and bottom
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // Center horizontally
                      children: [
                        // Weekday aligned to center-top
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            _getWeekday(
                                event.startDate), // Weekday (e.g. Sunday)
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14, // Smaller font size for weekday
                                ),
                          ),
                        ),

                        // Day of the month aligned to center-bottom
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            "${event.startDate?.day ?? ''}", // Day of the month
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      18, // Slightly smaller font size for day of the month
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),

                // Expanded section for event details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event title
                      Text(
                        event.title ?? "Untitled Event",
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      SizedBox(height: 8.h),

                      // Shifts and sign-up count
                      if (event.shifts.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: event.shifts.length,
                              itemBuilder: (context, index) {
                                final shift = event.shifts[index];
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 4.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Shift time and activity in the same row
                                          Expanded(
                                            child: Text(
                                              "${_formatTime(shift.startTime)} - ${_formatTime(shift.endTime)}: ${shift.activity}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: Colors.black54,
                                                  ),
                                            ),
                                          ),
                                          // Hyperlink for attendance and sign-up details
                                          GestureDetector(
                                            onTap: () {
                                              // Handle on tap to open attendees list page
                                            },
                                            child: Text(
                                              "Sign-ups: ${shift.numberOfParticipants}/${shift.maxNumberOfParticipants}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: Colors
                                                        .blue, // Intuitive hyperlink color
                                                    decoration: TextDecoration
                                                        .underline, // Underline to emphasize clickability
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Separator line between shifts
                                    if (index < event.shifts.length - 1)
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.h),
                                        child: Divider(
                                          color: Colors.grey
                                              .shade300, // Soft grey separator line
                                          thickness:
                                              1, // Thickness of the separator line
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

// Helper function to get the weekday as a string
  String _getWeekday(DateTime? date) {
    if (date == null) return '';
    return ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.weekday % 7];
  }

// Helper function to format time
  String _formatTime(DateTime? date) {
    if (date == null) return '';
    return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }

  /// Section Widget
  Widget _buildEventCardRow(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 2.h),
      decoration: AppDecoration.outlineGray,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 14.h,
                  bottom: 4.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "lbl_xxam_xxpm".tr,
                      style: CustomTextStyles.titleSmallGray900,
                    ),
                    Text(
                      "lbl_event_1".tr,
                      style: CustomTextStyles.titleMediumGray900,
                    ),
                    SizedBox(height: 6.h),
                    SizedBox(
                      width: double.maxFinite,
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildColumnaccess(
                              context,
                              subheadingText: "lbl_subheading".tr,
                              bodyText: "lbl_lorem_ipsum".tr,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "lbl_subheading".tr,
                                style:
                                    CustomTextStyles.bodyMediumPlayfairDisplay,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                "lbl_lorem_ipsum".tr,
                                style: theme.textTheme.bodyMedium,
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Text(
            "lbl".tr,
            style: CustomTextStyles.headlineLargePrimary,
          )
        ],
      ),
    );
  }

  Widget _buildCompactCalendar(BuildContext context) {
    return BlocBuilder<VfOrgschedulescreenBloc, VfOrgschedulescreenState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.h),
            color: Colors.white,
          ),
          child: CalendarDatePicker2(
            config: CalendarDatePicker2Config(
              calendarType: CalendarDatePicker2Type.single,
              firstDate: DateTime.now().subtract(Duration(days: 365 * 5)),
              lastDate: DateTime.now().add(Duration(days: 365 * 5)),
              selectedDayHighlightColor: Theme.of(context).primaryColor,
              controlsHeight: 36.h,
              weekdayLabelTextStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              dayTextStyle: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              selectedDayTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            value: state.selectedDatesFromCalendar ?? [],
            onValueChanged: (dates) {
              // Handle date change
            },
          ),
        );
      },
    );
  }

  Widget _buildEventList(BuildContext context) {
    return Column(
      children: [
        _buildEventCard(
          context,
          eventTime: "10:00 AM - 11:30 AM",
          eventName: "Team Meeting",
          description: "Discuss project updates and next steps.",
        ),
        SizedBox(height: 16.h),
        _buildEventCard(
          context,
          eventTime: "1:00 PM - 2:00 PM",
          eventName: "Client Presentation",
          description: "Present the final proposal to the client.",
        ),
      ],
    );
  }

  Widget _buildEventCard(
    BuildContext context, {
    required String eventTime,
    required String eventName,
    required String description,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.h)),
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  eventTime,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Icon(Icons.arrow_forward,
                    color: Theme.of(context).primaryColor),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              eventName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 4.h),
            Text(
              description,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildEventCardColumn(
    BuildContext context, {
    required String eventTime,
    required String eventName,
    required String eventArrow,
    required String subheadingOne,
    required String descriptionOne,
    required String subheadingTwo,
    required String descriptionTwo,
  }) {
    return Container(
      decoration: AppDecoration.outlineGray,
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 14.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            eventTime,
                            style: CustomTextStyles.titleSmallGray900.copyWith(
                              color: appTheme.gray900,
                            ),
                          ),
                          Text(
                            eventName,
                            style: CustomTextStyles.titleMediumGray900.copyWith(
                              color: appTheme.gray900,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  eventArrow,
                  style: CustomTextStyles.headlineLargePrimary.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 6.h),
          SizedBox(
            width: double.maxFinite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subheadingOne,
                        style:
                            CustomTextStyles.bodyMediumPlayfairDisplay.copyWith(
                          color: appTheme.gray900,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        descriptionOne,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: appTheme.gray900,
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subheadingTwo,
                      style:
                          CustomTextStyles.bodyMediumPlayfairDisplay.copyWith(
                        color: appTheme.gray900,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      descriptionTwo,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: appTheme.gray900,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 4.h)
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildColumnaccess(
    BuildContext context, {
    required String subheadingText,
    required String bodyText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subheadingText,
          style: CustomTextStyles.bodyMediumPlayfairDisplay.copyWith(
            color: appTheme.gray900,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          bodyText,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: appTheme.gray900,
          ),
        )
      ],
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone(BuildContext context) {
    NavigatorService.goBack();
  }
}
