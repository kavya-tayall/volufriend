import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/vf_createeventscreen2_eventshifts_model.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';

part 'vf_createeventscreen2_eventshifts_event.dart';
part 'vf_createeventscreen2_eventshifts_state.dart';

/// A bloc that manages the state of VfCreateeventscreen2Eventshifts according to the events that are dispatched to it.
class VfCreateeventscreen2EventshiftsBloc extends Bloc<
    VfCreateeventscreen2EventshiftsEvent,
    VfCreateeventscreen2EventshiftsState> {
  final VolufriendCrudService vfcrudService;
  VfCreateeventscreen2EventshiftsBloc({
    VfCreateeventscreen2EventshiftsState? initialState,
    required this.vfcrudService,
  }) : super(initialState ?? VfCreateeventscreen2EventshiftsState()) {
    on<VfCreateeventscreen2EventshiftsInitialEvent>(_onInitialize);
    on<SaveShiftDetailsEvent>(_onSaveShiftDetails);
    on<UpdateShift1StartTimeEvent>(_onUpdateShift1StartTime);
    on<UpdateShift1EndTimeEvent>(_onUpdateShift1EndTime);
    on<UpdateShift2StartTimeEvent>(_onUpdateShift2StartTime);
    on<UpdateShift2EndTimeEvent>(_onUpdateShift2EndTime);
    on<UpdateShift1MaxParticipantsEvent>(_onUpdateShift1MaxParticipants);
    on<VfCreateeventscreen2ShiftsResetInitializationEvent>(
        _resetInitialization);
  }

  void _onInitialize(
    VfCreateeventscreen2EventshiftsInitialEvent event,
    Emitter<VfCreateeventscreen2EventshiftsState> emit,
  ) async {
    try {
      // Check if the screen is being initialized for the first time
      print(
          "i am here at _onInitialize of VfCreateeventscreen2EventshiftsBloc");
      print(state.isInitialized);
      // print(event.orgEvent);
      if (!state.isInitialized) {
        // Load dropdown and multi-select data first
        await Future.wait([
          if (event.orgEvent != null)
            _fetchShiftDetails(
                FetchShiftDetailsEvent(orgEvent: event.orgEvent!), emit),
        ]);

        //  print('state.shift ${state.vfCreateeventscreen2EventshiftsModelObj}');

        if (event.orgEvent != null) {
          final orgEventShift = event.orgEvent!.shifts;
          emit(state.copyWith(
            isInitialized: true,
            eventId: event.orgEvent!.eventId,
            shift1ActivityInputController:
                _createController(orgEventShift[0].activity),
            shift1StartTimeController: _createController(
                orgEventShift[0].startTime?.toIso8601String()),
            shift1EndTimeController:
                _createController(orgEventShift[0].endTime?.toIso8601String()),
            shift1MaxParticipantsController: _createController(
                orgEventShift[0].maxNumberOfParticipants?.toString()),
            shift1MinimumAgeController:
                _createController(orgEventShift[0].minAge?.toString()),
            shift2ActivityInputController:
                _createController(orgEventShift[1].activity),
            shift2StartTimeController: _createController(
                orgEventShift[1].startTime?.toIso8601String()),
            shift2EndTimeController:
                _createController(orgEventShift[1].endTime?.toIso8601String()),
            shift2MaxParticipantsController: _createController(
                orgEventShift[1].maxNumberOfParticipants?.toString()),
            shift2MinimumAgeController:
                _createController(orgEventShift[1].minAge?.toString()),
            isSaved: false,
            isLoading: false, // Stop loading state
          ));
        } else {
          emit(state.copyWith(
            isInitialized: true,
            shift1ActivityInputController: _createController(),
            shift1StartTimeController: _createController(),
            shift1EndTimeController: _createController(),
            shift1MaxParticipantsController: _createController(),
            shift1MinimumAgeController: _createController(),
            shift2ActivityInputController: _createController(),
            shift2StartTimeController: _createController(),
            shift2EndTimeController: _createController(),
            shift2MaxParticipantsController: _createController(),
            shift2MinimumAgeController: _createController(),
          ));
        }
      } else {
        // Handle the case when the user is returning to the screen
      }
    } catch (error) {
      emit(state.copyWith(errorMessage: 'Failed to initialize event shifts.'));
    }
  }

  TextEditingController _createController([String? text]) {
    return TextEditingController(text: text);
  }

  Future<void> _fetchShiftDetails(
    FetchShiftDetailsEvent event,
    Emitter<VfCreateeventscreen2EventshiftsState> emit,
  ) async {
    try {
      if (event.orgEvent.eventId != null &&
          event.orgEvent.eventId!.isNotEmpty) {
        // print('inside _fetchShiftDetails ${event.orgEvent.shifts}');
        /*   emit(state.copyWith(
          vfCreateeventscreen2EventshiftsModelObj:
              state.vfCreateeventscreen2EventshiftsModelObj?.copyWith(
                  eventShifts: event.orgEvent.shifts,
                  eventId: event.orgEvent.eventId),
        ));*/

        emit(state.copyWith(
          vfCreateeventscreen2EventshiftsModelObj:
              (state.vfCreateeventscreen2EventshiftsModelObj ??
                      VfCreateeventscreen2EventshiftsModel(
                        eventShifts: [], // default value
                        eventId: '', // default value
                      ))
                  .copyWith(
            eventShifts: event.orgEvent.shifts,
            eventId: event.orgEvent.eventId,
          ),
        ));
      }
    } catch (error) {
      emit(state.copyWith(errorMessage: 'Failed to fetch shift details.'));
    }
  }

  Future<Voluevents> fetchShiftDetailsFromRepo(
      FetchShiftDetailsEvent event) async {
    // Implement this function to fetch data from your repository
    // Example: return await repository.fetchShiftDetails(event.eventId);
    throw UnimplementedError(); // Placeholder
  }

  /* @override
  Future<void> close() {
    // Dispose of the TextEditingController to prevent memory leaks
    state.shift1ActivityInputController?.dispose();
    state.shift1StartTimeController?.dispose();
    state.shift1EndTimeController?.dispose();
    state.shift1MaxParticipantsController?.dispose();
    state.shift1MinimumAgeController?.dispose();
    state.shift2ActivityInputController?.dispose();
    state.shift2StartTimeController?.dispose();
    state.shift2EndTimeController?.dispose();
    state.shift2MaxParticipantsController?.dispose();
    state.shift2MinimumAgeController?.dispose();

    return super.close();
  }*/

  void _onSaveShiftDetails(
    SaveShiftDetailsEvent event,
    Emitter<VfCreateeventscreen2EventshiftsState> emit,
  ) {
    // Access the current state directly to get the TextEditingController values
    final List<Shift> eventShifts; // Get the event shifts from the state
    emit(state.copyWith(
      isSaving: true, // Mark as saving
    ));

    final eventId = state.eventId;
    final shift1Activity = state.shift1ActivityInputController?.text ?? '';
    final shift1StartTime = state.shift1StartTimeController?.text ?? '';
    final shift1EndTime = state.shift1EndTimeController?.text ?? '';
    final shift1MaxParticipants =
        state.shift1MaxParticipantsController?.text ?? '';
    final shift1MinimumAge = state.shift1MinimumAgeController?.text ?? '';
    final shift2Activity = state.shift2ActivityInputController?.text ?? '';
    final shift2StartTime = state.shift2StartTimeController?.text ?? '';
    final shift2EndTime = state.shift2EndTimeController?.text ?? '';
    final shift2MaxParticipants =
        state.shift2MaxParticipantsController?.text ?? '';
    final shift2MinimumAge = state.shift2MinimumAgeController?.text ?? '';

    eventShifts = [
      Shift(
        shiftId: state.vfCreateeventscreen2EventshiftsModelObj?.eventShifts[0]
                .shiftId ??
            '',
        activity: shift1Activity,
        startTime: DateTime.tryParse(shift1StartTime) ?? DateTime.now(),
        endTime: DateTime.tryParse(shift1EndTime) ?? DateTime.now(),
        maxNumberOfParticipants: int.tryParse(shift1MaxParticipants) ?? 0,
        minAge: int.tryParse(shift1MinimumAge) ?? 0,
        eventId: state.eventId ?? '',
        numberOfParticipants: state.vfCreateeventscreen2EventshiftsModelObj
                ?.eventShifts[0].numberOfParticipants ??
            0,
      ),
      Shift(
        shiftId: state.vfCreateeventscreen2EventshiftsModelObj?.eventShifts[1]
                .shiftId ??
            '',
        activity: shift2Activity,
        startTime: DateTime.tryParse(shift2StartTime) ?? DateTime.now(),
        endTime: DateTime.tryParse(shift2EndTime) ?? DateTime.now(),
        maxNumberOfParticipants: int.tryParse(shift2MaxParticipants) ?? 0,
        minAge: int.tryParse(shift2MinimumAge) ?? 0,
        eventId: state.eventId ?? '',
        numberOfParticipants: state.vfCreateeventscreen2EventshiftsModelObj
                ?.eventShifts[1].numberOfParticipants ??
            0,
      ),
    ];
    print('eventShifts $eventShifts');
    emit(state.copyWith(
      vfCreateeventscreen2EventshiftsModelObj:
          (state.vfCreateeventscreen2EventshiftsModelObj ??
                  VfCreateeventscreen2EventshiftsModel(
                    eventShifts: [], // default empty list
                    eventId: '', // default value
                  ))
              .copyWith(
        eventShifts: eventShifts,
      ),
      eventId: eventId,
    ));

    // Update the state with the new values

    // After saving, update the state to reflect that changes are saved
    emit(state.copyWith(
      isSaved: true,
      isSaving: false, // Mark as not saving
    ));
  }

  void _onUpdateShift1StartTime(
    UpdateShift1StartTimeEvent event,
    Emitter<VfCreateeventscreen2EventshiftsState> emit,
  ) {
    emit(state.copyWith(
      shift1StartTimeController: _createController(event.starttime),
    ));
  }

  void _onUpdateShift1EndTime(
    UpdateShift1EndTimeEvent event,
    Emitter<VfCreateeventscreen2EventshiftsState> emit,
  ) {
    emit(state.copyWith(
      shift1EndTimeController: _createController(event.endtime),
    ));
  }

  void _onUpdateShift2StartTime(
    UpdateShift2StartTimeEvent event,
    Emitter<VfCreateeventscreen2EventshiftsState> emit,
  ) {
    emit(state.copyWith(
      shift2StartTimeController: _createController(event.starttime),
    ));
  }

  void _onUpdateShift2EndTime(
    UpdateShift2EndTimeEvent event,
    Emitter<VfCreateeventscreen2EventshiftsState> emit,
  ) {
    emit(state.copyWith(
      shift2EndTimeController: _createController(event.endtime),
    ));
  }

  void _onUpdateShift1MaxParticipants(
    UpdateShift1MaxParticipantsEvent event,
    Emitter<VfCreateeventscreen2EventshiftsState> emit,
  ) {
    emit(state.copyWith(
      shift1MaxParticipantsController:
          _createController(event.maxParticipants.toString()),
    ));
  }

  void _resetInitialization(
    VfCreateeventscreen2ShiftsResetInitializationEvent event,
    Emitter<VfCreateeventscreen2EventshiftsState> emit,
  ) {
    emit(VfCreateeventscreen2EventshiftsState());
  }
}
