part of 'vf_notificationspage_bloc.dart';

abstract class VfNotificationspageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNotificationsEvent extends VfNotificationspageEvent {
  final String userId;

  LoadNotificationsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class SaveNotificationEvent extends VfNotificationspageEvent {
  final NotificationModel notification;
  final String userId;

  SaveNotificationEvent(this.notification, this.userId);

  @override
  List<Object?> get props => [notification, userId];
}

class MarkNotificationAsReadEvent extends VfNotificationspageEvent {
  final String notificationId;

  MarkNotificationAsReadEvent(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}

class DeleteNotificationEvent extends VfNotificationspageEvent {
  final String notificationId;
  final String userId;

  DeleteNotificationEvent(this.notificationId, this.userId);

  @override
  List<Object?> get props => [notificationId, userId];
}

class DeleteAllNotificationsEvent extends VfNotificationspageEvent {
  final String userId;

  DeleteAllNotificationsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}
