import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'bloc/vf_orgschedulescreen_bloc.dart';
import 'models/vf_orgschedulescreen_model.dart';

class VfOrgschedulescreenScreen extends StatelessWidget {
  const VfOrgschedulescreenScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<VfOrgschedulescreenBloc>(
      create: (context) => VfOrgschedulescreenBloc(VfOrgschedulescreenState(
        vfOrgschedulescreenModelObj: VfOrgschedulescreenModel(),
      ))
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
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              decoration: AppDecoration.fillBlueGray,
              child: Column(
                children: [
                  SizedBox(height: 64.h),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 4.h),
                    decoration: AppDecoration.fillGray,
                    child: Column(
                      children: [
                        _buildCalendarCard(context),
                        SizedBox(height: 30.h),
                        _buildEventCardRow(context),
                        SizedBox(height: 30.h),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(right: 2.h),
                          child: _buildEventCardColumn(
                            context,
                            eventTime: "lbl_xxam_xxpm".tr,
                            eventName: "lbl_event_1".tr,
                            eventArrow: "lbl".tr,
                            subheadingOne: "lbl_subheading".tr,
                            descriptionOne: "lbl_lorem_ipsum".tr,
                            subheadingTwo: "lbl_subheading".tr,
                            descriptionTwo: "lbl_lorem_ipsum".tr,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(right: 2.h),
                          child: _buildEventCardColumn(
                            context,
                            eventTime: "lbl_xxam_xxpm".tr,
                            eventName: "lbl_event_1".tr,
                            eventArrow: "lbl".tr,
                            subheadingOne: "lbl_subheading".tr,
                            descriptionOne: "lbl_lorem_ipsum".tr,
                            subheadingTwo: "lbl_subheading".tr,
                            descriptionTwo: "lbl_lorem_ipsum".tr,
                          ),
                        ),
                        SizedBox(height: 232.h)
                      ],
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

  /// Section Widget
  Widget _buildCalendarCard(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: BlocBuilder<VfOrgschedulescreenBloc, VfOrgschedulescreenState>(
        builder: (context, state) {
          return Container(
            height: 90.h,
            width: 368.h,
            margin: EdgeInsets.only(
              left: 8.h,
              right: 28.h,
            ),
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                calendarType: CalendarDatePicker2Type.single,
                firstDate: DateTime(DateTime.now().year - 5),
                lastDate: DateTime(DateTime.now().year + 5),
                selectedDayHighlightColor: Color(0XFFFFFFFF),
                centerAlignModePicker: true,
                firstDayOfWeek: 0,
                controlsHeight: 38,
                weekdayLabelTextStyle: TextStyle(
                  color: appTheme.gray900,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
                selectedDayTextStyle: TextStyle(
                  color: Color(0XFF1B1C1E),
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
                controlsTextStyle: TextStyle(
                  color: appTheme.gray900,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
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
              ),
              value: state.selectedDatesFromCalendar ?? [],
              onValueChanged: (dates) {
                state.selectedDatesFromCalendar = dates;
              },
            ),
          );
        },
      ),
    );
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
