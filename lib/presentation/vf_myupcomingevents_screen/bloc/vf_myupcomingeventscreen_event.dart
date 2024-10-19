part of 'vf_myupcomingeventscreen_bloc.dart';

abstract class VfMyupcomingeventscreenEvent extends Equatable {
  const VfMyupcomingeventscreenEvent();

  @override
  List<Object?> get props => [];
}

class LoadUpcomingEventsEvent extends VfMyupcomingeventscreenEvent {
  final String userId;

  // Constructor with named parameters
  const LoadUpcomingEventsEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}
