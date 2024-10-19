// Volunteer States
part of 'vf_volunteerhomepage_bloc.dart';

abstract class VolunteerState {}

class VolunteerInitial extends VolunteerState {}

class VolunteerLoading extends VolunteerState {}

class VolunteerLoaded extends VolunteerState {
  final List<Voluevents> upcomingEvents;

  VolunteerLoaded({required this.upcomingEvents});
}

class VolunteerError extends VolunteerState {}

// Interest States
abstract class InterestState {}

class InterestInitial extends InterestState {}

class InterestLoading extends InterestState {}

class InterestLoaded extends InterestState {
  final List<Voluevents> interestedEvents;

  InterestLoaded({required this.interestedEvents});
}

class InterestError extends InterestState {}

class VfVolunteerhomepageState extends Equatable {
  VfVolunteerhomepageState({
    this.vfVolunteerhomepageModelObj,
    this.eventId = '',
  });

  final VfVolunteerhomepageModel? vfVolunteerhomepageModelObj;
  final String? eventId;

  @override
  List<Object?> get props => [
        vfVolunteerhomepageModelObj,
        eventId,
      ];

  VfVolunteerhomepageState copyWith({
    VfVolunteerhomepageModel? vfHomescreenContainerModelObj,
    String? eventId,
  }) {
    return VfVolunteerhomepageState(
      vfVolunteerhomepageModelObj:
          vfVolunteerhomepageModelObj ?? this.vfVolunteerhomepageModelObj,
      eventId: eventId ?? this.eventId,
    );
  }
}
