import 'package:flutter/material.dart';
import '../core/app_export.dart';
import 'package:volufriend/core/utils/LocalStorageService.dart'; // Import your LocalStorageService
import '../core/utils/global.dart';
import 'package:badges/badges.dart' as custom_badge;
import 'package:badges/badges.dart'; // Import BadgePosition

enum BottomBarEnum { Home, Notifications, Schedule, Stats, Profile }

class CustomBottomBar extends StatefulWidget {
  final Function(BottomBarEnum)? onChanged;
  final LocalStorageService?
      localStorageService; // Optional LocalStorageService

  CustomBottomBar({this.onChanged, this.localStorageService});

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgNavHome,
      activeIcon: ImageConstant.imgNavHome,
      title: "lbl_home".tr,
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavNotifications,
      activeIcon: ImageConstant.imgNavNotifications,
      title: "lbl_notifications".tr,
      type: BottomBarEnum.Notifications,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavSchedule,
      activeIcon: ImageConstant.imgNavSchedule,
      title: "lbl_schedule".tr,
      type: BottomBarEnum.Schedule,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavStats,
      activeIcon: ImageConstant.imgNavStats,
      title: "lbl_stats".tr,
      type: BottomBarEnum.Stats,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavProfile,
      activeIcon: ImageConstant.imgNavProfile,
      title: "lbl_profile".tr,
      type: BottomBarEnum.Profile,
    ),
  ];

  Future<int> _getUnreadNotificationCount() async {
    final localStorageService =
        widget.localStorageService ?? globalLocalStorageService;
    if (localStorageService != null) {
      final List<Map<String, dynamic>> notifications =
          await localStorageService.getNotificationsFromPrefs();
      return notifications.where((notif) => notif['isRead'] == false).length;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FutureBuilder<int>(
                  future: _getUnreadNotificationCount(),
                  builder: (context, snapshot) {
                    if (index == 1 &&
                        snapshot.connectionState == ConnectionState.done) {
                      // If on notifications tab and Future is done
                      if (snapshot.hasData && snapshot.data! > 0) {
                        return custom_badge.Badge(
                          position: BadgePosition.topEnd(
                              top: -8, end: -8), // Position at top-right
                          badgeContent: Text(
                            snapshot.data!.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          badgeStyle: custom_badge.BadgeStyle(
                            badgeColor: Colors.red, // Customize badge color
                          ),
                          child: CustomImageView(
                            imagePath: bottomMenuList[index].icon,
                            height: 24.h,
                            width: 24.h,
                            color: appTheme.greenA100,
                          ),
                        );
                      } else {
                        // No unread notifications, show only icon
                        return CustomImageView(
                          imagePath: bottomMenuList[index].icon,
                          height: 24.h,
                          width: 24.h,
                          color: appTheme.greenA100,
                        );
                      }
                    } else {
                      return CustomImageView(
                        imagePath: bottomMenuList[index].icon,
                        height: 24.h,
                        width: 24.h,
                        color: appTheme.greenA100,
                      );
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Text(
                    bottomMenuList[index].title ?? "",
                    style: theme.textTheme.labelLarge!.copyWith(
                      color: appTheme.greenA100,
                    ),
                  ),
                )
              ],
            ),
            activeIcon: SizedBox(
              width: 64.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: appTheme.cyan900,
                      borderRadius: BorderRadius.circular(16.h),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomImageView(
                          imagePath: bottomMenuList[index].activeIcon,
                          height: 24.h,
                          width: 24.h,
                          color: appTheme.greenA100,
                          margin: EdgeInsets.fromLTRB(20.h, 4.h, 19.h, 4.h),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 6.h),
                    child: Text(
                      bottomMenuList[index].title ?? "",
                      style: theme.textTheme.labelLarge!.copyWith(
                        color: appTheme.greenA100,
                      ),
                    ),
                  )
                ],
              ),
            ),
            label: '',
          );
        }),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            widget.onChanged?.call(bottomMenuList[index].type);
          });
        },
      ),
    );
  }
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;
  String activeIcon;
  String? title;
  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
