import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import 'userprofilelist_item_model.dart';

/// This class defines the variables used in the [vf_approvehoursscreen_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class VfApprovehoursscreenModel extends Equatable {
  VfApprovehoursscreenModel({this.userprofilelistItemList = const []});

  List<UserprofilelistItemModel> userprofilelistItemList;

  VfApprovehoursscreenModel copyWith(
      {List<UserprofilelistItemModel>? userprofilelistItemList}) {
    return VfApprovehoursscreenModel(
      userprofilelistItemList:
          userprofilelistItemList ?? this.userprofilelistItemList,
    );
  }

  @override
  List<Object?> get props => [userprofilelistItemList];
}
