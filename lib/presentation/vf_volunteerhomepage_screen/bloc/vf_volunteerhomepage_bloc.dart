import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'package:equatable/equatable.dart';
import '../models/vf_volunteerhomepage_model.dart';
part 'vf_volunteerhomepage_event.dart';
part 'vf_volunteerhomepage_state.dart';

// Your repository or service imports
// import 'repository/volunteer_repository.dart';

// Define the events that can be dispatched to the bloc
class VfVolunteerhomepageBloc
    extends Bloc<VfVolunteerhomepageEvent, VfVolunteerhomepageState> {
  // Provide a default initial state
  final VolufriendCrudService vfcrudService;
  VfVolunteerhomepageBloc({
    VfVolunteerhomepageState? initialState,
    required this.vfcrudService,
  }) : super(initialState ?? VfVolunteerhomepageState()) {
    on<VfVolunteerhomepageInitialEvent>(_onInitialize);
  }

  void _onInitialize(
    VfVolunteerhomepageInitialEvent event,
    Emitter<VfVolunteerhomepageState> emit,
  ) {
    // Initialization logic if needed
    print("I am inside _onInitialize of VfVolunteerhomepageBloc");
    emit(state.copyWith(
      eventId: '',
    ));
  }
}

class VolunteerBloc extends Bloc<VolunteerEvent, VolunteerState> {
  final VolufriendCrudService vfcrudService;

  VolunteerBloc(this.vfcrudService) : super(VolunteerInitial()) {
    on<LoadUpcomingEvents>(_onLoadUpcomingEvents);
  }

  Future<void> _onLoadUpcomingEvents(
    LoadUpcomingEvents event,
    Emitter<VolunteerState> emit,
  ) async {
    emit(VolunteerLoading());
    try {
      final events =
          await vfcrudService.getUpcomingEventsforVolunteer(event.volunteerId);
      emit(VolunteerLoaded(upcomingEvents: events));
    } catch (_) {
      emit(VolunteerError());
    }
  }
}

class InterestBloc extends Bloc<InterestEvent, InterestState> {
  final VolufriendCrudService vfcrudService;

  InterestBloc(this.vfcrudService) : super(InterestInitial()) {
    on<LoadInterestedEvents>(_onLoadInterestedEvents);
  }

  Future<void> _onLoadInterestedEvents(
    LoadInterestedEvents event,
    Emitter<InterestState> emit,
  ) async {
    emit(InterestLoading());
    try {
      final events = await vfcrudService.getUserInterestedEvents(event.userId);
      emit(InterestLoaded(interestedEvents: events));
    } catch (_) {
      emit(InterestError());
    }
  }
}
