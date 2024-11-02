import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:volufriend/presentation/vf_volunteeringcalendarpage_screen/models/vf_volunteeringcalendarpage_model.dart';
import '../../../core/app_export.dart';
import '../../vf_userattendancereport_screen/models/vf_userattendancereportpage_model.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'package:table_calendar/table_calendar.dart';

part 'vf_volunteeringcalendarpage_event.dart';
part 'vf_volunteeringcalendarpage_state.dart';

class VfVolunteeringcalendarpageBloc extends Bloc<
    VfVolunteeringcalendarpageEvent, VfVolunteeringcalendarpageState> {
  final VolufriendCrudService vfCrudService;

  // Cache for events (using HashMap/Map)
  Map<DateTime, List<Voluevents>> _eventsCache = {};

  VfVolunteeringcalendarpageBloc({
    required this.vfCrudService,
  }) : super(VfVolunteeringcalendarpageState(
          Role: '',
          selectedDay: DateTime.now(),
          focusedDay: DateTime.now(),
          calendarFormat: CalendarFormat.month,
          selectedEvents: [],
          currentMonthStart:
              DateTime(DateTime.now().year, DateTime.now().month, 1),
          currentMonthEnd:
              DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
          monthsFetched: 1,
        )) {
    on<InitializeCalendarEvent>(_onInitializeCalendar);
    on<SelectDayEvent>(_onDaySelected);
    on<ChangeCalendarFormatEvent>(_onChangeCalendarFormat);
    on<FetchMoreEventsEvent>(_onFetchMoreEvents);
  }

  // Helper function to normalize DateTime to day-level precision (ignores time)
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  // Initialize the calendar with one month of data
  Future<void> _onInitializeCalendar(
    InitializeCalendarEvent event,
    Emitter<VfVolunteeringcalendarpageState> emit,
  ) async {
    final DateTime currentDate = event.currentDate;
    final DateTime monthStart =
        DateTime(currentDate.year, currentDate.month, 1);
    final DateTime monthEnd =
        DateTime(currentDate.year, currentDate.month + 1, 0);

    // Pre-create the cache for all days in the month range with empty lists
    _initializeCacheForRange(monthStart, monthEnd);

    // Fetch the entire range from the database during initialization
    final events = await _getEventsForRangeFromDB(
        event.userId, monthStart, monthEnd, event.role,
        isInitialFetch: true);

    emit(state.copyWith(
      selectedDay: currentDate,
      focusedDay: currentDate,
      selectedEvents: events,
      currentMonthStart: monthStart,
      currentMonthEnd: monthEnd,
      Role: event.role,
      userId: event.userId,
    ));
  }

  // Handles day selection
  Future<void> _onDaySelected(
    SelectDayEvent event,
    Emitter<VfVolunteeringcalendarpageState> emit,
  ) async {
    final events =
        await _getEventsForDay(event.selectedDay, event.userId, event.Role);
    emit(state.copyWith(
      selectedDay: event.selectedDay,
      focusedDay: event.focusedDay,
      selectedEvents: events,
    ));
  }

  // Fetch more events when user navigates past the last date of events fetched
  Future<void> _onFetchMoreEvents(
    FetchMoreEventsEvent event,
    Emitter<VfVolunteeringcalendarpageState> emit,
  ) async {
    if (state.monthsFetched < 2) {
      final DateTime newMonthStart =
          state.currentMonthEnd.add(Duration(days: 1));
      final DateTime newMonthEnd =
          DateTime(newMonthStart.year, newMonthStart.month + 1, 0);

      // Pre-create cache for the new range
      _initializeCacheForRange(newMonthStart, newMonthEnd);

      // Fetch the range from the database or cache
      final moreEvents = await _getEventsForRangeFromDB(
          event.userId, newMonthStart, newMonthEnd, event.role);

      final updatedEvents = [...state.selectedEvents, ...moreEvents];
      emit(state.copyWith(
        currentMonthStart: newMonthStart,
        currentMonthEnd: newMonthEnd,
        selectedEvents: updatedEvents,
        monthsFetched: state.monthsFetched + 1,
      ));
    }
  }

  // Change calendar format (month, 1-week, 2-week)
  void _onChangeCalendarFormat(
    ChangeCalendarFormatEvent event,
    Emitter<VfVolunteeringcalendarpageState> emit,
  ) {
    emit(state.copyWith(calendarFormat: event.format));
  }

  // Pre-create cache for every day in the date range (empty lists for each day)
  void _initializeCacheForRange(DateTime start, DateTime end) {
    DateTime currentDate = _normalizeDate(start);
    while (currentDate.isBefore(end) || currentDate.isAtSameMomentAs(end)) {
      if (!_eventsCache.containsKey(currentDate)) {
        _eventsCache[currentDate] = []; // Initialize empty list for the day
        print('Pre-caching empty list for $currentDate');
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }
  }

  // **Check if an event exists in the cache based on event_id**
  bool _isEventInCache(List<Voluevents> cachedEvents, String eventId) {
    return cachedEvents.any((event) => event.eventId == eventId);
  }

  // **Add events to cache, avoid duplicates based on event_id**
  void _addEventToCache(DateTime normalizedDay, Voluevents event) {
    if (!_eventsCache.containsKey(normalizedDay)) {
      _eventsCache[normalizedDay] = [];
    }

    // Check if the event is already in the cache
    if (!_isEventInCache(_eventsCache[normalizedDay]!, event.eventId!)) {
      _eventsCache[normalizedDay]!.add(event);
      print('Added event ${event.eventId} to cache for $normalizedDay');
    } else {
      print(
          'Event ${event.eventId} already exists in cache for $normalizedDay');
    }
  }

  // Get events for a specific day
  Future<List<Voluevents>> _getEventsForDay(
      DateTime day, String userId, String Role) async {
    final normalizedDay = _normalizeDate(day);

    if (_eventsCache.containsKey(normalizedDay)) {
      print('Returning events from cache for $normalizedDay');
      return _eventsCache[normalizedDay]!;
    } else {
      print('Fetching events from API for $normalizedDay');
      final events = await vfCrudService.getEventsForDay(
          eventDate: normalizedDay, userId: userId, role: Role);

      if (events != null) {
        for (var event in events) {
          _addEventToCache(normalizedDay, event); // Add events to cache
        }
      }

      return _eventsCache[normalizedDay] ?? [];
    }
  }

  // Get events for a range with caching logic
  Future<List<Voluevents>> _getEventsForRangeFromDB(
    String userId,
    DateTime start,
    DateTime end,
    String Role, {
    bool isInitialFetch = false,
  }) async {
    if (isInitialFetch) {
      // Directly fetch the range from the database during initialization
      final events = await vfCrudService.getEventsForRange(
        userId: userId,
        eventRangeStartDate: start,
        eventRangeEndtDate: end,
        role: Role,
      );

      // Cache only the days that have events
      for (var event in events) {
        final eventDate = event.startDate;
        if (eventDate != null) {
          final normalizedDate = _normalizeDate(eventDate);
          _addEventToCache(normalizedDate, event); // Use the new cache logic
        }
      }
      return events;
    } else {
      // If it's not initialization, use the existing caching logic
      return _getEventsForRange(userId, start, end, Role);
    }
  }

  // Cache checking for range-specific events
  Future<List<Voluevents>> _getEventsForRange(
      String userId, DateTime start, DateTime end, String Role) async {
    List<Voluevents> events = [];

    // Pre-create cache entries for the entire range
    _initializeCacheForRange(start, end);

    // Fetch all events for the range from the cache
    DateTime currentDate = _normalizeDate(start);
    while (currentDate.isBefore(end) || currentDate.isAtSameMomentAs(end)) {
      if (_eventsCache.containsKey(currentDate)) {
        events.addAll(_eventsCache[currentDate]!);
      }
      currentDate =
          currentDate.add(const Duration(days: 1)); // Move to the next day
    }

    // If no cached events were found, fetch from the API
    if (events.isEmpty) {
      final apiEvents = await vfCrudService.getEventsForRange(
        userId: userId,
        eventRangeStartDate: start,
        eventRangeEndtDate: end,
        role: Role,
      );

      // Cache only the days that have events
      for (var event in apiEvents) {
        final eventDate = event.startDate;
        if (eventDate != null) {
          final normalizedDate = _normalizeDate(eventDate);
          _addEventToCache(normalizedDate, event); // Use the new cache logic
        }
      }
      events.addAll(apiEvents);
    }

    return events;
  }

  // **Method to get events for a specific day from the cache**
  List<Voluevents> getEventsForDayFromCache(DateTime day) {
    final normalizedDay = _normalizeDate(day);
    return _eventsCache[normalizedDay] ?? [];
  }
}
