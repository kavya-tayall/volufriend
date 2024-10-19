import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';

/// This class is used in the [userprofilelist_item_widget] screen.

// ignore_for_file: must_be_immutable
class UserprofilelistItemModel extends Equatable {
  UserprofilelistItemModel(
      {this.closeImage,
      this.personName,
      this.orgName,
      this.hoursAttended,
      this.subtitleText,
      this.isSelectedSwitch,
      this.id}) {
    closeImage = closeImage ?? ImageConstant.imgCloseIndigoA400;
    personName = personName ?? "Alberto";
    orgName = orgName ?? "Bothell High School";
    hoursAttended = hoursAttended ?? "10";
    subtitleText = subtitleText ?? "Approve";
    isSelectedSwitch = isSelectedSwitch ?? false;
    id = id ?? "";
  }

  String? closeImage;

  String? personName;

  String? orgName;

  String? hoursAttended;

  String? subtitleText;

  bool? isSelectedSwitch;

  String? id;

  UserprofilelistItemModel copyWith({
    String? closeImage,
    String? personName,
    String? orgName,
    String? hoursAttended,
    String? subtitleText,
    bool? isSelectedSwitch,
    String? id,
  }) {
    return UserprofilelistItemModel(
      closeImage: closeImage ?? this.closeImage,
      personName: personName ?? this.personName,
      orgName: orgName ?? this.orgName,
      hoursAttended: hoursAttended ?? this.hoursAttended,
      subtitleText: subtitleText ?? this.subtitleText,
      isSelectedSwitch: isSelectedSwitch ?? this.isSelectedSwitch,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [
        closeImage,
        personName,
        orgName,
        hoursAttended,
        subtitleText,
        isSelectedSwitch,
        id
      ];
}
