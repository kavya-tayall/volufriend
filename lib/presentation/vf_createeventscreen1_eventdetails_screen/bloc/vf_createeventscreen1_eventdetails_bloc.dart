import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import '../../../core/app_export.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../models/vf_createeventscreen1_eventdetails_model.dart';
import 'package:intl/intl.dart';

part 'vf_createeventscreen1_eventdetails_event.dart';
part 'vf_createeventscreen1_eventdetails_state.dart';

/// A BLoC that manages the state of `VfCreateeventscreen1Eventdetails` according to the event that is dispatched to it.
class VfCreateeventscreen1EventdetailsBloc extends Bloc<
    VfCreateeventscreen1EventdetailsEvent,
    VfCreateeventscreen1EventdetailsState> {
  final VolufriendCrudService vfcrudService;

  // Constructor with optional initial state
  VfCreateeventscreen1EventdetailsBloc({
    VfCreateeventscreen1EventdetailsState? initialState,
    required this.vfcrudService,
  }) : super(initialState ??
            VfCreateeventscreen1EventdetailsState(
              vfCreateeventscreen1EventdetailsModelObj:
                  VfCreateeventscreen1EventdetailsModel(),
            )) {
    on<VfCreateeventscreen1EventdetailsInitialEvent>(_onInitialize);
    on<LoadCausesDropdownDataEvent>(_onCausesLoadDropdownDataEvent);
    on<LoadEventHostingOptionsEvent>(_populateEventHostingOptions);
    on<UpdateCausesDropDownSelectionEvent>(_updateCausesDropDownSelection);
    on<UpdateEventHostingOptionsEvent>(_updateEventHostingOptions);
    on<ChangeEventDateEvent>(_changeDate);
    on<ChangeEventRegistrationByDateEvent>(_changeRegDeadline);
    on<FetchEventDetails>(_fetchEventDetails);
    on<SaveEventDetailsEvent>(_saveEventDetails);
    on<VfCreateeventscreen1EventdetailsResetInitializationEvent>(
        _resetInitialization);
  }

  void _saveEventDetails(
    SaveEventDetailsEvent event,
    Emitter<VfCreateeventscreen1EventdetailsState> emit,
  ) {
    emit(state.copyWith(isSaved: false, isSaving: true)); // Start saving state

    Voluevents? currentEvent =
        state.vfCreateeventscreen1EventdetailsModelObj?.orgEvent;
    Voluevents updatedOrgEvent = Voluevents(
      eventId: state.eventId ?? '',
      title: state.titleInputController?.text.isNotEmpty == true
          ? state.titleInputController?.text
          : currentEvent?.title,
      address: state.venueInputController?.text.isNotEmpty == true
          ? state.venueInputController?.text
          : currentEvent?.address,
      startDate: state.selectedEventDateInput ?? currentEvent?.startDate,
      regByDate: state.selectedregdeadline ?? currentEvent?.regByDate,
      causeId: state.selectedCausesDropDownValue?.id ?? currentEvent?.causeId,
      EventHostingType:
          state.selectedEventHostingOptionDropDownValue?.isNotEmpty == true
              ? state.selectedEventHostingOptionDropDownValue
                  ?.map((EventHostingType) => EventHostingType.option)
                  .whereType<String>()
                  .toList()
              : currentEvent?.EventHostingType,
      shifts: currentEvent?.shifts,
      coordinator: currentEvent?.coordinator,
      description: currentEvent?.description,
      additionalDetails: currentEvent?.additionalDetails,
      orgId: state.orgId ?? currentEvent?.orgId,
      eventStatus: currentEvent?.eventStatus,
      eventWebsite: currentEvent?.eventWebsite,
      eventAlbum: currentEvent?.eventAlbum,
      location: currentEvent?.location,
      orgUserId: state.useridinorg ?? currentEvent?.orgUserId,
      parentOrg: state.parentOrg ?? currentEvent?.parentOrg,
      orgName: state.orgName ?? currentEvent?.orgName,
      // Add other fields as needed, using the same conditional assignment
    );
    emit(state.copyWith(
        vfCreateeventscreen1EventdetailsModelObj: state
            .vfCreateeventscreen1EventdetailsModelObj
            ?.copyWith(orgEvent: updatedOrgEvent),
        isSaved: true,
        isSaving: false)); // Stop saving state

    print('Event details saved: $updatedOrgEvent');
  }

  Future<void> _fetchEventDetails(
    FetchEventDetails event,
    Emitter<VfCreateeventscreen1EventdetailsState> emit,
  ) async {
    try {
      final orgEvent =
          await vfcrudService.getEventDetailsWithShifts(event.eventId);
      if (orgEvent != null) {
        emit(state.copyWith(
            vfCreateeventscreen1EventdetailsModelObj: state
                .vfCreateeventscreen1EventdetailsModelObj
                ?.copyWith(orgEvent: orgEvent)));
      } else {
        emit(state.copyWith(errorMessage: 'Event details not found.'));
      }
    } catch (error) {
      emit(state.copyWith(errorMessage: 'Failed to fetch event details.'));
    }
  }

  Future<void> _onInitialize(
    VfCreateeventscreen1EventdetailsInitialEvent event,
    Emitter<VfCreateeventscreen1EventdetailsState> emit,
  ) async {
    print('Handling VfCreateeventscreen1EventdetailsInitialEvent');
    print('Event ID: ${event.eventId}');
    print('parentOrg: ${event.parentOrg}');

    print(state.isInitialized);
    if (!state.isInitialized) {
      emit(state.copyWith(isLoading: true)); // Start loading state

      try {
        // Load dropdown and multi-select data first
        await Future.wait([
          _onCausesLoadDropdownDataEvent(LoadCausesDropdownDataEvent(), emit),
          _populateEventHostingOptions(LoadEventHostingOptionsEvent(), emit),
          if (event.eventId != null &&
              event.eventId!.isNotEmpty &&
              event.eventId != '')
            _fetchEventDetails(FetchEventDetails(event.eventId!), emit),
        ]);

        emit(state.copyWith(
          useridinorg: event.useridinorg,
          formContext: event.formContext,
          orgId: event.orgId,
          parentOrg: event.parentOrg,
          orgName: event.orgName,
        ));

        if (event.eventId != null) {
          final orgEvent =
              state.vfCreateeventscreen1EventdetailsModelObj?.orgEvent;
          final titleInputController =
              TextEditingController(text: orgEvent?.title ?? '');
          final venueInputController =
              TextEditingController(text: orgEvent?.address ?? '');
          final eventDateInputController = TextEditingController(
            text: orgEvent?.startDate != null
                ? DateFormat('MM/dd/yyyy').format(orgEvent!.startDate!)
                : '',
          );
          final registrationDeadlineInputController = TextEditingController(
            text: orgEvent?.regByDate != null
                ? DateFormat('MM/dd/yyyy').format(orgEvent!.regByDate!)
                : '',
          );
          print('registraion deadline: ' +
              registrationDeadlineInputController.text);

          // Convert Causes to SelectionPopupModel
          SelectionPopupModel convertCauseToSelectionPopupModel(causes cause) {
            return SelectionPopupModel(
              id: cause.id,
              title: cause.name ?? '',
              value: cause,
            );
          }

          // Set pre-selected dropdown values for the cause
          final selectedDropDownValueforCause = state
              .vfCreateeventscreen1EventdetailsModelObj?.causesList
              .map((cause) => convertCauseToSelectionPopupModel(cause))
              .firstWhere(
                (model) => model.id == orgEvent?.causeId,
                orElse: () => SelectionPopupModel(id: '', title: '', value: ''),
              );

          // Set pre-selected multi-select values for event hosting options
          final selectedMultiSelectValuesforEventHostingOptions = state
                  .vfCreateeventscreen1EventdetailsModelObj?.eventhostingoptions
                  .where((eventHostingOption) =>
                      orgEvent?.EventHostingType
                          ?.contains(eventHostingOption.option) ??
                      false)
                  .toList() ??
              [];

          // Emit updated state with controllers and dropdown selections
          emit(state.copyWith(
            eventId: event.eventId,
            orgId: orgEvent?.orgId,
            useridinorg: event.useridinorg,
            parentOrg: event.parentOrg,
            orgName: event.orgName,
            isInitialized: true,
            titleInputController: titleInputController,
            venueInputController: venueInputController,
            eventDateInputController: eventDateInputController,
            registrationDeadlineInputController:
                registrationDeadlineInputController,
            selectedCausesDropDownValue: selectedDropDownValueforCause,
            selectedEventHostingOptionDropDownValue:
                selectedMultiSelectValuesforEventHostingOptions,
            isSaved: false,
            isLoading: false, // Stop loading state
          ));
        } else {
          // No eventId provided, emit default values
          emit(state.copyWith(
            useridinorg: event.useridinorg,
            formContext: event.formContext,
            orgId: event.orgId,
            parentOrg: event.parentOrg,
            orgName: event.orgName,
            isInitialized: true,
            titleInputController:
                state.titleInputController ?? TextEditingController(),
            venueInputController:
                state.venueInputController ?? TextEditingController(),
            eventDateInputController:
                state.eventDateInputController ?? TextEditingController(),
            minimumAgeInputController:
                state.minimumAgeInputController ?? TextEditingController(),
            registrationDeadlineInputController:
                state.registrationDeadlineInputController ??
                    TextEditingController(),
            isLoading: false,
            isSaved: false,
            isSaving: false,
          ));
        }
      } catch (error) {
        emit(state.copyWith(errorMessage: 'Failed to initialize event data.'));
      }
    } else {
      emit(state.copyWith(
        useridinorg: event.useridinorg,
        formContext: event.formContext,
        orgId: event.orgId,
        parentOrg: event.parentOrg,
        orgName: event.orgName,
        isInitialized: true,
        titleInputController: state.titleInputController,
        venueInputController: state.venueInputController,
        eventDateInputController: state.eventDateInputController,
        registrationDeadlineInputController:
            state.registrationDeadlineInputController,
        selectedCausesDropDownValue: state.selectedCausesDropDownValue,
        selectedEventHostingOptionDropDownValue:
            state.selectedEventHostingOptionDropDownValue,
        isSaved: false,
        isLoading: false,
      )); // Stop loading state
    }
  }

  Future<void> _onCausesLoadDropdownDataEvent(LoadCausesDropdownDataEvent event,
      Emitter<VfCreateeventscreen1EventdetailsState> emit) async {
    try {
      final causesData = await vfcrudService.getcauses();
      print('causesData: done');
      emit(state.copyWith(
        vfCreateeventscreen1EventdetailsModelObj:
            state.vfCreateeventscreen1EventdetailsModelObj?.copyWith(
                  causesList: causesData,
                ) ??
                VfCreateeventscreen1EventdetailsModel(
                  // Provide default object if it's null
                  causesList: causesData,
                ),
      ));
    } catch (error) {
      emit(state.copyWith(errorMessage: 'Failed to load causes.'));
    }
  }

  Future<void> _populateEventHostingOptions(LoadEventHostingOptionsEvent event,
      Emitter<VfCreateeventscreen1EventdetailsState> emit) async {
    List<EventHostingType> eventhostingoptions = [
      EventHostingType(id: 'In Person', option: 'In Person'),
      EventHostingType(id: 'Virtual', option: 'Virtual'),
    ];

    print('optiosn: done');
    emit(state.copyWith(
      vfCreateeventscreen1EventdetailsModelObj:
          state.vfCreateeventscreen1EventdetailsModelObj?.copyWith(
                eventhostingoptions: eventhostingoptions,
              ) ??
              VfCreateeventscreen1EventdetailsModel(
                // Provide a default object if null
                eventhostingoptions: eventhostingoptions,
              ),
    ));
  }

  void _changeDate(
    ChangeEventDateEvent event,
    Emitter<VfCreateeventscreen1EventdetailsState> emit,
  ) {
    emit(state.copyWith(
        selectedEventDateInput: event.date,
        eventDateInputController: TextEditingController(
            text: DateFormat('MM/dd/yyyy').format(event.date))));
  }

  void _changeRegDeadline(
    ChangeEventRegistrationByDateEvent event,
    Emitter<VfCreateeventscreen1EventdetailsState> emit,
  ) {
    emit(state.copyWith(
        selectedregdeadline: event.date,
        registrationDeadlineInputController: TextEditingController(
            text: DateFormat('MM/dd/yyyy').format(event.date))));
  }

  void _updateCausesDropDownSelection(
    UpdateCausesDropDownSelectionEvent event,
    Emitter<VfCreateeventscreen1EventdetailsState> emit,
  ) {
    emit(state.copyWith(selectedCausesDropDownValue: event.selectedValue));
  }

  void _updateEventHostingOptions(
    UpdateEventHostingOptionsEvent event,
    Emitter<VfCreateeventscreen1EventdetailsState> emit,
  ) {
    emit(state.copyWith(
        selectedEventHostingOptionDropDownValue: event.selectedValues));
  }

  void _resetInitialization(
    VfCreateeventscreen1EventdetailsResetInitializationEvent event,
    Emitter<VfCreateeventscreen1EventdetailsState> emit,
  ) {
    emit(VfCreateeventscreen1EventdetailsState());
  }
}
