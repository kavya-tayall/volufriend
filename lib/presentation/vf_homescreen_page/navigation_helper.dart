class NavigationHelper {
  static bool _isNavigating = false;

  static bool get isNavigating => _isNavigating;

  static void startNavigation() {
    _isNavigating = true;
  }

  static void endNavigation() {
    _isNavigating = false;
  }
}
