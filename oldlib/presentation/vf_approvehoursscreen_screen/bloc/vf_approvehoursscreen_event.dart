part of 'vf_approvehoursscreen_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///VfApprovehoursscreen widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class VfApprovehoursscreenEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the VfApprovehoursscreen widget is first created.
class VfApprovehoursscreenInitialEvent extends VfApprovehoursscreenEvent {
  @override
  List<Object?> get props => [];
}

// ignore_for_file: must_be_immutable
class UserprofilelistItemEvent extends VfApprovehoursscreenEvent {
  UserprofilelistItemEvent({required this.index, this.isSelectedSwitch});

  int index;

  bool? isSelectedSwitch;

  @override
  List<Object?> get props => [index, isSelectedSwitch];
}

///Event for changing switch

// ignore_for_file: must_be_immutable
class ChangeSwitchEvent extends VfApprovehoursscreenEvent {
  ChangeSwitchEvent({required this.value});

  bool value;

  @override
  List<Object?> get props => [value];
}
