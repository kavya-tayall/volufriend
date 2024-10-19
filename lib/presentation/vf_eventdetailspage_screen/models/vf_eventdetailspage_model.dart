import 'package:equatable/equatable.dart';
import 'listtitlesmall_item_model.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';

/// This class defines the variables used in the [vf_eventsignupscreen_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class VfEventdetailspageModel extends Equatable {
  final Voluevents? orgEvent;

  const VfEventdetailspageModel({
    this.orgEvent,
  });

  VfEventdetailspageModel copyWith({
    Voluevents? orgEvent,
  }) {
    return VfEventdetailspageModel(
      orgEvent: orgEvent ?? this.orgEvent,
    );
  }

  @override
  List<Object?> get props => [orgEvent];
}
