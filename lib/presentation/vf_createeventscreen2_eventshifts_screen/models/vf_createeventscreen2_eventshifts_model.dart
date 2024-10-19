import 'package:equatable/equatable.dart';
import 'package:volufriend/crud_repository/models/voluevents.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart'; // Ensure this is correctly referenced

/// Represents the state for the VfCreateeventscreen2Eventshifts screen.
/// It holds data related to event shifts, including the event itself and a list of shifts.
class VfCreateeventscreen2EventshiftsModel extends Equatable {
  /// The event associated with the shifts.
  final String? eventId;

  /// A list of shifts associated with the event.
  final List<Shift> eventShifts;

  /// Creates an instance of [VfCreateeventscreen2EventshiftsModel].
  VfCreateeventscreen2EventshiftsModel({
    this.eventId,
    this.eventShifts = const [],
  });

  /// Creates a copy of this model with the option to override existing values.
  VfCreateeventscreen2EventshiftsModel copyWith({
    String? eventId,
    List<Shift>? eventShifts,
  }) {
    return VfCreateeventscreen2EventshiftsModel(
      eventId: eventId ?? this.eventId,
      eventShifts: eventShifts ?? this.eventShifts,
    );
  }

  @override
  List<Object?> get props => [eventId, eventShifts];
}
