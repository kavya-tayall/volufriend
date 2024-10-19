// global.dart
import 'package:volufriend/core/utils/LocalStorageService.dart';
import 'package:shared_preferences/shared_preferences.dart';

LocalStorageService? globalLocalStorageService;
SharedPreferences? globalPrefs;

Future<void> initGlobalServices() async {
  try {
    // Access SharedPreferences
    SharedPreferences prefs = await SharedPreferencesService().prefs;
    globalPrefs = prefs;
    print('SharedPreferences globalPrefs instance: ${globalPrefs.hashCode}');

    // Initialize LocalStorageService
    if (globalPrefs != null) {
      globalLocalStorageService = LocalStorageService(prefs: globalPrefs!);
      print('LocalStorageService initialized successfully.');
    } else {
      print('Error: globalPrefs is null');
    }
  } catch (e) {
    print('Error during global services initialization: $e');
  }
}
