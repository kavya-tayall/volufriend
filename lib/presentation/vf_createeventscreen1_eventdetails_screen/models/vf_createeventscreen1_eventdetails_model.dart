import 'package:equatable/equatable.dart';
import 'package:volufriend/crud_repository/models/causes.dart';
import 'package:volufriend/crud_repository/models/voluevents.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';

/// This class defines the variables used in the [vf_createeventscreen1_eventdetails_screen],
/// and is typically used to hold data that is passed between different parts of the application.

class VfCreateeventscreen1EventdetailsModel extends Equatable {
  final Voluevents? orgEvent;
  final List<causes> causesList; // List of cause options
  final List<EventHostingType>
      eventhostingoptions; // Ensure this type is defined correctly

  VfCreateeventscreen1EventdetailsModel({
    this.causesList = const [],
    this.orgEvent,
    this.eventhostingoptions = const [],
  });

  VfCreateeventscreen1EventdetailsModel copyWith({
    List<causes>? causesList,
    Voluevents? orgEvent,
    List<EventHostingType>? eventhostingoptions,
  }) {
    return VfCreateeventscreen1EventdetailsModel(
      causesList: causesList ?? this.causesList,
      eventhostingoptions: eventhostingoptions ?? this.eventhostingoptions,
      orgEvent: orgEvent ?? this.orgEvent,
    );
  }

  @override
  List<Object?> get props => [orgEvent, causesList, eventhostingoptions];
}
