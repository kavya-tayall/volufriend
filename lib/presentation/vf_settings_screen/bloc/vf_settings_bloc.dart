import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vf_settings_event.dart';
part 'vf_settings_state.dart';

class VfSettingsBloc
    extends Bloc<VfSettingsScreenEvent, VfSettingsScreenState> {
  VfSettingsBloc() : super(const VfSettingsScreenState()) {
    on<LoadSettingsEvent>(_onLoadSettings);
    on<ToggleNotificationEvent>(_onToggleNotification);
  }

  void _onLoadSettings(
      LoadSettingsEvent event, Emitter<VfSettingsScreenState> emit) {
    // Load initial settings, possibly from a local storage or API
    emit(state);
  }

  void _onToggleNotification(
      ToggleNotificationEvent event, Emitter<VfSettingsScreenState> emit) {
    if (event.notificationType == 'newEvents') {
      emit(state.copyWith(sendNotificationOnNewEvents: event.isEnabled));
    } else if (event.notificationType == 'eventReminders') {
      emit(state.copyWith(sendReminderPriorToEvents: event.isEnabled));
    }
  }
}
