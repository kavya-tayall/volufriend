class NotificationModel {
  final String dbid;
  final String id;
  final String userId;
  final String eventId;
  final String title;
  final String message;
  bool isRead;

  NotificationModel({
    required this.dbid,
    required this.id,
    required this.eventId,
    required this.userId,
    required this.title,
    required this.message,
    this.isRead = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'dbid': dbid,
      'id': id,
      'userId': userId,
      'eventId': eventId,
      'title': title,
      'message': message,
      'isRead': isRead,
    };
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json,
      {String? dbid}) {
    return NotificationModel(
      dbid: dbid ?? '',
      id: json.containsKey('id')
          ? (json['id'] ?? '')
          : '', // Check if 'id' exists and handle null
      userId: json.containsKey('userId')
          ? (json['userId'] ?? '')
          : '', // Check if 'userId' exists and handle null
      eventId: json.containsKey('eventId')
          ? (json['eventId'] ?? '')
          : '', // Check if 'eventId' exists and handle null
      title: json.containsKey('title')
          ? (json['title'] ?? '')
          : '', // Check if 'title' exists and handle null
      message: json.containsKey('message')
          ? (json['message'] ?? '')
          : '', // Check if 'message' exists and handle null
      isRead: json.containsKey('isRead')
          ? (json['isRead'] is bool
              ? json['isRead']
              : false) // Check if 'isRead' is a boolean
          : false, // Check if 'isRead' exists and handle null
    );
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      dbid: map['dbid'] ?? '',
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      eventId: map['eventId'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      isRead: map['isRead'] is bool
          ? map['isRead']
          : false, // Check if 'isRead' is a boolean
    );
  }

  // Method to convert an instance of NotificationModel to a Map
  Map<String, dynamic> toMap() {
    return {
      'dbid': dbid,
      'id': id,
      'userId': userId,
      'eventId': eventId,
      'title': title,
      'message': message,
      'isRead': isRead,
    };
  }
}
