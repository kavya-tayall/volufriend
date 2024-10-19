import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'package:volufriend/core/utils/LocalStorageService.dart'; // Import your LocalStorageService

part 'vf_notificationspage_event.dart';
part 'vf_notificationspage_state.dart';

class VfNotificationspageBloc
    extends Bloc<VfNotificationspageEvent, VfNotificationspageState> {
  final LocalStorageService localStorageService;
  final VolufriendCrudService vfcurdService;

  // Constructor with named parameters
  VfNotificationspageBloc({
    required this.vfcurdService,
    required this.localStorageService,
    required VfNotificationspageState initialState,
  }) : super(initialState) {
    on<LoadNotificationsEvent>(_onLoadNotifications);
    on<DeleteNotificationEvent>(_onDeleteNotification);
    on<DeleteAllNotificationsEvent>(_onDeleteAllNotifications);
    on<MarkNotificationAsReadEvent>(_onMarkNotificationAsRead);
    on<SaveNotificationEvent>(_onSaveNotification);
  }

  Future<void> _onLoadNotifications(LoadNotificationsEvent event,
      Emitter<VfNotificationspageState> emit) async {
    emit(NotificationsLoading());
    try {
      List<Map<String, dynamic>> notificationsData =
          await localStorageService.getNotificationsFromPrefs();

      List<NotificationModel> notifications = notificationsData
          .map((data) =>
              NotificationModel.fromMap(data)) // fromMap is now available
          .toList();
/*
      List<NotificationModel> dbNotifications =
          await vfcurdService.getNotificationsList(event.userId);

      notifications.addAll(dbNotifications);*/

      emit(NotificationsLoaded(notifications, event.userId));
    } catch (e) {
      emit(NotificationsError('Failed to load notifications: ${e.toString()}'));
    }
  }

  Future<void> _onSaveNotification(SaveNotificationEvent event,
      Emitter<VfNotificationspageState> emit) async {
    /*
    try {
      // Save the notification to SharedPreferences/local storage
      await localStorageService
          .saveNotificationToPrefs(event.notification.toMap());

      // Log the notification saving success
      print('Notification saved: ${event.notification}');

      // After saving the notification, reload the notifications list
      add(LoadNotificationsEvent(event.userId));
    } catch (e) {
      // If there's an error, emit a relevant error state
      emit(NotificationsError('Failed to save notification: ${e.toString()}'));
    }*/
  }

  Future<void> _onMarkNotificationAsRead(MarkNotificationAsReadEvent event,
      Emitter<VfNotificationspageState> emit) async {
    await localStorageService.markAsRead(event.notificationId);
    add(LoadNotificationsEvent(
        state.userId)); // Refresh notifications after marking as read
  }

  Future<void> _onDeleteNotification(DeleteNotificationEvent event,
      Emitter<VfNotificationspageState> emit) async {
    // Logic to delete a single notification
    emit(NotificationsLoading());
    // You would implement a delete logic here if necessary
    add(LoadNotificationsEvent(
        state.userId)); // Refresh notifications after deletion
  }

  Future<void> _onDeleteAllNotifications(DeleteAllNotificationsEvent event,
      Emitter<VfNotificationspageState> emit) async {
    // Logic to delete all notifications
    //first clear the notifications from local storage
    await localStorageService.clearMessages();

    /*
    //then clear the notifications from the database
    Map<String, dynamic> notificationList = {
      for (var notification in state.notificationList)
        notification.id: notification.toMap()
    };

    await vfcurdService.deleteNotificationsList(notificationList);*/
    add(LoadNotificationsEvent(
        event.userId)); // Refresh notifications after clearing
  }
}
