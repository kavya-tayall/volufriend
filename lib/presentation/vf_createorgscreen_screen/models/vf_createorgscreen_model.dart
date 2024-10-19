import 'package:equatable/equatable.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '/crud_repository/volufriend_crud_repo.dart';

/// This class defines the variables used in the [vf_createorgscreen_screen],
/// and is typically used to hold data that is passed between different parts of the application.

// ignore_for_file: must_be_immutable
class VfCreateorgscreenModel extends Equatable {
  final Organization? organizationProfile;
  final List<causes> causesList; // List of cause options

  VfCreateorgscreenModel({
    this.organizationProfile,
    this.causesList = const [],
  });

  VfCreateorgscreenModel copyWith({
    Organization? organizationProfile,
    List<causes>? causesList,
  }) {
    return VfCreateorgscreenModel(
      organizationProfile: organizationProfile ?? this.organizationProfile,
      causesList: causesList ?? this.causesList,
    );
  }

  @override
  List<Object?> get props => [organizationProfile, causesList];
}
