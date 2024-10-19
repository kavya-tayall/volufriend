part of 'vf_volunteerhomepage_bloc.dart';

// Volunteer Events
abstract class VolunteerEvent {}

class LoadUpcomingEvents extends VolunteerEvent {
  final String volunteerId;

  LoadUpcomingEvents(this.volunteerId);
}

// Interest Events
abstract class InterestEvent {}

class LoadInterestedEvents extends InterestEvent {
  final String userId;

  LoadInterestedEvents(this.userId);
}

abstract class VfVolunteerhomepageEvent extends Equatable {
  const VfVolunteerhomepageEvent();

  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfHomescreenContainer widget is first created.
class VfVolunteerhomepageInitialEvent extends VfVolunteerhomepageEvent {
  @override
  List<Object?> get props => [];
}
