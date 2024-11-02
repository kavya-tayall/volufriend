import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Ensure you have this import for Bloc
import '../../../core/app_export.dart';
import '../../vf_homescreen_page/models/upcomingeventslist_item_model.dart';
import '../../vf_eventlist_screen/models/vf_eventlist_model.dart';
import '/crud_repository/volufriend_crud_repo.dart';

part 'vf_eventlist_event.dart';
part 'vf_eventlist_state.dart';

class EventListBloc
    extends Bloc<VfEventListScreenEvent, VfEventListScreenState> {
  final VolufriendCrudService vfcrudService;

  EventListBloc(VfEventListScreenState initialState, this.vfcrudService)
      : super(initialState) {
    on<EventListScreenInitialEvent>(_onInitialize);
    on<LoadUpcomingEventListEvent>(_onLoadUpcomingEventListEvent);
    on<LoadEventListForApprovalEvent>(
        _onLoadEventListForAttendanceApprovalEvent);
    // Add new event handlers
    on<LoadPastEventsEvent>(_onLoadPastEventsEvent);
    on<FilterEventsEvent>(_onFilterEventsEvent);
    on<HighlightEvent>(_onHighlightEvent);
    on<MarkEventAsCompletedEvent>(_onMarkEventAsCompletedEvent);
    on<DeleteEvent>(_onDeleteEvent);
    on<ResetEventListScreenEvent>(_onResetEventListScreenEvent);
    on<CancelEventEvent>(_onCancelEventFromListEvent);
  }

  // Handle the reset event
  Future<void> _onResetEventListScreenEvent(
    ResetEventListScreenEvent event,
    Emitter<VfEventListScreenState> emit,
  ) async {
    print('Handling ResetEventListScreenEvent');
    emit(state.copyWith(
      upcomingEventsList: null,
      pastEventsList: null,
      allEvents: null,
      vfEventListModelObj: null,
    ));
  }
  // Handle the initial event

  Future<void> _onInitialize(
    EventListScreenInitialEvent event,
    Emitter<VfEventListScreenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true)); // Start loading state
    print(event.role);
    try {
      print('Event List Type: ${event.listType}');
      // Load events based on user role
      if (event.role == "Volunteer") {
        await _onLoadInterestedEvents(
            LoadUpcomingInterestEventListEvent(userId: event.userId), emit);
      } else if (event.role == "Organization" && event.listType == "Upcoming") {
        await _onLoadUpcomingEventListEvent(
            LoadUpcomingEventListEvent(userId: event.userId), emit);
      } else if (event.role == "Organization" && event.listType == "Approve") {
        print('Loading events for approval');
        List<Voluevents> upcomingEventsData =
            await _getEventListForAttendanceApprovalEvent(event.userId!);
        final List<Map<String, String>> allEvents =
            convertEventsToMap(upcomingEventsData);

        emit(state.copyWith(
          ListType: event.listType,
          upcomingEventsList: upcomingEventsData,
          allEvents: allEvents,
          vfEventListModelObj:
              (state.vfEventListModelObj ?? VfEventListModel()).copyWith(
            upcomingeventslistItemList:
                fillUpcomingeventslistItemList(upcomingEventsData),
          ),
          isLoading: false, // End loading state
        ));
      }

      if (event.listType == "Approve") {
        print('Do Nothing');
      } else {
        emit(state.copyWith(
          ListType: event.listType,
          vfEventListModelObj:
              (state.vfEventListModelObj ?? VfEventListModel()).copyWith(
            upcomingeventslistItemList:
                fillUpcomingeventslistItemList(state.upcomingEventsList!),
          ),

          isLoading: false, // End loading state
        ));
      }
    } catch (error) {
      print('Error initializing state: $error');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to initialize VfHomescreen state: $error',
      ));
    }
  }

  // Function to fill upcoming events list item
  List<UpcomingeventslistItemModel> fillUpcomingeventslistItemList(
      List<Voluevents> upcomingEventsList) {
    if (upcomingEventsList == null || upcomingEventsList.isEmpty) {
      return []; // Return an empty list if there are no events
    }

    return upcomingEventsList.map((event) {
      return UpcomingeventslistItemModel(
        id: event.eventId ?? "",
        listItemHeadlin: event.title,
        listItemSupport: event.description,
        isCanceled: event.eventStatus == "canceled" ? true : false,
        imageUrlThumbnail: event.imageUrls?.first ?? "",
      );
    }).toList();
  }

  // Load interested events
  Future<void> _onLoadInterestedEvents(
    LoadUpcomingInterestEventListEvent event,
    Emitter<VfEventListScreenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final List<Voluevents> upcomingEventsData =
          await vfcrudService.getUserInterestedEvents(event.userId!);

      final List<Map<String, String>> allEvents =
          convertEventsToMap(upcomingEventsData);
      emit(state.copyWith(
        isLoading: false,
        upcomingEventsList: upcomingEventsData,
        allEvents: allEvents,
      ));
    } catch (error) {
      print('Error loading Interested events: $error');
      emit(state.copyWith(
        isLoading: false,
        upcomingEventsList: [],
        errorMessage: 'Failed to load Interested events',
      ));
    }
  }

  // Convert events to map
  List<Map<String, String>> convertEventsToMap(List<Voluevents> events) {
    return events.map((event) {
      return {
        'eventId': event.eventId,
        'cause': event.cause ?? 'Unknown',
        'title': event.title ?? 'Unknown',
        'org_name': event.orgName ?? 'Unknown',
      };
    }).toList();
  }

  // Load upcoming event list
  Future<void> _onLoadUpcomingEventListEvent(
    LoadUpcomingEventListEvent event,
    Emitter<VfEventListScreenState> emit,
  ) async {
    print('Handling LoadUpcomingEventListEvent');
    emit(state.copyWith(isLoading: true));

    try {
      final List<Voluevents> upcomingEventsData =
          await vfcrudService.getUpcomingEventsforOrgUser(event.userId!);
      final List<Map<String, String>> allEvents =
          convertEventsToMap(upcomingEventsData);
      emit(state.copyWith(
        isLoading: false,
        upcomingEventsList: upcomingEventsData,
        allEvents: allEvents,
      ));
    } catch (error) {
      print('Error loading upcoming events: $error');
      emit(state.copyWith(
        isLoading: false,
        upcomingEventsList: [],
        errorMessage: 'Failed to load upcoming events',
      ));
    }
  }

  // Load events for attendance approval
  Future<void> _onLoadEventListForAttendanceApprovalEvent(
    LoadEventListForApprovalEvent event,
    Emitter<VfEventListScreenState> emit,
  ) async {
    print('Handling _onLoadEventListForAttendanceApprovalEvent');

    try {
      final List<Voluevents> approveEventsList =
          await vfcrudService.geteventandshiftforapproval(event.userId!);
      final List<Map<String, String>> allEvents =
          convertEventsToMap(approveEventsList);

      emit(state.copyWith(
        isLoading: false,
        upcomingEventsList: approveEventsList,
        allEvents: allEvents,
        vfEventListModelObj:
            (state.vfEventListModelObj ?? VfEventListModel()).copyWith(
          upcomingeventslistItemList:
              fillUpcomingeventslistItemList(approveEventsList!),
        ),
      ));
    } catch (error) {
      print('Error loading events for approval: $error');
      emit(state.copyWith(
        isLoading: false,
        upcomingEventsList: [],
        errorMessage: 'Failed to load events for approval',
      ));
    }
  }

  // Load events for attendance approval
  Future<List<Voluevents>> _getEventListForAttendanceApprovalEvent(
      String userId) async {
    print('Handling _onLoadEventListForAttendanceApprovalEvent');

    try {
      final List<Voluevents> upcomingEventsData =
          await vfcrudService.geteventandshiftforapproval(userId);
      return upcomingEventsData;
    } catch (error) {
      print('Error loading events for approval: $error');
      return [];
    }
  }

  // Load past events
  Future<void> _onLoadPastEventsEvent(
    LoadPastEventsEvent event,
    Emitter<VfEventListScreenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    try {
      final List<Voluevents> pastEventsData = await vfcrudService
          .getPastEventsForUser(event.userId!, event.startDate, event.endDate);
      final List<Map<String, String>> allEvents =
          convertEventsToMap(pastEventsData);
      emit(state.copyWith(
        isLoading: false,
        pastEventsList: pastEventsData, // Make sure you have this in your state
        allEvents: allEvents,
      ));
    } catch (error) {
      print('Error loading past events: $error');
      emit(state.copyWith(
        isLoading: false,
        pastEventsList: [],
        errorMessage: 'Failed to load past events',
      ));
    }
  }

  Future<void> _onFilterEventsEvent(
    FilterEventsEvent event,
    Emitter<VfEventListScreenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true)); // Start loading state

    try {
      // Get all upcoming events from state
      final List<Voluevents> allEvents = state.upcomingEventsList ?? [];

      // Filter events based on the date range, day of the week, and time of day
      final filteredEvents = allEvents.where((volEvent) {
        if (volEvent.startDate == null) return false;

        final eventDate = DateTime(volEvent.startDate!.year,
            volEvent.startDate!.month, volEvent.startDate!.day);

        // Check if the event is within the date range (ignore time if not provided)
        bool isWithinDateRange = true;
        if (event.dateRange != null) {
          final startDate = DateTime(
            event.dateRange!.start.year,
            event.dateRange!.start.month,
            event.dateRange!.start.day,
          );
          final endDate = DateTime(
            event.dateRange!.end.year,
            event.dateRange!.end.month,
            event.dateRange!.end.day,
          );

          // Check if eventDate is on or between startDate and endDate
          isWithinDateRange = eventDate.isAtSameMomentAs(startDate) ||
              eventDate.isAtSameMomentAs(endDate) ||
              (eventDate.isAfter(startDate) && eventDate.isBefore(endDate));
        }

        // Check if the event's weekday matches any of the provided daysOfWeek
        bool isDayOfWeek = true;

        if (event.daysOfWeek != null &&
            event.daysOfWeek!.isNotEmpty &&
            event.daysOfWeek != '') {
          final eventDayOfWeek = getDayName(volEvent.startDate!.weekday);
          isDayOfWeek = event.daysOfWeek!.contains(eventDayOfWeek);
        }

        // Check if the event's time matches the specified timeOfDay based on shifts
        bool isTimeOfDay = true;
        if (event.timeOfDay != null &&
            event.timeOfDay!.isNotEmpty &&
            event.timeOfDay != '') {
          // Ensure shifts are available and non-empty for the event
          final shifts = volEvent.shifts ?? [];
          if (shifts.isNotEmpty) {
            isTimeOfDay = shifts.any((shift) {
              final hour = shift.startTime?.hour;
              if (hour == null) return false;

              if (event.timeOfDay == 'Morning') {
                return hour >= 5 && hour < 12;
              } else if (event.timeOfDay == 'Afternoon') {
                return hour >= 12 && hour < 17;
              } else if (event.timeOfDay == 'Evening') {
                return hour >= 17 || hour < 5;
              }
              return false;
            });
          }
        }
        // Return true if all active filters match
        return isWithinDateRange && isDayOfWeek && isTimeOfDay;
      }).toList();

      emit(state.copyWith(
        vfEventListModelObj:
            (state.vfEventListModelObj ?? VfEventListModel()).copyWith(
          upcomingeventslistItemList:
              fillUpcomingeventslistItemList(filteredEvents),
        ),
        isLoading: false, // End loading state
      ));
    } catch (error) {
      print('Error filtering events: $error');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to filter events',
      ));
    }
  }

