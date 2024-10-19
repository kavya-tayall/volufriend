part of 'app_navigation_bloc.dart';

/// Represents the state of AppNavigation in the application.
class AppNavigationState extends Equatable {
  final AppNavigationModel? appNavigationModelObj;
  final String? sourceScreen; // Add this field if it is used
  final String? destinationScreen; // Add this field if it is used

  AppNavigationState(
      {this.appNavigationModelObj, this.sourceScreen, this.destinationScreen});

  @override
  List<Object?> get props =>
      [appNavigationModelObj, sourceScreen, destinationScreen];

  AppNavigationState copyWith({
    AppNavigationModel? appNavigationModelObj,
    String? sourceScreen,
    String? destinationScreen,
  }) {
    return AppNavigationState(
      appNavigationModelObj:
          appNavigationModelObj ?? this.appNavigationModelObj,
      sourceScreen: sourceScreen ?? this.sourceScreen,
      destinationScreen: destinationScreen ?? this.destinationScreen,
    );
  }
}
