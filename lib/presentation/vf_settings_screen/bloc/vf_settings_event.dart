part of 'vf_settings_bloc.dart';

abstract class VfSettingsScreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSettingsEvent extends VfSettingsScreenEvent {}

class ToggleNotificationEvent extends VfSettingsScreenEvent {
  final String notificationType;
  final bool isEnabled;

  ToggleNotificationEvent(this.notificationType, this.isEnabled);

  @override
  List<Object?> get props => [notificationType, isEnabled];
}
