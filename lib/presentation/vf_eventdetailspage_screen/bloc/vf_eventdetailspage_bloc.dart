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
    on<SaveEventSignUp>(_saveEventSignUp);
    on<ToggleShiftSelectionEvent>(_toggleShiftSelection);
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

  Future<void> _saveEventSignUp(
    SaveEventSignUp event,
    Emitter<VfEventsdetailspageState> emit,
  ) async {
    try {
      // Prepare the JSON response
      emit(state.copyWith(successMessage: ''));
      final shifts = state.vfEventdetailsModelObj?.orgEvent?.shifts;
      final eventSignupBody = {
        'org_id': state.orgId,
        'user_id': state.userId,
        'event_id': state.eventId,
        'selected_shift_ids': shifts
                ?.asMap()
                .entries
                .where((entry) =>
                    state.selectedShifts[entry.key]) // Filter selected shifts
                .map((entry) => {
                      'shift_id': entry.value.shiftId
                    }) // Wrap shiftId in an object
                .toList() ??
            [],
      };

      // Print for debugging or log
      print('Preparing JSON response: $eventSignupBody');

      // Call repository to save the data
      final statusCode =
          await vfcrudService.saveEventSignUp(state.userId, eventSignupBody);

      // Only emit a success state if the status code is 200
      if (statusCode == 200) {
        emit(state.copyWith(
            successMessage: 'Event sign-up saved successfully.'));
      } else {
        // If the status is not 200, emit an error state
        print('Failed to save event sign-up. Status code: $statusCode');
      }
    } catch (error) {
      // Handle any errors and emit an error state
      print('Error saving event sign-up: $error');
      emit(state.copyWith(errorMessage: 'Failed to save event sign-up.'));
    }
  }

  Future<void> _onInitialize(
    VfEventdetailspageInitialEvent event,
    Emitter<VfEventsdetailspageState> emit,
  ) async {
    emit(state.copyWith(
      vfEventdetailsModelObj:
          state.vfEventdetailsModelObj?.copyWith(orgEvent: event.eventSelected),
    ));

    // Assuming you have access to the fetched shifts here
    List<Shift> shifts = state.vfEventdetailsModelObj?.orgEvent?.shifts ?? [];

    // Initialize the selectedShifts list based on the number of shifts
    emit(state.copyWith(
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
}
