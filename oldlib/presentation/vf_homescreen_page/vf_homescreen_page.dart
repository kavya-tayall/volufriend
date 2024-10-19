import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/appbar_trailing_image.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_icon_button.dart';
import 'bloc/vf_homescreen_bloc.dart';
import 'models/actionbuttons_item_model.dart';
import 'models/upcomingeventslist_item_model.dart';
import 'models/vf_homescreen_model.dart';
import 'widgets/actionbuttons_item_widget.dart';
import 'widgets/upcomingeventslist_item_widget.dart'; // ignore_for_file: must_be_immutable

class VfHomescreenPage extends StatelessWidget {
  const VfHomescreenPage({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<VfHomescreenBloc>(
      create: (context) => VfHomescreenBloc(VfHomescreenState(
        vfHomescreenModelObj: VfHomescreenModel(),
      ))
        ..add(VfHomescreenInitialEvent()),
      child: VfHomescreenPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 64.h),
                  decoration: AppDecoration.fillBlueGray,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        decoration: AppDecoration.fillGray,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildSchoolOrgHeader(context),
                            SizedBox(height: 82.h),
                            SizedBox(
                              width: double.maxFinite,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.h),
                                    child: Text(
                                      "lbl_upcoming_events".tr,
                                      style:
                                          CustomTextStyles.titleMediumGray90003,
                                    ),
                                  ),
                                  SizedBox(height: 38.h),
                                  _buildUpcomingEventsList(context),
                                  SizedBox(height: 10.h),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 30.h),
                                      child: Text(
                                        "lbl_show_all".tr,
                                        style: CustomTextStyles
                                            .titleSmallPrimary_1,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 66.h),
                                  _buildActionButtons(context)
                                ],
                              ),
                            ),
                            SizedBox(height: 118.h)
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h)
                    ],
                  ),
                ),
                SizedBox(height: 50.h),
                _buildNumberInput(context)
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
      margin: EdgeInsets.only(
        left: 8.h,
        right: 10.h,
      ),
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
  Widget _buildUpcomingEventsList(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child:
          BlocSelector<VfHomescreenBloc, VfHomescreenState, VfHomescreenModel?>(
        selector: (state) => state.vfHomescreenModelObj,
        builder: (context, vfHomescreenModelObj) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:
                vfHomescreenModelObj?.upcomingeventslistItemList.length ?? 0,
            itemBuilder: (context, index) {
              UpcomingeventslistItemModel model =
                  vfHomescreenModelObj?.upcomingeventslistItemList[index] ??
                      UpcomingeventslistItemModel();
              return UpcomingeventslistItemWidget(
                model,
              );
            },
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildActionButtons(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 356.h,
      child:
          BlocSelector<VfHomescreenBloc, VfHomescreenState, VfHomescreenModel?>(
        selector: (state) => state.vfHomescreenModelObj,
        builder: (context, vfHomescreenModelObj) {
          return ListView.separated(
            padding: EdgeInsets.only(
              left: 20.h,
              right: 30.h,
            ),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) {
              return SizedBox(
                width: 42.h,
              );
            },
            itemCount: vfHomescreenModelObj?.actionbuttonsItemList.length ?? 0,
            itemBuilder: (context, index) {
              ActionbuttonsItemModel model =
                  vfHomescreenModelObj?.actionbuttonsItemList[index] ??
                      ActionbuttonsItemModel();
              return ActionbuttonsItemWidget(
                model,
              );
            },
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildNumberInput(BuildContext context) {
    return DottedBorder(
      color: appTheme.deepPurpleA200,
      padding: EdgeInsets.only(
        left: 1.h,
        top: 1.h,
        right: 1.h,
        bottom: 1.h,
      ),
      strokeWidth: 1.h,
      radius: Radius.circular(5),
      borderType: BorderType.RRect,
      dashPattern: [10, 5],
      child: Container(
        width: 1234.h,
        padding: EdgeInsets.symmetric(vertical: 22.h),
        decoration: AppDecoration.outlineDeepPurpleA.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder5,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(left: 44.h),
              width: double.maxFinite,
              child: Row(
                children: [
                  CustomIconButton(
                    height: 24.h,
                    width: 24.h,
                    padding: EdgeInsets.all(6.h),
                    decoration: IconButtonStyleHelper.outlineBlack,
                    alignment: Alignment.bottomCenter,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgMegaphoneBlack900,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: Text(
                      "lbl_100".tr,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.titleLargeOpenSansBlack900,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: CustomIconButton(
                      height: 24.h,
                      width: 24.h,
                      padding: EdgeInsets.all(6.h),
                      decoration: IconButtonStyleHelper.outlineBlack,
                      alignment: Alignment.bottomCenter,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgPlus,
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 17,
                  ),
                  CustomIconButton(
                    height: 24.h,
                    width: 24.h,
                    padding: EdgeInsets.all(6.h),
                    decoration: IconButtonStyleHelper.outlineBlackTL12,
                    alignment: Alignment.bottomCenter,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgMegaphoneBlack900,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: Text(
                      "lbl_100".tr,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.titleLargeOpenSansBlack900,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: CustomIconButton(
                      height: 24.h,
                      width: 24.h,
                      padding: EdgeInsets.all(6.h),
                      decoration: IconButtonStyleHelper.outlineBlackTL12,
                      alignment: Alignment.bottomCenter,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgPlus,
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 19,
                  ),
                  CustomIconButton(
                    height: 24.h,
                    width: 24.h,
                    padding: EdgeInsets.all(6.h),
                    decoration: IconButtonStyleHelper.outlineBlackTL12,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgMegaphoneBlack900,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: Text(
                      "lbl_100".tr,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.titleLargeOpenSansBlack900,
                    ),
                  ),
                  Spacer(
                    flex: 63,
                  )
                ],
              ),
            ),
            SizedBox(height: 36.h),
            Container(
              padding: EdgeInsets.only(left: 32.h),
              width: double.maxFinite,
              child: Row(
                children: [
                  CustomIconButton(
                    height: 32.h,
                    width: 32.h,
                    padding: EdgeInsets.all(8.h),
                    decoration: IconButtonStyleHelper.outlineBlackTL16,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgMegaphoneBlack900,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: Text(
                      "lbl_100".tr,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: CustomIconButton(
                      height: 32.h,
                      width: 32.h,
                      padding: EdgeInsets.all(8.h),
                      decoration: IconButtonStyleHelper.outlineBlackTL16,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgPlus,
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 15,
                  ),
                  CustomIconButton(
                    height: 32.h,
                    width: 32.h,
                    padding: EdgeInsets.all(8.h),
                    decoration: IconButtonStyleHelper.outlineBlackTL161,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgMegaphoneBlack900,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: Text(
                      "lbl_100".tr,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: CustomIconButton(
                      height: 32.h,
                      width: 32.h,
                      padding: EdgeInsets.all(8.h),
                      decoration: IconButtonStyleHelper.outlineBlackTL161,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgPlus,
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 17,
                  ),
                  CustomIconButton(
                    height: 32.h,
                    width: 32.h,
                    padding: EdgeInsets.all(8.h),
                    decoration: IconButtonStyleHelper.outlineBlackTL161,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgMegaphoneBlack900,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: Text(
                      "lbl_100".tr,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                  Spacer(
                    flex: 67,
                  )
                ],
              ),
            ),
            SizedBox(height: 36.h),
            Container(
              padding: EdgeInsets.only(left: 20.h),
              width: double.maxFinite,
              child: Row(
                children: [
                  CustomIconButton(
                    height: 40.h,
                    width: 40.h,
                    padding: EdgeInsets.all(10.h),
                    decoration: IconButtonStyleHelper.outlineBlackTL20,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgMegaphoneBlack900,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: Text(
                      "lbl_100".tr,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.headlineLargeOpenSansBlack900,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: CustomIconButton(
                      height: 40.h,
                      width: 40.h,
                      padding: EdgeInsets.all(10.h),
                      decoration: IconButtonStyleHelper.outlineBlackTL20,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgPlus,
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 12,
                  ),
                  CustomIconButton(
                    height: 40.h,
                    width: 40.h,
                    padding: EdgeInsets.all(10.h),
                    decoration: IconButtonStyleHelper.outlineBlackTL201,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgMegaphoneBlack900,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: Text(
                      "lbl_100".tr,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.headlineLargeOpenSansBlack900,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: CustomIconButton(
                      height: 40.h,
                      width: 40.h,
                      padding: EdgeInsets.all(10.h),
                      decoration: IconButtonStyleHelper.outlineBlackTL201,
                      child: CustomImageView(
                        imagePath: ImageConstant.imgPlus,
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 14,
                  ),
                  CustomIconButton(
                    height: 40.h,
                    width: 40.h,
                    padding: EdgeInsets.all(10.h),
                    decoration: IconButtonStyleHelper.outlineBlackTL201,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgMegaphoneBlack900,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: Text(
                      "lbl_100".tr,
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.headlineLargeOpenSansBlack900,
                    ),
                  ),
                  Spacer(
                    flex: 72,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
