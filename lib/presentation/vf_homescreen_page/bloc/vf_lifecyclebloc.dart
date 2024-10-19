import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'package:volufriend/core/utils/LocalStorageService.dart';

class LifecycleBloc extends Cubit<AppLifecycleState>
    with WidgetsBindingObserver {
  final LocalStorageService localStorageService;
  final VolufriendCrudService vfcurdService;
  String userId;

  LifecycleBloc({
    required this.vfcurdService,
    required this.localStorageService,
    required this.userId,
  }) : super(AppLifecycleState.resumed) {
    // Using the built-in enum
    WidgetsBinding.instance.addObserver(this);
    fetchAndStoreNotifications(); // Fetch notifications on initialization
  }

  Future<void> fetchAndStoreNotifications() async {
    // Fetch notifications from the database
    List<NotificationModel> dbNotifications =
        await vfcurdService.getNotificationsList(userId);
    print("fetchAndStoreNotifications");

    // If no notifications in the database, return early
    if (dbNotifications.isEmpty || dbNotifications == null) {
      return;
    }

    print("fetchAndStoreNotifications from DB: " +
        dbNotifications.length.toString());

    // Fetch notifications from Shared Preferences
    List<Map<String, dynamic>> storedNotificationsData =
        await localStorageService.getNotificationsFromPrefs();

    List<NotificationModel> storedNotifications = storedNotificationsData
        .map((data) => NotificationModel.fromMap(data))
        .toList();

    // Create a set of IDs from the stored notifications to track existing entries
    Set<String> storedNotificationIds =
        storedNotifications.map((notif) => notif.id).toSet();

    // Filter out notifications from the DB that are already in shared preferences
    List<NotificationModel> newNotifications = dbNotifications
        .where((dbNotif) => !storedNotificationIds.contains(dbNotif.id))
        .toList();

    if (newNotifications.isEmpty) {
      print("No new notifications to store.");
      return;
    }

    // Save only the new notifications to Shared Preferences
    for (var notification in newNotifications) {
      await localStorageService.saveNotificationToPrefs(notification.toMap());
    }

    print(
        "${newNotifications.length} new notifications added to Shared Preferences.");

    // Delete notifications from the database after storing them in Shared Preferences
    Map<String, dynamic> notificationList = {
      for (var notification in newNotifications)
        notification.id: notification.toMap()
    };

    await vfcurdService.deleteNotificationsList(notificationList);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    emit(state); // Emit the actual lifecycle state
    if (state == AppLifecycleState.resumed) {
      fetchAndStoreNotifications(); // Fetch notifications when app comes back to the foreground
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.close(); // Call super.close() for Cubit
  }
}