// Helper function to get day of the week from a DateTime object
  String getDayName(int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return 'Invalid day';
    }
  }

  // Handle highlighting an event
  Future<void> _onHighlightEvent(
    HighlightEvent event,
    Emitter<VfEventListScreenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true)); // Start loading state

    try {
      // Get the existing list of events
      final updatedEventListModel = state.vfEventListModelObj?.copyWith(
        upcomingeventslistItemList:
            state.vfEventListModelObj!.upcomingeventslistItemList.map((e) {
          if (e.id == event.eventId) {
            // Mark the event as highlighted by updating the `isHighlighted` field
            return e.copyWith(
                isSelected:
                    true); // Assuming `isSelected` represents highlighted status
          }
          return e;
        }).toList(),
      );

      // Emit updated state with the modified model
      emit(state.copyWith(
        isLoading: false,
        vfEventListModelObj: updatedEventListModel, // Update the state model
      ));
    } catch (error) {
      print('Error highlighting event: $error');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to highlight event',
      ));
    }
  }

  Future<void> _onMarkEventAsCompletedEvent(
    MarkEventAsCompletedEvent event,
    Emitter<VfEventListScreenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true)); // Start loading state

    try {
      // Create a list of completed event IDs from the beginning
      final updatedCompletedEventIds = List<String>.from(
          state.completedEventIdList ??
              []); // Assuming you have a property for completed IDs

      // Find the specific event to be marked as completed from upcomingEventsList
      final updatedEventIndex = state.upcomingEventsList?.indexWhere(
        (e) => e.eventId == event.eventId,
      );

      if (updatedEventIndex != null && updatedEventIndex != -1) {
        // Remove the event from upcomingEventsList
        final updatedUpcomingEventsList =
            List<Voluevents>.from(state.upcomingEventsList!)
              ..removeAt(updatedEventIndex);

        // Add the completed event ID to the completed event IDs list
        updatedCompletedEventIds
            .add(state.upcomingEventsList![updatedEventIndex].eventId);

        //add code to remove from db and get the updated record from db and add back to both list
        //chnage in UI to show the completed in different color

        // Remove the event from vfEventListModelObj
        final updatedVfEventListModelObj =
            state.vfEventListModelObj?.removeEventById(event.eventId);

        // Emit new state with the updated lists
        emit(state.copyWith(
          isLoading: false,
          upcomingEventsList: updatedUpcomingEventsList,
          completedEventIdList: updatedCompletedEventIds,
          vfEventListModelObj: updatedVfEventListModelObj,
        ));
      } else {
        // If the event was not found, just emit the current state with loading off
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Event not found',
        ));
      }
    } catch (error) {
      print('Error marking event as completed: $error');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to mark event as completed',
      ));
    }
  }

  // Handle deleting an event
  Future<void> _onDeleteEvent(
    DeleteEvent event,
    Emitter<VfEventListScreenState> emit,
  ) async {
    emit(state.copyWith(isLoading: true)); // Start loading state

    try {
      // Create a list of completed event IDs from the beginning
      final updatedCompletedEventIds = List<String>.from(
          state.deletedEventIdList ??
              []); // Assuming you have a property for completed IDs

      // Find the specific event to be marked as completed from upcomingEventsList
      final updatedEventIndex = state.upcomingEventsList?.indexWhere(
        (e) => e.eventId == event.eventId,
      );

      if (updatedEventIndex != null && updatedEventIndex != -1) {
        // Remove the event from upcomingEventsList
        final updatedUpcomingEventsList =
            List<Voluevents>.from(state.upcomingEventsList!)
              ..removeAt(updatedEventIndex);

        // Add the completed event ID to the completed event IDs list
        updatedCompletedEventIds
            .add(state.upcomingEventsList![updatedEventIndex].eventId);

        // Remove the event from vfEventListModelObj
        final updatedVfEventListModelObj =
            state.vfEventListModelObj?.removeEventById(event.eventId);

        // Emit new state with the updated lists
        emit(state.copyWith(
          isLoading: false,
          upcomingEventsList: updatedUpcomingEventsList,
          deletedEventIdList: updatedCompletedEventIds,
          vfEventListModelObj: updatedVfEventListModelObj,
        ));
      } else {
        // If the event was not found, just emit the current state with loading off
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Event not found',
        ));
      }
    } catch (error) {
      print('Error deleting event as completed: $error');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to mark event as deleting',
      ));
    }
  }

  _onCancelEventFromListEvent(
    CancelEventEvent event,
    Emitter<VfEventListScreenState> emit,
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
          vfEventListModelObj:
              (state.vfEventListModelObj ?? VfEventListModel()).copyWith(
            upcomingeventslistItemList:
                updatedAfterCanceleventslistItemList, // Ensure this is not null
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
}
