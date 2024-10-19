import 'package:equatable/equatable.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'package:collection/collection.dart'; // For deep list comparison

class VfVolunteeringcalendarpageModel extends Equatable {
  final List<Voluevents> eventsList;

  const VfVolunteeringcalendarpageModel({
    this.eventsList = const [], // Default to empty list to avoid null issues
  });

  VfVolunteeringcalendarpageModel copyWith({
    List<Voluevents>? eventsList,
  }) {
    return VfVolunteeringcalendarpageModel(
      eventsList: eventsList ?? this.eventsList,
    );
  }

  @override
  List<Object?> get props =>
      [const ListEquality().equals(eventsList, eventsList)];
}
