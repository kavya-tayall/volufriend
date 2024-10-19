import 'package:equatable/equatable.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'package:collection/collection.dart'; // For deep list comparison

/// This class defines the variables used in the [vf_eventsignupscreen_screen],
/// and is typically used to hold data that is passed between different parts of the application.

class VfMyupcomingeventscreenModel extends Equatable {
  final List<Voluevents> orgEvent;

  const VfMyupcomingeventscreenModel({
    this.orgEvent = const [], // Default to empty list to avoid null issues
  });

  VfMyupcomingeventscreenModel copyWith({
    List<Voluevents>? orgEvent,
  }) {
    return VfMyupcomingeventscreenModel(
      orgEvent: orgEvent ?? this.orgEvent,
    );
  }

  @override
  List<Object?> get props => [const ListEquality().equals(orgEvent, orgEvent)];
}
