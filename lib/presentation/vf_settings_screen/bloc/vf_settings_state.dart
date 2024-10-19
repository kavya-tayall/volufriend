part of 'vf_settings_bloc.dart';

class VfSettingsScreenState extends Equatable {
  final bool sendNotificationOnNewEvents;
  final bool sendReminderPriorToEvents;

  const VfSettingsScreenState({
    this.sendNotificationOnNewEvents = false,
    this.sendReminderPriorToEvents = false,
  });

  @override
  List<Object?> get props => [
        sendNotificationOnNewEvents,
        sendReminderPriorToEvents,
      ];

  VfSettingsScreenState copyWith({
    bool? sendNotificationOnNewEvents,
    bool? sendReminderPriorToEvents,
  }) {
    return VfSettingsScreenState(
      sendNotificationOnNewEvents:
          sendNotificationOnNewEvents ?? this.sendNotificationOnNewEvents,
      sendReminderPriorToEvents:
          sendReminderPriorToEvents ?? this.sendReminderPriorToEvents,
    );
  }
}
