import 'package:flutter_bloc/flutter_bloc.dart';
import 'event_search_event.dart';
import 'event_search_state.dart';

class EventSearchBloc extends Bloc<EventSearchEvent, EventSearchState> {
  final List<Map<String, String>> events = [
    // Environment
    {"name": "Tree Plantation", "cause": "Environment", "org": "Green Earth"},
    {"name": "Beach Cleanup", "cause": "Environment", "org": "Ocean Guardians"},
    {
      "name": "Community Recycling Drive",
      "cause": "Environment",
      "org": "Eco Warriors"
    },

    // Healthcare
    {"name": "Blood Donation Camp", "cause": "Healthcare", "org": "Red Cross"},
    {
      "name": "Free Health Check-up",
      "cause": "Healthcare",
      "org": "Health Heroes"
    },
    {
      "name": "Mental Health Awareness Workshop",
      "cause": "Healthcare",
      "org": "MindCare Foundation"
    },

    // Arts & Culture
    {"name": "Art for All", "cause": "Arts & Culture", "org": "Creative Minds"},
    {
      "name": "Local Theater Showcase",
      "cause": "Arts & Culture",
      "org": "Stage Performers"
    },
    {
      "name": "Cultural Dance Fest",
      "cause": "Arts & Culture",
      "org": "CultureConnect"
    },

    // Education
    {"name": "School Supplies Drive", "cause": "Education", "org": "EduCare"},
    {
      "name": "Community Tutoring Program",
      "cause": "Education",
      "org": "Learn Together"
    },
    {
      "name": "Book Donation Drive",
      "cause": "Education",
      "org": "Readers Unite"
    },

    // Animal Welfare
    {
      "name": "Adopt a Pet Day",
      "cause": "Animal Welfare",
      "org": "Happy Tails"
    },
    {
      "name": "Animal Shelter Volunteering",
      "cause": "Animal Welfare",
      "org": "Safe Paws"
    },
    {
      "name": "Wildlife Conservation Fundraiser",
      "cause": "Animal Welfare",
      "org": "Wildlife Rescue"
    },

    // Poverty Alleviation
    {
      "name": "Food Drive for the Homeless",
      "cause": "Poverty Alleviation",
      "org": "Feeding Hands"
    },
    {
      "name": "Clothing Donation Camp",
      "cause": "Poverty Alleviation",
      "org": "Warm Hearts"
    },
    {
      "name": "Affordable Housing Awareness",
      "cause": "Poverty Alleviation",
      "org": "Homes for All"
    },
  ];

  EventSearchBloc() : super(EventSearchState(filteredEvents: [])) {
    // Handle search query changes
    on<SearchQueryChanged>((event, emit) {
      emit(EventSearchState(
          filteredEvents: _filterByQuery(event.query, events)));
    });

    // Handle filtering by cause
    on<FilterByCause>((event, emit) {
      emit(EventSearchState(
          filteredEvents: _filterByCause(event.cause, events)));
    });

    // Handle reset filter (when user clears search or resets the filter)
    on<ResetFilter>((event, emit) {
      emit(EventSearchState(filteredEvents: events)); // Emit full dataset
    });
  }

  // Filter events based on search query
  List<Map<String, String>> _filterByQuery(
      String query, List<Map<String, String>> fullEventsList) {
    return fullEventsList.where((event) {
      final nameLower = event['name']!.toLowerCase();
      final causeLower = event['cause']!.toLowerCase();
      final orgLower = event['org']!.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameLower.contains(searchLower) ||
          causeLower.contains(searchLower) ||
          orgLower.contains(searchLower);
    }).toList();
  }

  // Filter events based on cause
  List<Map<String, String>> _filterByCause(
      String cause, List<Map<String, String>> fullEventsList) {
    return fullEventsList.where((event) {
      final causeLower = event['cause']!.toLowerCase();
      return causeLower.contains(cause.toLowerCase());
    }).toList();
  }
}
