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
  }

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
        await _onLoadEventListForAttendanceApprovalEvent(
            LoadEventListForApprovalEvent(userId: event.userId), emit);
      }

      emit(state.copyWith(
        ListType: event.listType,
        vfEventListModelObj:
            (state.vfEventListModelObj ?? VfEventListModel()).copyWith(
          upcomingeventslistItemList: fillUpcomingeventslistItemList(),
        ),
        isLoading: false, // End loading state
      ));
    } catch (error) {
      print('Error initializing state: $error');
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to initialize VfHomescreen state: $error',
      ));
    }
  }

  // Function to fill upcoming events list item
  List<UpcomingeventslistItemModel> fillUpcomingeventslistItemList() {
    if (state.upcomingEventsList == null || state.upcomingEventsList!.isEmpty) {
      return []; // Return an empty list if there are no events
    }

    return state.upcomingEventsList!.map((event) {
      return UpcomingeventslistItemModel(
        id: event.eventId ?? "",
        listItemHeadlin: event.title,
        listItemSupport: event.description,
        isCanceled: event.eventStatus == "canceled" ? true : false,
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
    emit(state.copyWith(isLoading: true));

    try {
      final List<Voluevents> upcomingEventsData =
          await vfcrudService.geteventandshiftforapproval(event.userId!);
      final List<Map<String, String>> allEvents =
          convertEventsToMap(upcomingEventsData);
      emit(state.copyWith(
        isLoading: false,
        upcomingEventsList: upcomingEventsData,
        allEvents: allEvents,
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
      final List<Voluevents> allEvents = state.upcomingEventsList!;
      print('allEvents: $allEvents');

      // Filter events based on the date range and day of the week
      final filteredEvents = allEvents.where((volEvent) {
        // Check if the event's start date is within the provided date range
        final isWithinDateRange = event.dateRange == null ||
            (volEvent.startDate != null &&
                volEvent.startDate!.isAfter(event.dateRange!.start) &&
                volEvent.startDate!.isBefore(event.dateRange!.end
                    .add(Duration(hours: 23, minutes: 59, seconds: 59))));

        // Check if the event's weekday matches any of the provided daysOfWeek
        final eventDayOfWeek = getDayName(volEvent.startDate!.weekday);
        final isDayOfWeek = event.daysOfWeek.contains(eventDayOfWeek);

        // Return events that match both the date range and day of the week
        return isWithinDateRange && isDayOfWeek;
      }).toList();

      print('filteredEvents: $filteredEvents');

      // Emit the updated state with filtered events
      emit(state.copyWith(
        isLoading: false,
        upcomingEventsList: filteredEvents,
      ));

      emit(state.copyWith(
        vfEventListModelObj:
            (state.vfEventListModelObj ?? VfEventListModel()).copyWith(
          upcomingeventslistItemList: fillUpcomingeventslistItemList(),
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
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
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
}
