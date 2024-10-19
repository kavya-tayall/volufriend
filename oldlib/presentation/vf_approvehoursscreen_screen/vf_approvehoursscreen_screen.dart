import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/app_bar/appbar_leading_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_search_view.dart';
import '../../widgets/custom_switch.dart';
import 'bloc/vf_approvehoursscreen_bloc.dart';
import 'models/userprofilelist_item_model.dart';
import 'models/vf_approvehoursscreen_model.dart';
import 'widgets/userprofilelist_item_widget.dart';

class VfApprovehoursscreenScreen extends StatelessWidget {
  const VfApprovehoursscreenScreen({Key? key})
      : super(
          key: key,
        );

  static Widget builder(BuildContext context) {
    return BlocProvider<VfApprovehoursscreenBloc>(
      create: (context) => VfApprovehoursscreenBloc(VfApprovehoursscreenState(
        vfApprovehoursscreenModelObj: VfApprovehoursscreenModel(),
      ))
        ..add(VfApprovehoursscreenInitialEvent()),
      child: VfApprovehoursscreenScreen(),
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
              height: 924.h,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: double.maxFinite,
                      decoration: AppDecoration.fillBlueGray,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 64.h),
                          Container(
                            height: 780.h,
                            width: 412.h,
                            decoration: BoxDecoration(
                              color: appTheme.gray10001,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(right: 12.h),
                    decoration: AppDecoration.surface,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomOutlinedButton(
                          text: "lbl_event_name".tr,
                          margin: EdgeInsets.only(left: 10.h),
                        ),
                        SizedBox(height: 44.h),
                        _buildSearchAndFilter(context),
                        SizedBox(height: 16.h),
                        _buildUserProfileList(context),
                        SizedBox(height: 44.h),
                        SizedBox(
                          width: double.maxFinite,
                          child: Divider(),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.h,
                            vertical: 6.h,
                          ),
                          decoration: AppDecoration.m3ElevationLight1.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomIconButton(
                                height: 18.h,
                                width: 18.h,
                                child: CustomImageView(
                                  imagePath: ImageConstant.imgVfTotalicon,
                                ),
                              ),
                              SizedBox(width: 8.h),
                              Padding(
                                padding: EdgeInsets.only(top: 8.h),
                                child: Text(
                                  "lbl_total_hours".tr,
                                  style: CustomTextStyles
                                      .titleSmallBluegray90002Bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 50.h),
                        Padding(
                          padding: EdgeInsets.only(right: 20.h),
                          child: Text(
                            "lbl_total_hours".tr,
                            style: CustomTextStyles.titleSmallGray90003_1,
                          ),
                        ),
                        SizedBox(height: 22.h),
                        CustomElevatedButton(
                          width: 106.h,
                          text: "lbl_approve".tr,
                          alignment: Alignment.center,
                        ),
                        SizedBox(height: 30.h),
                        _buildListItem(context),
                        SizedBox(height: 18.h),
                        _buildList(context),
                        SizedBox(height: 74.h)
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
  Widget _buildSearchAndFilter(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10.h,
        right: 2.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 4.h,
      ),
      decoration: AppDecoration.surface,
      width: double.maxFinite,
      child: Row(
        children: [
          Expanded(
            child: BlocSelector<VfApprovehoursscreenBloc,
                VfApprovehoursscreenState, TextEditingController?>(
              selector: (state) => state.searchController,
              builder: (context, searchController) {
                return CustomSearchView(
                  controller: searchController,
                  hintText: "lbl_value".tr,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.h,
                    vertical: 8.h,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 24.h),
          CustomImageView(
            imagePath: ImageConstant.imgFilter,
            height: 24.h,
            width: 24.h,
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUserProfileList(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 20.h,
        right: 6.h,
      ),
      child: BlocSelector<VfApprovehoursscreenBloc, VfApprovehoursscreenState,
          VfApprovehoursscreenModel?>(
        selector: (state) => state.vfApprovehoursscreenModelObj,
        builder: (context, vfApprovehoursscreenModelObj) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return SizedBox(
                height: 2.h,
              );
            },
            itemCount:
                vfApprovehoursscreenModelObj?.userprofilelistItemList.length ??
                    0,
            itemBuilder: (context, index) {
              UserprofilelistItemModel model = vfApprovehoursscreenModelObj
                      ?.userprofilelistItemList[index] ??
                  UserprofilelistItemModel();
              return UserprofilelistItemWidget(
                model,
                changeSwitch: (value) {
                  context.read<VfApprovehoursscreenBloc>().add(
                      UserprofilelistItemEvent(
                          index: index, isSelectedSwitch: value!));
                },
              );
            },
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildListItem(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(
        left: 28.h,
        right: 12.h,
      ),
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.symmetric(horizontal: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgThumbnail56x56,
                  height: 56.h,
                  width: 56.h,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "lbl_list_item".tr,
                          style: theme.textTheme.bodyLarge,
                        ),
                        Text(
                          "msg_supporting_line".tr,
                          style: CustomTextStyles.bodyMediumGray800,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.h),
                  child: Text(
                    "lbl_1002".tr,
                    style: CustomTextStyles.bodyLargeGray800,
                  ),
                ),
                BlocSelector<VfApprovehoursscreenBloc,
                    VfApprovehoursscreenState, bool?>(
                  selector: (state) => state.isSelectedSwitch,
                  builder: (context, isSelectedSwitch) {
                    return CustomSwitch(
                      margin: EdgeInsets.only(left: 10.h),
                      value: isSelectedSwitch,
                      onChange: (value) {
                        context
                            .read<VfApprovehoursscreenBloc>()
                            .add(ChangeSwitchEvent(value: value));
                      },
                    );
                  },
                )
              ],
            ),
          ),
          SizedBox(height: 8.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(
              color: appTheme.blueGray100,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildList(BuildContext context) {
    return Container(
      width: 360.h,
      margin: EdgeInsets.only(right: 6.h),
      decoration: AppDecoration.fillCyan,
      child: Column(
        children: [
          SizedBox(height: 12.h),
          Container(
            width: double.maxFinite,
            margin: EdgeInsets.only(
              left: 28.h,
              right: 16.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24.h,
                  width: 32.h,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgCheckmark,
                        height: 24.h,
                        width: 24.h,
                      ),
                      Container(
                        height: 18.h,
                        width: 18.h,
                        margin: EdgeInsets.only(left: 2.h),
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
                SizedBox(width: 18.h),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "lbl_list_item".tr,
                        style: theme.textTheme.bodyLarge,
                      ),
                      Text(
                        "msg_supporting_line".tr,
                        style: CustomTextStyles.bodyMediumGray800,
                      )
                    ],
                  ),
                ),
                SizedBox(width: 18.h),
                Text(
                  "lbl_1002".tr,
                  style: theme.textTheme.labelMedium,
                )
              ],
            ),
          ),
          SizedBox(height: 14.h),
          SizedBox(
            width: double.maxFinite,
            child: Divider(
              color: appTheme.blueGray100,
            ),
          )
        ],
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowleftone(BuildContext context) {
    NavigatorService.goBack();
  }
}
