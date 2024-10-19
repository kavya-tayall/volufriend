part of 'vf_volunteerWelcomescreen_bloc.dart';

// Abstract class for all events that can be dispatched from the
/// VfWelcomescreen widget.
///
/// Events must be immutable and implement the [Equatable] interface.
abstract class VfvolunteerWelcomescreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfWelcomescreen widget is first created.
class VfVolunteerWelcomeInitialEvent extends VfvolunteerWelcomescreenEvent {
  final LoginUser globalLoginUser;
  final UserState globalUserState;

  VfVolunteerWelcomeInitialEvent(
    this.globalLoginUser,
    this.globalUserState,
  );

  @override
  List<Object?> get props => [globalLoginUser, globalUserState];
}
