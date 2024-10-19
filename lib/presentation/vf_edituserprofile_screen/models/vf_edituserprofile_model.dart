import 'package:equatable/equatable.dart';
import 'package:volufriend/crud_repository/models/genderoptions.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '/crud_repository/volufriend_crud_repo.dart';

/// This class defines the variables used in the [vf_edituserprofile_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class VfEdituserprofileModel extends Equatable {
  final NewVolufrienduser? userProfile;
  final List<causes> causesList; // List of cause options
  final List<Organization>
      organizationList; // List of home organization options
  final List<GenderOptions> genderoptions;

  VfEdituserprofileModel({
    this.genderoptions = const [],
    this.userProfile,
    this.causesList = const [],
    this.organizationList = const [],
  });

  VfEdituserprofileModel copyWith({
    List<GenderOptions>? genderoptions,
    NewVolufrienduser? userProfile,
    List<causes>? causesList,
    List<Organization>? organizationList,
  }) {
    return VfEdituserprofileModel(
      genderoptions: genderoptions ?? this.genderoptions,
      userProfile: userProfile ?? this.userProfile,
      causesList: causesList ?? this.causesList,
      organizationList: organizationList ?? this.organizationList,
    );
  }

  @override
  List<Object?> get props =>
      [genderoptions, userProfile, causesList, organizationList];
}
