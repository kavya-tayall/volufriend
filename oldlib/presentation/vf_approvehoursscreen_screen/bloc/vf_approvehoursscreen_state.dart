part of 'vf_approvehoursscreen_bloc.dart';

/// Represents the state of VfApprovehoursscreen in the application.

// ignore_for_file: must_be_immutable
class VfApprovehoursscreenState extends Equatable {
  VfApprovehoursscreenState(
      {this.searchController,
      this.isSelectedSwitch = false,
      this.vfApprovehoursscreenModelObj});

  TextEditingController? searchController;

  VfApprovehoursscreenModel? vfApprovehoursscreenModelObj;

  bool isSelectedSwitch;

  @override
  List<Object?> get props =>
      [searchController, isSelectedSwitch, vfApprovehoursscreenModelObj];
  VfApprovehoursscreenState copyWith({
    TextEditingController? searchController,
    bool? isSelectedSwitch,
    VfApprovehoursscreenModel? vfApprovehoursscreenModelObj,
  }) {
    return VfApprovehoursscreenState(
      searchController: searchController ?? this.searchController,
      isSelectedSwitch: isSelectedSwitch ?? this.isSelectedSwitch,
      vfApprovehoursscreenModelObj:
          vfApprovehoursscreenModelObj ?? this.vfApprovehoursscreenModelObj,
    );
  }
}
