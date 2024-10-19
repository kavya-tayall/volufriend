import 'package:equatable/equatable.dart';
import 'listtitlesmall_item_model.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';

/// This class defines the variables used in the [vf_eventsignupscreen_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class VfEventsignupscreenModel extends Equatable {
  final List<ListtitlesmallItemModel> listtitlesmallItemList;
  final Voluevents? orgEvent;

  const VfEventsignupscreenModel({
    this.listtitlesmallItemList = const [],
    this.orgEvent,
  });

  VfEventsignupscreenModel copyWith({
    List<ListtitlesmallItemModel>? listtitlesmallItemList,
    Voluevents? orgEvent,
  }) {
    return VfEventsignupscreenModel(
      listtitlesmallItemList:
          listtitlesmallItemList ?? this.listtitlesmallItemList,
      orgEvent: orgEvent ?? this.orgEvent,
    );
  }

  @override
  List<Object?> get props => [listtitlesmallItemList, orgEvent];
}
