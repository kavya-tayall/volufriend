import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';

/// This class is used in the [userprofilelist_item_widget] screen.

// ignore_for_file: must_be_immutable
class UserprofilelistItemModel extends Equatable {
  String closeImage;
  String personName;
  String orgName;
  int hoursAttended;
  int hoursApproved; // New field to track approved hours
  String subtitleText;
  bool isSelectedSwitch;
  bool isApproved;
  bool isRejected;
  String id;

  UserprofilelistItemModel({
    String? closeImage,
    this.personName = "Alberto",
    this.orgName = "Bothell High School",
    this.hoursAttended = 10,
    this.hoursApproved = 0, // Initialized to 0 by default
    this.subtitleText = "Approve",
    this.isSelectedSwitch = false,
    this.isApproved = false,
    this.isRejected = false,
    this.id = "",
  }) : closeImage = closeImage ?? ImageConstant.imgCloseIndigoA400;

  UserprofilelistItemModel copyWith({
    String? closeImage,
    String? personName,
    String? orgName,
    int? hoursAttended,
    int? hoursApproved, // Optional updated field
    String? subtitleText,
    bool? isSelectedSwitch,
    bool? isApproved,
    bool? isRejected,
    String? id,
  }) {
    return UserprofilelistItemModel(
      closeImage: closeImage ?? this.closeImage,
      personName: personName ?? this.personName,
      orgName: orgName ?? this.orgName,
      hoursAttended: hoursAttended ?? this.hoursAttended,
      hoursApproved:
          hoursApproved ?? this.hoursApproved, // Handles approved hours update
      subtitleText: subtitleText ?? this.subtitleText,
      isSelectedSwitch: isSelectedSwitch ?? this.isSelectedSwitch,
      isApproved: isApproved ?? this.isApproved,
      isRejected: isRejected ?? this.isRejected,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [
        closeImage,
        personName,
        orgName,
        hoursAttended,
        hoursApproved, // Added to equality check
        subtitleText,
        isSelectedSwitch,
        isApproved,
        isRejected,
        id,
      ];
}
