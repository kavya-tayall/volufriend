import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static final SharedPreferencesService _instance =
      SharedPreferencesService._internal();
  static SharedPreferences? _prefs;

  factory SharedPreferencesService() {
    return _instance;
  }

  SharedPreferencesService._internal();

  Future<SharedPreferences> get prefs async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs!;
  }
}

class LocalStorageService {
  static LocalStorageService? _instance;
  final SharedPreferences _prefs;

  // Factory constructor to ensure a single instance of LocalStorageService
  factory LocalStorageService({required SharedPreferences prefs}) {
    _instance ??= LocalStorageService._internal(prefs);
    return _instance!;
  }

  LocalStorageService._internal(this._prefs); // Private constructor

  // Marks a notification as read based on its ID
  Future<void> markAsRead(String id) async {
    // Retrieve the list of notifications
    List<String> messages = _prefs.getStringList('notifications') ?? [];

    // Update the isRead flag for the notification with the given ID
    List<String> updatedMessages = messages.map((msg) {
      final Map<String, dynamic> data = jsonDecode(msg);
      if (data['id'] == id) {
        data['isRead'] = true;
      }
      return jsonEncode(data); // Return the updated message as a string
    }).toList();

    // Save the updated list back to SharedPreferences
    await _prefs.setStringList('notifications', updatedMessages);
  }

  // Clears all notifications from SharedPreferences
  Future<void> clearMessages() async {
    await _prefs.remove('notifications');
    await _prefs.clear();
  }

  // Saves a new notification to SharedPreferences
  Future<void> saveNotificationToPrefs(
      Map<String, dynamic> notificationData) async {
    print('prefs: in saveNotificationToPrefs ${_prefs.hashCode}');

    // Retrieve the existing notifications list (if any)
    List<String> notifications = _prefs.getStringList('notifications') ?? [];
    print('Current notifications count: ${notifications.length}');

    // Add the new notification to the list (as a JSON string)
    notifications.add(jsonEncode(notificationData));

    // Save the updated list back to SharedPreferences
    try {
      await _prefs.setStringList('notifications', notifications);
      await _prefs
          .reload(); // Reload SharedPreferences to ensure data consistency
      print('Notifications saved successfully.');
    } catch (e) {
      print("Error saving notifications: $e");
    }

    // Optional: Check the saved data immediately after saving
    final updatedNotifications = await getNotificationsFromPrefs();
    print(
        'Immediately after saving, retrieved notifications: $updatedNotifications');
  }

  // Retrieves all notifications from SharedPreferences
  Future<List<Map<String, dynamic>>> getNotificationsFromPrefs() async {
    print('prefs: in getNotificationsFromPrefs ${_prefs.hashCode}');

    // Retrieve the stored notification strings (if any)
    List<String> notificationStrings =
        _prefs.getStringList('notifications') ?? [];

    // Convert JSON strings back to Map objects
    List<Map<String, dynamic>> notifications =
        notificationStrings.map((notificationString) {
      return Map<String, dynamic>.from(jsonDecode(notificationString));
    }).toList();

    return notifications;
  }
}
