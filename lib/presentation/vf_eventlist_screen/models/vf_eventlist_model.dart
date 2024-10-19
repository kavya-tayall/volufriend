import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../../vf_homescreen_page/models/upcomingeventslist_item_model.dart';

/// This class defines the variables used in the [vf_homescreen_page],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class VfEventListModel extends Equatable {
  VfEventListModel({
    this.upcomingeventslistItemList = const [],
  });

  List<UpcomingeventslistItemModel> upcomingeventslistItemList;

  VfEventListModel copyWith({
    List<UpcomingeventslistItemModel>? upcomingeventslistItemList,
  }) {
    return VfEventListModel(
      upcomingeventslistItemList:
          upcomingeventslistItemList ?? this.upcomingeventslistItemList,
    );
  }

  VfEventListModel removeEventById(String eventId) {
    // Create a new list without the event with the specified eventId
    final updatedList =
        upcomingeventslistItemList.where((item) => item.id != eventId).toList();
    return VfEventListModel(upcomingeventslistItemList: updatedList);
  }

  @override
  List<Object?> get props => [upcomingeventslistItemList];
}
