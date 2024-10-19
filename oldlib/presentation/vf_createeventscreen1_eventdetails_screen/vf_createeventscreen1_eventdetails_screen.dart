import 'package:flutter/material.dart';
import 'package:volufriend/presentation/vf_createeventscreen2_eventshifts_screen/vf_createeventscreen2_eventshifts_screen.dart';
import '../../core/app_export.dart';
import '../../core/utils/date_time_utils.dart';
import '../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_drop_down.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_text_field.dart';
import '../vf_homescreen_page/vf_homescreen_page.dart';
import 'bloc/vf_createeventscreen1_eventdetails_bloc.dart';
import 'models/vf_createeventscreen1_eventdetails_model.dart';

// ignore_for_file: must_be_immutable
class VfCreateeventscreen1EventdetailsScreen extends StatelessWidget {
  VfCreateeventscreen1EventdetailsScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    return BlocProvider<VfCreateeventscreen1EventdetailsBloc>(
      create: (context) => VfCreateeventscreen1EventdetailsBloc(
          VfCreateeventscreen1EventdetailsState(
        vfCreateeventscreen1EventdetailsModelObj:
            VfCreateeventscreen1EventdetailsModel(),
      ))
        ..add(VfCreateeventscreen1EventdetailsInitialEvent()),
      child: VfCreateeventscreen1EventdetailsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: 64.h),
              decoration: AppDecoration.fillBlueGray,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 6.h),
                    decoration: AppDecoration.fillGray,
                    child: Column(
                      children: [
                        _buildSchoolOrgHeader(context),
                        SizedBox(height: 14.h),
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(right: 2.h),
                          child: Column(
                            children: [
                              _buildEventTypeSection(context),
                              SizedBox(height: 18.h),
                              _buildTitleInput(context),
                              SizedBox(height: 26.h),
                              BlocSelector<
                                  VfCreateeventscreen1EventdetailsBloc,
                                  VfCreateeventscreen1EventdetailsState,
                                  VfCreateeventscreen1EventdetailsModel?>(
                                selector: (state) => state
                                    .vfCreateeventscreen1EventdetailsModelObj,
                                builder: (context,
                                    vfCreateeventscreen1EventdetailsModelObj) {
                                  return CustomDropDown(
                                    width: 328.h,
                                    icon: Container(
                                      margin: EdgeInsets.only(left: 16.h),
                                      child: CustomImageView(
                                        imagePath: ImageConstant
                                            .imgIcarrowdropdown48pxPrimary,
                                        height: 24.h,
                                        width: 24.h,
                                      ),
                                    ),
                                    hintText: "lbl_cause".tr,
                                    alignment: Alignment.centerLeft,
                                    items:
                                        vfCreateeventscreen1EventdetailsModelObj
                                                ?.dropdownItemList ??
                                            [],
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 14.h,
                                      vertical: 18.h,
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 20.h),
                              _buildVenueInput(context),
                              SizedBox(height: 26.h),
                              _buildDateRow(context),
                              SizedBox(height: 26.h),
                              _buildRegistrationDeadlineInput(context),
                              SizedBox(height: 146.h),
                              _buildNextButton(context)
                            ],
                          ),
                        ),
                        SizedBox(height: 46.h)
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h)
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          width: double.maxFinite,
          child: _buildBottomNavigationBar(context),
        ),
      ),
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
          top: 20.h,
          bottom: 20.h,
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
            top: 20.h,
            right: 16.h,
            bottom: 20.h,
          ),
        )
      ],
      styleType: Style.bgFill,
    );
  }

  /// Section Widget
  Widget _buildSchoolOrgHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4.h),
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
        vertical: 12.h,
      ),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.circleBorder24,
      ),
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "lbl_hi_john_doe".tr,
            style: theme.textTheme.titleMedium,
          ),
          Text(
            "msg_bothell_high_school".tr,
            style: theme.textTheme.titleMedium,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildEventTypeSection(BuildContext context) {
    return SizedBox(
      height: 64.h,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(
              horizontal: 8.h,
              vertical: 12.h,
            ),
            decoration: AppDecoration.outlinePrimary.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.h,
                    vertical: 4.h,
                  ),
                  decoration: AppDecoration.fillGray20001.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "lbl_in_person".tr,
                        style: theme.textTheme.bodySmall,
                      ),
                      SizedBox(width: 6.h),
                      CustomImageView(
                        imagePath: ImageConstant.imgClosePrimary,
                        height: 20.h,
                        width: 20.h,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 14.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.h,
                    vertical: 4.h,
                  ),
                  decoration: AppDecoration.fillGray20001.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "lbl_virtual".tr,
                        style: theme.textTheme.bodySmall,
                      ),
                      SizedBox(width: 4.h),
                      CustomImageView(
                        imagePath: ImageConstant.imgClosePrimary,
                        height: 20.h,
                        width: 20.h,
                      )
                    ],
                  ),
                ),
                Spacer(),
                CustomImageView(
                  imagePath: ImageConstant.imgIcArrowDropDown48px,
                  height: 20.h,
                  width: 20.h,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(left: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 4.h),
              decoration: AppDecoration.surface,
              child: Text(
                "lbl_event_type".tr,
                textAlign: TextAlign.center,
                style: CustomTextStyles.bodySmallRobotoPrimary,
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildTitleInput(BuildContext context) {
    return BlocSelector<VfCreateeventscreen1EventdetailsBloc,
        VfCreateeventscreen1EventdetailsState, TextEditingController?>(
      selector: (state) => state.titleInputController,
      builder: (context, titleInputController) {
        return CustomFloatingTextField(
          controller: titleInputController,
          labelText: "lbl_title".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "lbl_title".tr,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildVenueInput(BuildContext context) {
    return BlocSelector<VfCreateeventscreen1EventdetailsBloc,
        VfCreateeventscreen1EventdetailsState, TextEditingController?>(
      selector: (state) => state.venueInputController,
      builder: (context, venueInputController) {
        return CustomFloatingTextField(
          controller: venueInputController,
          labelText: "lbl_event_venue".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "lbl_event_venue".tr,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildEventDateInput(BuildContext context) {
    return BlocSelector<VfCreateeventscreen1EventdetailsBloc,
        VfCreateeventscreen1EventdetailsState, TextEditingController?>(
      selector: (state) => state.eventDateInputController,
      builder: (context, eventDateInputController) {
        return CustomFloatingTextField(
          readOnly: true,
          width: 182.h,
          controller: eventDateInputController,
          labelText: "lbl_event_date".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "lbl_event_date".tr,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
          onTap: () {
            onTapEventDateInput(context);
          },
        );
      },
    );
  }

  /// Section Widget
  Widget _buildMinimumAgeInput(BuildContext context) {
    return BlocSelector<VfCreateeventscreen1EventdetailsBloc,
        VfCreateeventscreen1EventdetailsState, TextEditingController?>(
      selector: (state) => state.minimumAgeInputController,
      builder: (context, minimumAgeInputController) {
        return CustomFloatingTextField(
          width: 182.h,
          controller: minimumAgeInputController,
          labelText: "lbl_event_date".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "lbl_event_date".tr,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildDateRow(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildEventDateInput(context),
          _buildMinimumAgeInput(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRegistrationDeadlineInput(BuildContext context) {
    return BlocSelector<VfCreateeventscreen1EventdetailsBloc,
        VfCreateeventscreen1EventdetailsState, TextEditingController?>(
      selector: (state) => state.registrationDeadlineInputController,
      builder: (context, registrationDeadlineInputController) {
        return CustomFloatingTextField(
          width: 182.h,
          controller: registrationDeadlineInputController,
          labelText: "msg_registration_deadline".tr,
          labelStyle: theme.textTheme.bodyLarge!,
          hintText: "msg_registration_deadline".tr,
          textInputAction: TextInputAction.done,
          alignment: Alignment.centerLeft,
          contentPadding: EdgeInsets.fromLTRB(16.h, 24.h, 16.h, 8.h),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildNextButton(BuildContext context) {
    return CustomElevatedButton(
      width: 106.h,
      text: "lbl_next".tr,
    );
  }

  /// Section Widget
  Widget _buildBottomNavigationBar(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: CustomBottomBar(
        onChanged: (BottomBarEnum type) {
          Navigator.pushNamed(
              navigatorKey.currentContext!, getCurrentRoute(type));
        },
      ),
    );
  }

  ///Handling route based on bottom click actions
  String getCurrentRoute(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Home:
        return AppRoutes.vfHomescreenPage;
      case BottomBarEnum.Notifications:
        return "/";
      case BottomBarEnum.Schedule:
        return "/";
      case BottomBarEnum.Stats:
        return "/";
      case BottomBarEnum.Profile:
        return "/";
      default:
        return "/";
    }
  }

  ///Handling page based on route
  Widget getCurrentPage(
    BuildContext context,
    String currentRoute,
  ) {
    switch (currentRoute) {
      case AppRoutes.vfHomescreenPage:
        return VfHomescreenPage.builder(context);
      default:
        return DefaultWidget();
    }
  }

  /// Displays a date picker dialog and updates the selected date in the
  /// current [vfCreateeventscreen1EventdetailsModelObj] object if the user selects a valid date.
  ///
  /// This function returns a `Future` that completes with `void`.
  Future<void> onTapEventDateInput(BuildContext context) async {
    var initialState =
        BlocProvider.of<VfCreateeventscreen1EventdetailsBloc>(context).state;
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day));
    if (dateTime != null) {
      context
          .read<VfCreateeventscreen1EventdetailsBloc>()
          .add(ChangeDateEvent(date: dateTime));
      initialState.eventDateInputController?.text =
          dateTime.format(pattern: dateTimeFormatPattern);
    }
  }
}
