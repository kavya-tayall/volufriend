// event_search_event.dart
abstract class EventSearchEvent {}

class SearchQueryChanged extends EventSearchEvent {
  final String query;

  SearchQueryChanged(this.query);
}

class FilterByCause extends EventSearchEvent {
  final String cause;

  FilterByCause(this.cause);
}

// Event to reset the filters and return the full data set
class ResetFilter extends EventSearchEvent {}
