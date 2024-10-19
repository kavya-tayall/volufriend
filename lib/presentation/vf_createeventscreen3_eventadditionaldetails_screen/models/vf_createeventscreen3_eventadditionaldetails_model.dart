import 'package:equatable/equatable.dart';
import 'package:volufriend/crud_repository/models/voluevents.dart'; // Ensure this is correctly referenced
import 'package:image_field/image_field.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';

/// This class defines the variables used in the [vf_createeventscreen3_eventadditionaldetails_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class VfCreateEventScreen3EventAdditionalDetailsModel extends Equatable {
  final String? eventId;
  final List<ImageAndCaptionModel>
      eventImageList; // List of image URLs or asset paths
  final Coordinator? coordinator;
  final String? description;
  final String? eventAlbumId;
  final EventAlbum? eventAlbum;

  VfCreateEventScreen3EventAdditionalDetailsModel({
    this.eventId,
    this.eventImageList = const [],
    this.coordinator,
    this.description,
    this.eventAlbumId,
    this.eventAlbum,
  });

  VfCreateEventScreen3EventAdditionalDetailsModel copyWith({
    String? eventId,
    String? eventAlbumId,
    List<ImageAndCaptionModel>? eventImageList,
    Coordinator? coordinator,
    String? description,
    EventAlbum? eventAlbum,
  }) {
    return VfCreateEventScreen3EventAdditionalDetailsModel(
      eventId: eventId ?? this.eventId,
      eventImageList: eventImageList ?? this.eventImageList,
      coordinator: coordinator ?? this.coordinator,
      description: description ?? this.description,
      eventAlbumId: eventAlbumId ?? this.eventAlbumId,
      eventAlbum: eventAlbum ?? this.eventAlbum,
    );
  }

  @override
  List<Object?> get props => [
        eventId,
        eventImageList,
        coordinator,
        description,
        eventAlbumId,
        eventAlbum,
      ];
}
