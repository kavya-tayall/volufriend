part of 'vf_viewvolunteeringprofilescreen_bloc.dart';

abstract class VfVolunteerProfilescreeEvent extends Equatable {
  const VfVolunteerProfilescreeEvent();

  @override
  List<Object?> get props => [];
}

class LoadVolunteerProfileEvent extends VfVolunteerProfilescreeEvent {
  final String userId;

  // Constructor with named parameters
  const LoadVolunteerProfileEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}
