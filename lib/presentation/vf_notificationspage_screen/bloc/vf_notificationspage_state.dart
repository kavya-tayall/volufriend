part of 'vf_notificationspage_bloc.dart';

/// Represents the state of VfNotificationspage in the application.
class VfNotificationspageState extends Equatable {
  VfNotificationspageState({
    this.notificationList = const [],
    this.userId = '',
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage = '',
  });

  final List<NotificationModel> notificationList;
  final String userId;
  final bool isLoading;
  final bool hasError;
  final String errorMessage;

  @override
  List<Object?> get props => [
        notificationList,
        userId,
        isLoading,
        hasError,
        errorMessage,
      ];

  VfNotificationspageState copyWith({
    List<NotificationModel>? notificationList,
    String? userId,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return VfNotificationspageState(
      notificationList: notificationList ?? this.notificationList,
      userId: userId ?? this.userId,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// Example states extending VfNotificationspageState
class NotificationsInitial extends VfNotificationspageState {}

class NotificationsLoading extends VfNotificationspageState {
  NotificationsLoading() : super(isLoading: true);
}

class NotificationsLoaded extends VfNotificationspageState {
  NotificationsLoaded(List<NotificationModel> notificationList, String userId)
      : super(notificationList: notificationList, userId: userId);
}

class NotificationsError extends VfNotificationspageState {
  NotificationsError(String errorMessage)
      : super(hasError: true, errorMessage: errorMessage);
}
