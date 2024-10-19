import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:volufriend/presentation/vf_eventlist_screen/models/vf_eventlist_model.dart';
import '../../../core/app_export.dart';
import '../models/actionbuttons_item_model.dart';
import '../models/upcomingeventslist_item_model.dart';
import '../models/vf_homescreen_model.dart';
import '/crud_repository/volufriend_crud_repo.dart';

part 'vf_homescreen_event.dart';
part 'vf_homescreen_state.dart';

/// A bloc that manages the state of a VfHomescreen according to the event that is dispatched to it.
class VfHomescreenBloc extends Bloc<VfHomescreenEvent, VfHomescreenState> {
  final VolufriendCrudService vfcrudService;

  VfHomescreenBloc(
      {VfHomescreenState? initialState, required this.vfcrudService})
      : super(
          initialState ??
              VfHomescreenState(), // Provide a default state if none is passed
        ) {
    on<VfHomescreenInitialEvent>(_onInitialize);
    on<UpcomingEventTappedEvent>(_onUpcomingEventTapped);
    on<UpcomingEventDismissedEvent>(_onUpcomingEventDismissed);
    on<CancelEventFromListEvent>(_onCancelEventFromListEvent);
  }

  _onCancelEventFromListEvent(
    CancelEventFromListEvent event,
    Emitter<VfHomescreenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true)); // Start loading state

    try {
      // Load upcoming event list data
      final Voluevents updatedEventFromDb = await vfcrudService.cancelEvent(
          eventId: event.eventId, notifyParticipants: event.notifyParticipants);

      // Update the upcoming events  object list by removing the the canceled event
      final updatedAfterCancelupcomingeventsList =
          await _updatedUpcomingEventsListonCancel(
              event.eventId, updatedEventFromDb, state.upcomingEventsList!);

      // Convert the events to a list of maps for search after cancel
      final List<Map<String, String>> allEventsUpdatedMapAfterCancel =
          convertEventsToMap(updatedAfterCancelupcomingeventsList);

      // Update the upcoming events list used in ListView with the canceled event updated voluevents object list
      final updatedAfterCanceleventslistItemList =
          await _updatedUpcomingEventsListModelonCancel(
              event.eventId, updatedAfterCancelupcomingeventsList);

      emit(
        state.copyWith(
          isLoading: false,
          upcomingEventsList: updatedAfterCancelupcomingeventsList,
          allEvents: allEventsUpdatedMapAfterCancel,
          vfHomescreenModelObj:
              (state.vfHomescreenModelObj ?? VfHomescreenModel()).copyWith(
            upcomingeventslistItemList:
                updatedAfterCanceleventslistItemList, // Ensure this is not null
            actionbuttonsItemList:
                fillActionbuttonsItemList(), // Ensure this is not null
          ),
        ),
      );
    } catch (error) {
      // Handle errors and update state with error message
      print('Error initializing state: $error');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to initialize VfHomescreen state: $error',
      ));
    }
  }

  Future<List<UpcomingeventslistItemModel>>
      _updatedUpcomingEventsListModelonCancel(String eventId,
          List<Voluevents> upcomingEventsListAfterCancelUpdatedfromDb) async {
    // Ensure upcomingEventsList is not null and contains data
    if (upcomingEventsListAfterCancelUpdatedfromDb == null ||
        upcomingEventsListAfterCancelUpdatedfromDb!.isEmpty) {
      return []; // Return an empty list if there are no events
    }
    // Map each event to an UpcomingeventslistItemModel
    return upcomingEventsListAfterCancelUpdatedfromDb.map((event) {
      return UpcomingeventslistItemModel(
        id: event.eventId ?? "", // Use event.eventId
        listItemHeadlin:
            event.title, // Use event.title or provide default value
        listItemSupport:
            event.description, // Use event.description or provide default value
        isCanceled: event.eventStatus == 'canceled'
            ? true
            : false, // Use event.eventDate
      );
    }).toList();
    /*
    try {
      // Create a new updated VfEventListModel with the event marked as canceled
      final updatedEventListModelObj = vfHomescreenModelObjForUpdate.copyWith(
        upcomingeventslistItemList:
            vfHomescreenModelObjForUpdate.upcomingeventslistItemList.map((e) {
          if (e.id == eventId) {
            // Mark the event as canceled by updating the `isCanceled` field
            return e.copyWith(isCanceled: true);
          }
          return e; // Return the original event if it doesn't match the eventId
        }).toList(),
      );

      // Return the updated model
      return updatedEventListModelObj.upcomingeventslistItemList;
    } catch (e) {
      print('Error updating event list model: $e');
      throw Exception('Failed to update event list model.');
    }*/
  }

  Future<List<Voluevents>> _updatedUpcomingEventsListonCancel(
      String eventId,
      Voluevents updatedEventFromDb,
      List<Voluevents> upcomingEventsList) async {
    // Find the specific event to be marked as canceled in upcomingEventsList
    final canceledEventIndex = upcomingEventsList.indexWhere(
      (e) => e.eventId == eventId,
    );

    if (canceledEventIndex != -1) {
      // Create a new list and remove the event from upcomingEventsList
      final updatedUpcomingEventsList =
          List<Voluevents>.from(upcomingEventsList)
            ..removeAt(canceledEventIndex);

      // Add the updated event to the list
      // updatedUpcomingEventsList.add(updatedEventFromDb); -- removing this code as it is not required becuase we do not want to show canceled

      return updatedUpcomingEventsList;
    }
    // If the event is not found, return the original list
    return upcomingEventsList;
  }

  Future<void> _onInitialize(
    VfHomescreenInitialEvent event,
    Emitter<VfHomescreenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true)); // Start loading state

    try {
      // Load upcoming event list data
      if (event.role == "Volunteer") {
        await _onLoadInterestedEvents(
            LoadUpcomingInterestEventListEvent(userId: event.userId), emit);
      } else {
        await _onLoadUpcomingEventListEvent(
            LoadUpcomingEventListEvent(userId: event.userId), emit);
      }

      if (event.role == "Volunteer") {
        emit(
          state.copyWith(
            vfHomescreenModelObj:
                (state.vfHomescreenModelObj ?? VfHomescreenModel()).copyWith(
              upcomingeventslistItemList:
                  fillUpcomingeventslistItemList(), // Ensure this is not null
              actionbuttonsItemList:
                  fillVolunteerActionbuttonsItemList(), // Ensure this is not null
            ),
            isLoading: false, // End loading state
          ),
        );
      } else {
        emit(
          state.copyWith(
            vfHomescreenModelObj:
                (state.vfHomescreenModelObj ?? VfHomescreenModel()).copyWith(
              upcomingeventslistItemList:
                  fillUpcomingeventslistItemList(), // Ensure this is not null
              actionbuttonsItemList:
                  fillActionbuttonsItemList(), // Ensure this is not null
            ),
            isLoading: false, // End loading state
          ),
        );
      }
    } catch (error) {
      // Handle errors and update state with error message
      print('Error initializing state: $error');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to initialize VfHomescreen state: $error',
      ));
    }
  }

  Future<void> _onLoadInterestedEvents(
    LoadUpcomingInterestEventListEvent event,
    Emitter<VfHomescreenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final List<Voluevents> upcomingEventsData =
          await vfcrudService.getUserInterestedEvents(event.userId!);
// Convert the events to a list of maps for search
      final List<Map<String, String>> allEvents =
          convertEventsToMap(upcomingEventsData);

      // Emit the new state with the fetched events
      emit(state.copyWith(
        isLoading: false,
        upcomingEventsList: upcomingEventsData,
        allEvents: allEvents,
      ));
    } catch (error) {
      print('Error loading Interested events: $error');
      emit(state.copyWith(
        isLoading: false,
        upcomingEventsList: [], // Optionally reset or handle empty state
        errorMessage: 'Failed to load Interested events',
      ));
    }
  }

  Future<void> _onLoadUpcomingEventListEvent(
    LoadUpcomingEventListEvent event,
    Emitter<VfHomescreenState> emit, // Correct the type of Emitter
  ) async {
    print('Handling here LoadUpcomingEventListEvent from homescreen');
    emit(state.copyWith(isLoading: true)); // Indicate loading state

    try {
      // Fetch the upcoming events list from the service
      final List<Voluevents> upcomingEventsData =
          (await vfcrudService.getUpcomingEventsforOrgUser(event.userId!))
              .where((event) =>
                  event.eventStatus != 'canceled') // Filter out canceled events
              .toList();

      // Convert the events to a list of maps for search
      final List<Map<String, String>> allEvents =
          convertEventsToMap(upcomingEventsData);

      // Emit the new state with the fetched events
      emit(state.copyWith(
        isLoading: false,
        upcomingEventsList: upcomingEventsData,
        allEvents: allEvents,
      ));
    } catch (error) {
      print('Error loading upcoming events: $error');
      emit(state.copyWith(
        isLoading: false,
        upcomingEventsList: [], // Optionally reset or handle empty state
        errorMessage: 'Failed to load upcoming events',
      ));
    }
  }

  List<Map<String, String>> convertEventsToMap(List<Voluevents> events) {
    return events.map((event) {
      return {
        'eventId': event.eventId,
        'cause': event.cause ?? 'Unknown', // Handle null cause
        'title': event.title ?? 'Unknown', // Handle null title
        'org_name': event.orgName ?? 'Unknown', // Handle null orgName
      };
    }).toList();
  }

  Future<void> _onUpcomingEventTapped(
    UpcomingEventTappedEvent event,
    Emitter<VfHomescreenState> emit,
  ) async {
    // Handle what should happen when an event is tapped
    print('Event tapped: ${event.eventId}');

    // You can add more logic, like navigating to an event details page
  }

  Future<void> _onUpcomingEventDismissed(
    UpcomingEventDismissedEvent event,
    Emitter<VfHomescreenState> emit,
  ) async {
    // Handle what should happen when an event is dismissed/swiped
    print('Event dismissed: ${event.eventId}');

    // Remove the dismissed event from the list
    List<UpcomingeventslistItemModel> updatedList = state
        .vfHomescreenModelObj!.upcomingeventslistItemList
        .where((item) => item.id != event.eventId)
        .toList();

    // Emit the updated state with the event removed
    emit(state.copyWith(
      vfHomescreenModelObj: state.vfHomescreenModelObj?.copyWith(
        upcomingeventslistItemList: updatedList,
      ),
    ));
  }

  List<UpcomingeventslistItemModel> fillUpcomingeventslistItemList() {
    // Ensure upcomingEventsList is not null and contains data
    if (state.upcomingEventsList == null || state.upcomingEventsList!.isEmpty) {
      return []; // Return an empty list if there are no events
    }
    // Map each event to an UpcomingeventslistItemModel
    return state.upcomingEventsList!.map((event) {
      return UpcomingeventslistItemModel(
        id: event.eventId ?? "", // Use event.eventId
        listItemHeadlin:
            event.title, // Use event.title or provide default value
        listItemSupport:
            event.description, // Use event.description or provide default value
        isCanceled: event.eventStatus == 'canceled'
            ? true
            : false, // Use event.eventDate
      );
    }).toList();
  }

  List<ActionbuttonsItemModel> fillActionbuttonsItemList() {
    return [
      ActionbuttonsItemModel(
          iconButton: ImageConstant.imgGroup104, text: "Create Event"),
      ActionbuttonsItemModel(
          iconButton: ImageConstant.imgBookmarkWhiteA700,
          text: "Manage Events"),
      ActionbuttonsItemModel(
          iconButton: ImageConstant.imgCheckmarkWhiteA700,
          text: "Approve Hours")
    ];
  }

  List<ActionbuttonsItemModel> fillVolunteerActionbuttonsItemList() {
    return [
      ActionbuttonsItemModel(
          iconButton: ImageConstant.imgGroup104, text: "My events"),
      ActionbuttonsItemModel(
          iconButton: ImageConstant.imgBookmarkWhiteA700, text: "Manage goals"),
      ActionbuttonsItemModel(
          iconButton: ImageConstant.imgCheckmarkWhiteA700, text: "View report")
    ];
  }
}
