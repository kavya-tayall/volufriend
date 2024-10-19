import 'package:flutter/foundation.dart';

@immutable
class Picture {
  final String pictureId;
  final String pictureCaption;
  final String pictureUrl;
  final String? shiftId; // Optional field

  Picture({
    required this.pictureId,
    required this.pictureCaption,
    required this.pictureUrl,
    this.shiftId,
  });

  // Factory constructor to create an instance from JSON
  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      pictureId: json['picture_id'],
      pictureCaption: json['picture_caption'],
      pictureUrl: json['picture_url'],
      shiftId: json['shift_id'], // May be null
    );
  }

  // Method to convert an instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'picture_id': pictureId,
      'picture_caption': pictureCaption,
      'picture_url': pictureUrl,
      if (shiftId != null) 'shift_id': shiftId, // Only add if shiftId exists
    };
  }
}

class EventAlbum {
  final String albumId; // Added field
  final String eventId;
  final List<Picture> pictures; // List of Picture objects

  EventAlbum({
    required this.albumId, // Initialize albumId
    required this.eventId,
    required this.pictures,
  });

  // Factory constructor to create an instance from JSON
  factory EventAlbum.fromJson(String albumId, Map<String, dynamic> json) {
    return EventAlbum(
      albumId: albumId, // Pass albumId as parameter
      eventId: json['event_id'],
      pictures: (json['pictures'] as List)
          .map((picture) => Picture.fromJson(picture as Map<String, dynamic>))
          .toList(),
    );
  }

  // Method to convert an instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
      'pictures': pictures.map((picture) => picture.toJson()).toList(),
    };
  }
}

class EventAlbums {
  final Map<String, EventAlbum> albums; // Map with album ID as key

  EventAlbums({required this.albums});

  // Factory constructor to create an instance from JSON
  factory EventAlbums.fromJson(Map<String, dynamic> json) {
    return EventAlbums(
      albums: json.map((key, value) => MapEntry(
          key, EventAlbum.fromJson(key, value as Map<String, dynamic>))),
    );
  }

  // Method to convert an instance back to JSON
  Map<String, dynamic> toJson() {
    return albums.map((key, value) => MapEntry(key, value.toJson()));
  }
}
