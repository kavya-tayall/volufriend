import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../../../presentation/vf_myupcomingevents_screen/models/vf_myupcomingeventscreen_model.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';

part 'vf_myupcomingeventscreen_event.dart';
part 'vf_myupcomingeventscreen_state.dart';

class VfMyupcomingeventscreenBloc
    extends Bloc<VfMyupcomingeventscreenEvent, VfMyupcomingeventscreenState> {
  final VolufriendCrudService vfCrudService;

  VfMyupcomingeventscreenBloc({
    required VfMyupcomingeventscreenState initialState,
    required this.vfCrudService,
  }) : super(initialState) {
    on<LoadUpcomingEventsEvent>(_loadUpcomingEvents);
  }

  Future<void> _loadUpcomingEvents(
    LoadUpcomingEventsEvent event,
    Emitter<VfMyupcomingeventscreenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      // Fetch the upcoming events from the service
      final List<Voluevents> upcomingEvents =
          await vfCrudService.getmyupcomingevents(event.userId);

      if (upcomingEvents.isNotEmpty) {
        // Emit the loaded state with fetched events
        emit(state.copyWith(
          isLoading: false,
          vfMyupcomingeventscreenModelObj: state.vfMyupcomingeventscreenModelObj
                  ?.copyWith(orgEvent: upcomingEvents) ??
              VfMyupcomingeventscreenModel(orgEvent: upcomingEvents),
        ));
      } else {
        emit(state.copyWith(
          errorMessage: 'No upcoming events found.',
        ));
      }
    } catch (e) {
      // Emit error state in case of failure
      emit(state.copyWith(
        errorMessage: 'Failed to load events: ${e.toString()}',
      ));
    }
  }
}
