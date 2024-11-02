import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/vf_eventdetailspage_model.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';

part 'vf_eventdetailspage_event.dart';
part 'vf_eventdetailspage_state.dart';

/// A bloc that manages the state of a VfEventsignupscreen according to the events dispatched to it.
class VfEventsdetailspageBloc
    extends Bloc<VfEventsdetailspageEvent, VfEventsdetailspageState> {
  final VolufriendCrudService vfcrudService;

  VfEventsdetailspageBloc({
    required VfEventsdetailspageState initialState,
    required this.vfcrudService,
  }) : super(initialState) {
    on<VfEventdetailspageInitialEvent>(_onInitialize);
    on<ToggleContactInfoEvent>(_toggleContactInfo);
    on<ToggleShiftSelectionEvent>(_toggleShiftSelection);
    on<CancelSingleEventEvent>(_onCancelEventFromListEvent);
    on<resetEventDetailPage>(_resetEventDetailPage);
  }

  void _resetEventDetailPage(
    resetEventDetailPage event,
    Emitter<VfEventsdetailspageState> emit,
  ) {
    print('ResetEvent received');
    emit(VfEventsdetailspageState.initial); // Emit the initial state directly
    print('State reset to initial');
  }

  void _toggleShiftSelection(
    ToggleShiftSelectionEvent event,
    Emitter<VfEventsdetailspageState> emit,
  ) {
    // Update the selected state for the specific index
    final updatedSelectedShifts = List<bool>.from(state.selectedShifts)
      ..[event.index] = event.isSelected;

    // Optionally, store the selected shiftId based on isSelected
    List<String> selectedShiftIds = List.from(state.selectedShiftIds);

    if (event.isSelected) {
      // Add shiftId to the list of selected shift IDs
      selectedShiftIds.add(event.shiftId);
    } else {
      // Remove shiftId if unselected
      selectedShiftIds.remove(event.shiftId);
    }

    // Emit the new state with updated selected shifts and selectedShiftIds
    emit(state.copyWith(
      selectedShifts: updatedSelectedShifts,
      selectedShiftIds: selectedShiftIds,
    ));
  }

  Future<void> _onInitialize(
    VfEventdetailspageInitialEvent event,
    Emitter<VfEventsdetailspageState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
      cancelsucess: false,
      vfEventdetailsModelObj:
          state.vfEventdetailsModelObj?.copyWith(orgEvent: event.eventSelected),
    ));

    print('Event ID in bloc: ${event.eventSelected.eventId}');
    // Assuming you have access to the fetched shifts here
    List<Shift> shifts = state.vfEventdetailsModelObj?.orgEvent?.shifts ?? [];
    print('In the event detail page bloc');
    // Initialize the selectedShifts list based on the number of shifts
    emit(state.copyWith(
      isLoading: false, cancelsucess: false,
      // Add orgId, userId, and eventId to the state
      selectedShifts: List<bool>.filled(shifts.length, false), // Initialize
    ));
  }

  void _toggleContactInfo(
    ToggleContactInfoEvent event,
    Emitter<VfEventsdetailspageState> emit,
  ) {
    // Assuming the state has a property 'showContactInfo' to manage visibility
    final currentState = state.showContactInfo;
    emit(state.copyWith(
      showContactInfo: !currentState,
    ));
  }

  _onCancelEventFromListEvent(
    CancelSingleEventEvent event,
    Emitter<VfEventsdetailspageState> emit,
  ) async {
    emit(state.copyWith(isLoading: true)); // Start loading state

    try {
      // Load upcoming event list data
      final Voluevents updatedEventFromDb = await vfcrudService.cancelEvent(
          eventId: event.eventId, notifyParticipants: event.notifyParticipants);

      emit(state.copyWith(
        cancelsucess: true,
        successMessage:
            'Event ${updatedEventFromDb.title} canceled successfully.',
        isLoading: false,
        vfEventdetailsModelObj: state.vfEventdetailsModelObj
            ?.copyWith(orgEvent: updatedEventFromDb),
      ));
    } catch (error) {
      // Handle errors and update state with error message
      print('Error canceling event: $error');
      emit(state.copyWith(
        isLoading: false,
        cancelsucess: false,
        errorMessage: 'Failed to cancel event: $error',
      ));
    } finally {
      emit(state.copyWith(isLoading: false)); // Stop loading state
    }
  }
}
