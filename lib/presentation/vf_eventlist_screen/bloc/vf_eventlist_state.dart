part of 'vf_eventlist_bloc.dart';

/// Represents the state of VfHomescreen in the application.
class VfEventListScreenState extends Equatable {
  final VfEventListModel? vfEventListModelObj;
  final bool isLoading; // To manage loading state
  final List<Voluevents>? upcomingEventsList;
  final List<Voluevents>? approveEventsList;
  final String? errorMessage; // Added field for error messages
  final List<Map<String, String>> allEvents;
  final List<Voluevents> pastEventsList;
  final List<Voluevents> toBeActionedEventsList;
  final List<String>? completedEventIdList;
  final List<String>? deletedEventIdList;

  final String ListType;

  const VfEventListScreenState(
      {this.vfEventListModelObj,
      this.isLoading = false,
      this.upcomingEventsList = const [],
      this.errorMessage, // Initialize errorMessage
      this.allEvents = const [],
      this.ListType = "",
      this.pastEventsList = const [],
      this.toBeActionedEventsList = const [],
      this.completedEventIdList = const [],
      this.deletedEventIdList = const [],
      this.approveEventsList = const []});

  @override
  List<Object?> get props => [
        vfEventListModelObj,
        isLoading,
        upcomingEventsList,
        errorMessage, // Add to props for equality checks
        allEvents,
        ListType,
        pastEventsList,
        toBeActionedEventsList,
        completedEventIdList,
        deletedEventIdList,
        approveEventsList,
      ];

  VfEventListScreenState copyWith({
    VfEventListModel? vfEventListModelObj,
    bool? isLoading,
    List<Voluevents>? upcomingEventsList,
    String? errorMessage, // Added parameter for errorMessage
    List<Map<String, String>>? allEvents,
    String? ListType,
    List<Voluevents>? pastEventsList,
    List<Voluevents>? toBeActionedEventsList,
    List<String>? completedEventIdList,
    List<String>? deletedEventIdList,
    List<Voluevents>? approveEventsList,
  }) {
    return VfEventListScreenState(
      vfEventListModelObj: vfEventListModelObj ?? this.vfEventListModelObj,
      isLoading: isLoading ?? this.isLoading,
      upcomingEventsList: upcomingEventsList ?? this.upcomingEventsList,
      errorMessage: errorMessage ?? this.errorMessage, // Handle errorMessage
      allEvents: allEvents ?? this.allEvents,
      ListType: ListType ?? this.ListType,
      pastEventsList: pastEventsList ?? this.pastEventsList,
      toBeActionedEventsList:
          toBeActionedEventsList ?? this.toBeActionedEventsList,
      completedEventIdList: completedEventIdList,
      deletedEventIdList: deletedEventIdList,
      approveEventsList: approveEventsList,
    );
  }
}
