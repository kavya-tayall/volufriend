import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/listtitlesmall_item_model.dart';
import '../models/vf_eventsignupscreen_model.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';

part 'vf_eventsignupscreen_event.dart';
part 'vf_eventsignupscreen_state.dart';

/// A bloc that manages the state of a VfEventsignupscreen according to the events dispatched to it.
class VfEventsignupscreenBloc
    extends Bloc<VfEventsignupscreenEvent, VfEventsignupscreenState> {
  final VolufriendCrudService vfcrudService;

  VfEventsignupscreenBloc({
    required VfEventsignupscreenState initialState,
    required this.vfcrudService,
  }) : super(initialState) {
    on<VfEventsignupscreenInitialEvent>(_onInitialize);
    on<FetchEventDetails>(_fetchEventDetails);
    on<ToggleContactInfoEvent>(_toggleContactInfo);
    on<SaveEventSignUp>(_saveEventSignUp);
    on<ToggleShiftSelectionEvent>(_toggleShiftSelection);
  }

  void _toggleShiftSelection(
    ToggleShiftSelectionEvent event,
    Emitter<VfEventsignupscreenState> emit,
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
    Emitter<VfEventsignupscreenState> emit,
  ) async {
    try {
      // Prepare the JSON response
      emit(state.copyWith(successMessage: ''));
      final shifts = state.vfEventsignupscreenModelObj?.orgEvent?.shifts;
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
    VfEventsignupscreenInitialEvent event,
    Emitter<VfEventsignupscreenState> emit,
  ) async {
    print('Initializing state with fetching event data');

    await Future.wait([
      _fetchEventDetails(FetchEventDetails(event.eventId), emit),
    ]);

    print('fetch data complete');

    // Assuming you have access to the fetched shifts here
    List<Shift> shifts =
        state.vfEventsignupscreenModelObj?.orgEvent?.shifts ?? [];

    // Initialize the selectedShifts list based on the number of shifts
    emit(state.copyWith(
      vfEventsignupscreenModelObj: state.vfEventsignupscreenModelObj?.copyWith(
        listtitlesmallItemList: fillListtitlesmallItemList(),
      ),
      orgId: event.orgId,
      userId: event.userId,
      eventId: event.eventId, // Add orgId, userId, and eventId to the state
      selectedShifts: List<bool>.filled(shifts.length, false), // Initialize
    ));
  }

  List<ListtitlesmallItemModel> fillListtitlesmallItemList() {
    return [
      ListtitlesmallItemModel(
        titlesmall: "Tuesday, Sep 17 2024",
        time: "03:00 PM",
        titlesmallOne: "-",
        timeOne: "05:30 PM",
      ),
      ListtitlesmallItemModel(), // Add any additional items if necessary
    ];
  }

  Future<void> _fetchEventDetails(
    FetchEventDetails event,
    Emitter<VfEventsignupscreenState> emit,
  ) async {
    try {
      final orgEvent =
          await vfcrudService.getEventDetailsWithShifts(event.eventId);
      if (orgEvent != null) {
        emit(state.copyWith(
          vfEventsignupscreenModelObj:
              state.vfEventsignupscreenModelObj?.copyWith(orgEvent: orgEvent),
        ));
      } else {
        emit(state.copyWith(errorMessage: 'Event details not found.'));
      }
    } catch (error) {
      emit(state.copyWith(errorMessage: 'Failed to fetch event details.'));
    }
  }

  void _toggleContactInfo(
    ToggleContactInfoEvent event,
    Emitter<VfEventsignupscreenState> emit,
  ) {
    // Assuming the state has a property 'showContactInfo' to manage visibility
    final currentState = state.showContactInfo;
    emit(state.copyWith(
      showContactInfo: !currentState,
    ));
  }
}
