import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:volufriend/presentation/vf_createeventscreen2_eventshifts_screen/bloc/vf_createeventscreen2_eventshifts_bloc.dart';
import '../../../core/app_export.dart';
import '../models/vf_createeventscreen3_eventadditionaldetails_model.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';

part 'vf_createeventscreen3_eventadditionaldetails_event.dart';
part 'vf_createeventscreen3_eventadditionaldetails_state.dart';

/// A bloc that manages the state of a VfCreateeventscreen3Eventadditionaldetails according to the event that is dispatched to it.
class VfCreateeventscreen3EventadditionaldetailsBloc extends Bloc<
    VfCreateeventscreen3EventadditionaldetailsEvent,
    VfCreateeventscreen3EventadditionaldetailsState> {
  final VolufriendCrudService vfcrudService;
  VfCreateeventscreen3EventadditionaldetailsBloc({
    VfCreateeventscreen3EventadditionaldetailsState? initialState,
    required this.vfcrudService,
  }) : super(
            initialState ?? VfCreateeventscreen3EventadditionaldetailsState()) {
    on<VfCreateeventscreen3EventadditionaldetailsInitialEvent>(_onInitialize);
    on<ChangeCountryEvent>(_changeCountry);
    on<UploadFileEvent>(_uploadFile);
    on<SaveEventAdditionalDetailsEvent>(_onSaveEventAdditionalDetails);
    on<SaveEventShiftstoDbEvent>(_onSaveEventShiftstoDb);
    on<StartSaveInProgressEvent>(_onStartSaveInProgress);
    on<VfCreateeventscreen3EventadditionaldetailsResetInitializationEvent>(
        _resetInitialization);
  }

  void _resetInitialization(
    VfCreateeventscreen3EventadditionaldetailsResetInitializationEvent event,
    Emitter<VfCreateeventscreen3EventadditionaldetailsState> emit,
  ) {
    emit(VfCreateeventscreen3EventadditionaldetailsState());
  }

  void _onStartSaveInProgress(
    StartSaveInProgressEvent event,
    Emitter<VfCreateeventscreen3EventadditionaldetailsState> emit,
  ) {
    // Set isSaveInProgress to true
    emit(state.copyWith(isSaveInProgress: true));
  }

  void _onSaveEventAdditionalDetails(
    SaveEventAdditionalDetailsEvent event,
    Emitter<VfCreateeventscreen3EventadditionaldetailsState> emit,
  ) {
    // Prevent saving if a save is already in progress
    if (state.isSaveInProgress) return;

    // Dispatch the StartSaveInProgressEvent to indicate save is starting
    add(StartSaveInProgressEvent());

    emit(state.copyWith(isSaving: true, isSaved: false));

    final EventDescription = state.additionalDetailsTextAreaController.text;
    final coordinatorEmailInput = state.coordinatorEmailInputController.text;
    final coordinatorNameInput = state.coordinatorNameInputController.text;
    final coordinatorPhoneInput = state.coordinatorPhoneInputController.text;

    final Coordinator coordinator = Coordinator(
      name: coordinatorNameInput,
      email: coordinatorEmailInput,
      phone: coordinatorPhoneInput,
    );

    emit(state.copyWith(
      vfCreateeventscreen3EventadditionaldetailsModelObj:
          (state.vfCreateeventscreen3EventadditionaldetailsModelObj ??
                  VfCreateEventScreen3EventAdditionalDetailsModel(
                    description: '', // default value
                    coordinator: Coordinator(), // default empty object
                    eventId: '', // default value
                    eventAlbumId: '', // default value
                  ))
              .copyWith(
        description: EventDescription,
        coordinator: coordinator,
        eventId: state.eventId,
        eventAlbumId: state.eventAlbum?.albumId ?? '',
      ),
      isSaved: true,
      isSaving: false,
      isSavedtoDb: false,
      SaveDbIntent: event.saveIntentToDb,
      isSaveInProgress: false, // Reset after processing
    ));

    // emit(ReadytoSavetoDb());
  }

  Future<void> _onSaveEventShiftstoDb(
    SaveEventShiftstoDbEvent event,
    Emitter<VfCreateeventscreen3EventadditionaldetailsState> emit,
  ) async {
    try {
      // Indicate that saving is in progress
      emit(state.copyWith(isSaving: true, isSavedtoDb: false));

      if (event.orgEvent.eventId == null || event.orgEvent.eventId!.isEmpty) {
        // Generate a random event ID and save if it doesn't exist
        print("Creating event to the database");
        await vfcrudService.createEventDetailsWithShifts(
            event.orgEvent, event.imageUrls);
      } else {
        // Save the event if the ID already exists
        print("Saving event to the database");
        await vfcrudService.saveEventDetailsWithShifts(
            event.orgEvent, event.imageUrls);
      }

      // If successful, update the state
      emit(state.copyWith(
        isSavedtoDb: true,
        isSaving: false,
        isSaved: true,
        isSaveInProgress: false, // Reset after successful save
      ));
    } catch (error) {
      print("Failed to save event: $error");
      // In case of an error, update the state to reflect failure
      emit(state.copyWith(
        isSaving: false,
        isSavedtoDb: false,
        errorMessage: 'Failed to save event. Please try again.',
        isSaveInProgress: false, // Reset on failure
      ));
    }
  }

  _changeCountry(
    ChangeCountryEvent event,
    Emitter<VfCreateeventscreen3EventadditionaldetailsState> emit,
  ) {
    emit(state.copyWith(
      selectedCountry: event.value,
    ));
  }

  Future<void> _fetchEventAdditionalDetails(
      FetchEventAdditionalDetailsEvent event,
      Emitter<VfCreateeventscreen3EventadditionaldetailsState> emit) async {
    try {
      if (event.orgEvent.eventId != null &&
          event.orgEvent.eventId!.isNotEmpty) {
        /*emit(state.copyWith(
          vfCreateeventscreen3EventadditionaldetailsModelObj: state
              .vfCreateeventscreen3EventadditionaldetailsModelObj
              ?.copyWith(
            description: event.orgEvent.description,
            coordinator: event.orgEvent.coordinator,
            eventId: event.orgEvent.eventId,
          ),
        ));*/

        emit(state.copyWith(
          vfCreateeventscreen3EventadditionaldetailsModelObj:
              (state.vfCreateeventscreen3EventadditionaldetailsModelObj ??
                      VfCreateEventScreen3EventAdditionalDetailsModel(
                        description: '', // default value for description
                        coordinator:
                            null, // default value for coordinator (can be null)
                        eventId: '', // default value for eventId
                      ))
                  .copyWith(
            description:
                event.orgEvent.description ?? '', // ensure non-null value
            coordinator:
                event.orgEvent.coordinator, // nullable coordinator is fine
            eventId: event.orgEvent.eventId ?? '', // ensure non-null value
          ),
        ));
      }
    } catch (error) {
      emit(state.copyWith(errorMessage: 'Failed to fetch shift details.'));
    }
  }

  _onInitialize(
    VfCreateeventscreen3EventadditionaldetailsInitialEvent event,
    Emitter<VfCreateeventscreen3EventadditionaldetailsState> emit,
  ) async {
    try {
      // Check if the screen is being initialized for the first time
      print("i am here at _onInitialize of VfCreateeventscreen3 Bloc");
      print(state.isInitialized);
      // print(event.orgEvent);
      if (!state.isInitialized) {
        // Load dropdown and multi-select data first
        await Future.wait([
          if (event.orgEvent != null)
            _fetchEventAdditionalDetails(
              FetchEventAdditionalDetailsEvent(orgEvent: event.orgEvent!),
              emit,
            ),
        ]);

        print(
            'state.add dtails ${state.vfCreateeventscreen3EventadditionaldetailsModelObj}');

        if (event.orgEvent != null) {
          final orgEvent = event.orgEvent;
          emit(state.copyWith(
              isInitialized: true,
              additionalDetailsTextAreaController:
                  _createController(orgEvent?.description),
              nofilechosenvalController: _createController(),
              coordinatorNameInputController:
                  _createController(orgEvent?.coordinator?.name),
              coordinatorEmailInputController:
                  _createController(orgEvent?.coordinator?.email),
              coordinatorPhoneInputController:
                  _createController(orgEvent?.coordinator?.phone),
              isSaved: false,
              isLoading: false,
              isSavedtoDb: false // Stop loading state
              ));
        } else {
          emit(state.copyWith(
            isInitialized: true,
            isSavedtoDb: false,
            additionalDetailsTextAreaController: _createController(),
            nofilechosenvalController: _createController(),
            coordinatorNameInputController: _createController(),
            coordinatorEmailInputController: _createController(),
            coordinatorPhoneInputController: _createController(),
          ));
        }
      } else {}
    } catch (error) {
      emit(state.copyWith(errorMessage: 'Failed to initialize event shifts.'));
    }
  }
}

TextEditingController _createController([String? text]) {
  return TextEditingController(text: text);
}

void _updateAdditionalDetails(
  UpdateAdditionalDetailsEvent event,
  Emitter<VfCreateeventscreen3EventadditionaldetailsState> emit,
  VfCreateeventscreen3EventadditionaldetailsState state,
) {
  // Logic to update the additional details
  emit(state.copyWith(
    additionalDetailsTextAreaController:
        TextEditingController(text: event.additionalDetails),
  ));
}

_uploadFile(
  UploadFileEvent event,
  Emitter<VfCreateeventscreen3EventadditionaldetailsState> emit,
) {
  // Logic to handle file upload
}
