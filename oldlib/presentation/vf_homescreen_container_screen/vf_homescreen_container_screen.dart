import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../vf_homescreen_page/vf_homescreen_page.dart';
import 'bloc/vf_homescreen_container_bloc.dart';
import 'models/vf_homescreen_container_model.dart';

// ignore_for_file: must_be_immutable
class VfHomescreenContainerScreen extends StatelessWidget {
  VfHomescreenContainerScreen({Key? key})
      : super(
          key: key,
        );

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Widget builder(BuildContext context) {
    return BlocProvider<VfHomescreenContainerBloc>(
      create: (context) => VfHomescreenContainerBloc(VfHomescreenContainerState(
        vfHomescreenContainerModelObj: VfHomescreenContainerModel(),
      ))
        ..add(VfHomescreenContainerInitialEvent()),
      child: VfHomescreenContainerScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VfHomescreenContainerBloc, VfHomescreenContainerState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Navigator(
              key: navigatorKey,
              initialRoute: AppRoutes.vfHomescreenPage,
              onGenerateRoute: (routeSetting) => PageRouteBuilder(
                pageBuilder: (ctx, ani, ani1) =>
                    getCurrentPage(context, routeSetting.name!),
                transitionDuration: Duration(seconds: 0),
              ),
            ),
            bottomNavigationBar: SizedBox(
              width: double.maxFinite,
              child: _buildBottomNavigationBar(context),
            ),
          ),
        );
      },
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
}
