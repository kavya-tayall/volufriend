part of 'vf_homescreen_bloc.dart';

/// Represents the state of VfHomescreen in the application.
class VfHomescreenState extends Equatable {
  final VfHomescreenModel? vfHomescreenModelObj;
  final bool isLoading; // To manage loading state
  final List<Voluevents>? upcomingEventsList;
  final List<Map<String, String>> allEvents;
  final String? errorMessage; // Added field for error messages
  final bool showCheckInButton; // Added field for showCheckInButton

  const VfHomescreenState({
    this.vfHomescreenModelObj,
    this.isLoading = false,
    this.upcomingEventsList,
    this.errorMessage, // Initialize errorMessage
    this.showCheckInButton = false, // Initialize showCheckInButton
    this.allEvents = const [],
  });

  @override
  List<Object?> get props => [
        vfHomescreenModelObj,
        isLoading,
        upcomingEventsList,
        errorMessage, // Add to props for equality checks
        showCheckInButton, // Add to props for equality checks
        allEvents,
      ];

  VfHomescreenState copyWith({
    VfHomescreenModel? vfHomescreenModelObj,
    bool? isLoading,
    List<Voluevents>? upcomingEventsList,
    String? errorMessage, // Added parameter for errorMessage
    bool? showCheckInButton, // Added parameter for showCheckInButton
    List<Map<String, String>>? allEvents,
  }) {
    return VfHomescreenState(
      vfHomescreenModelObj: vfHomescreenModelObj ?? this.vfHomescreenModelObj,
      isLoading: isLoading ?? this.isLoading,
      upcomingEventsList: upcomingEventsList ?? this.upcomingEventsList,
      errorMessage: errorMessage ?? this.errorMessage, // Handle errorMessage
      showCheckInButton: showCheckInButton ??
          this.showCheckInButton, // Handle showCheckInButton
      allEvents: allEvents ?? this.allEvents,
    );
  }
}
