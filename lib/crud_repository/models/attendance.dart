import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Attendance extends Equatable {
  final String attendanceId;
  final String singupId;
  final String userId;
  final String username; // Assuming 'username' is part of the JSON.
  final String organizationName;
  final String eventId;
  final String eventDate;
  final String eventName;
  final String shiftId;
  final String shiftName;
  final String coordinatorName;
  final String coordinatorEmail;
  final int hoursAttended;
  final int hoursApproved;
  final int hoursRejected;
  final bool isApproved; // Derived property
  final bool isRejected; // Derived property
  final String attendanceStatus;
  final String approvedByApproverId;
  final String rejectedByApproverId;

  Attendance({
    required this.attendanceId,
    required this.singupId,
    required this.userId,
    required this.username,
    required this.organizationName,
    required this.eventId,
    required this.eventDate,
    required this.eventName,
    required this.shiftId,
    required this.shiftName,
    required this.coordinatorName,
    required this.coordinatorEmail,
    required this.hoursAttended,
    required this.hoursApproved,
    required this.hoursRejected,
    required this.isApproved,
    required this.isRejected,
    required this.attendanceStatus,
    required this.approvedByApproverId,
    required this.rejectedByApproverId,
  });

  factory Attendance.fromJson({
    required Map<String, dynamic> json,
    required String? userId,
    required String? username,
    required String attendanceId,
  }) {
    return Attendance(
      attendanceId: attendanceId,
      singupId: json['signup_id'] as String? ??
          '', // Default to an empty string if null
      userId: json['user_id'] as String? ??
          '', // Default to an empty string if null
      username: json['volunteer_name'] as String? ??
          '', // Default to an empty string if null
      organizationName: json['organization_name'] as String? ??
          '', // Default to an empty string if null
      eventId: json['event_id'] as String? ??
          '', // Default to an empty string if null
      eventDate: json['event_date'] as String? ??
          '', // Default to an empty string if null
      eventName: json['event_name'] as String? ??
          '', // Default to an empty string if null
      shiftId: json['shift_id'] as String? ??
          '', // Default to an empty string if null
      shiftName: json['shift_name'] as String? ??
          '', // Default to an empty string if null
      coordinatorName: json['coordinator_name'] as String? ??
          '', // Default to an empty string if null
      coordinatorEmail: json['coordinator_email'] as String? ??
          '', // Default to an empty string if null
      hoursAttended:
          json['hours_attended'] as int? ?? 0, // Default to 0 if null
      hoursApproved:
          json['hours_approved'] as int? ?? 0, // Default to 0 if null
      hoursRejected:
          json['hours_rejected'] as int? ?? 0, // Default to 0 if null
      attendanceStatus: json['attendance_status'] as String? ??
          '', // Default to an empty string if null
      approvedByApproverId: json['approved_by_approver_id'] as String? ??
          '', // Default to an empty string if null
      rejectedByApproverId: json['rejected_by_approver_id'] as String? ??
          '', // Default to an empty string if null
      isApproved: json['attendance_status'] == 'approved' ||
          (json['hours_approved'] as int? ?? 0) > 0,
      isRejected: json['attendance_status'] == 'rejected' ||
          (json['hours_rejected'] as int? ?? 0) ==
              (json['hours_attended'] as int? ?? 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'approved_by_approver_id': approvedByApproverId,
      'attendance_status': attendanceStatus,
      'coordinator_email': coordinatorEmail,
      'coordinator_name': coordinatorName,
      'event_date': eventDate,
      'event_id': eventId,
      'event_name': eventName,
      'hours_approved': hoursApproved,
      'hours_attended': hoursAttended,
      'hours_rejected': hoursRejected,
      'organization_name': organizationName,
      'shift_id': shiftId,
      'shift_name': shiftName,
      'signup_id': singupId,
      'user_id': userId,
      'volunteer_name': username,
      'rejected_by_approver_id': rejectedByApproverId,
    };
  }

  // Convert a List<Attendance> to a JSON map with attendanceId as keys
  static Map<String, dynamic> listToJson(List<Attendance> attendances) {
    final Map<String, dynamic> result = {};
    for (var attendance in attendances) {
      result[attendance.attendanceId] = attendance.toJson();
    }
    return result;
  }

  static List<Attendance> convertJsonReponseToList(
      Map<String, dynamic> jsonMap) {
    List<Attendance> attendances = [];
    jsonMap.forEach((attendanceId, attendanceData) {
      attendances.add(Attendance.fromJson(
          json: attendanceData as Map<String, dynamic>,
          attendanceId: attendanceId,
          userId: '',
          username: ''));
    });
    return attendances;
  }

  @override
  List<Object?> get props => [
        attendanceId,
        singupId,
        userId,
        username,
        organizationName,
        eventId,
        eventDate,
        eventName,
        shiftId,
        shiftName,
        coordinatorName,
        coordinatorEmail,
        hoursAttended,
        hoursApproved,
        hoursRejected,
        isApproved,
        isRejected,
        attendanceStatus,
        approvedByApproverId,
        rejectedByApproverId,
      ];

  Attendance copyWith({
    String? attendanceId,
    String? singupId,
    String? userId,
    String? username,
    String? organizationName,
    String? eventId,
    String? eventDate,
    String? eventName,
    String? shiftId,
    String? shiftName,
    String? coordinatorName,
    String? coordinatorEmail,
    int? hoursAttended,
    int? hoursApproved,
    int? hoursRejected,
    bool? isApproved,
    bool? isRejected,
    String? attendanceStatus,
    String? approvedByApproverId,
    String? rejectedByApproverId,
  }) {
    return Attendance(
      attendanceId: attendanceId ?? this.attendanceId,
      singupId: singupId ?? this.singupId,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      organizationName: organizationName ?? this.organizationName,
      eventId: eventId ?? this.eventId,
      eventDate: eventDate ?? this.eventDate,
      eventName: eventName ?? this.eventName,
      shiftId: shiftId ?? this.shiftId,
      shiftName: shiftName ?? this.shiftName,
      coordinatorName: coordinatorName ?? this.coordinatorName,
      coordinatorEmail: coordinatorEmail ?? this.coordinatorEmail,
      hoursAttended: hoursAttended ?? this.hoursAttended,
      hoursApproved: hoursApproved ?? this.hoursApproved,
      hoursRejected: hoursRejected ?? this.hoursRejected,
      isApproved: isApproved ?? this.isApproved,
      isRejected: isRejected ?? this.isRejected,
      attendanceStatus: attendanceStatus ?? this.attendanceStatus,
      approvedByApproverId: approvedByApproverId ?? this.approvedByApproverId,
      rejectedByApproverId: rejectedByApproverId ?? this.rejectedByApproverId,
    );
  }

  // Method to extract attendance records from JSON
  static List<Attendance> fromJsonList(
      Map<String, dynamic> json, String? userId) {
    List<Attendance> attendanceList = [];

    json.forEach((key, value) {
      String username = json['volunteer_name'] as String? ?? ''; //
      if (value is Map<String, dynamic> && value['attendances'] != null) {
        // Ensure that attendances is a Map
        if (value['attendances'] is Map<String, dynamic>) {
          value['attendances'].forEach((attendanceKey, attendanceValue) {
            if (attendanceValue is Map<String, dynamic>) {
              attendanceList.add(Attendance.fromJson(
                  json: attendanceValue,
                  userId: userId,
                  username: username,
                  attendanceId: ''));
            } else {
              print(
                  'Invalid attendance data for key: $attendanceKey, value: $attendanceValue');
            }
          });
        } else {
          print('Invalid attendances data for key: $key, expected a Map');
        }
      } else {
        print('No attendances found for key: $key or value is not a Map');
      }
    });

    return attendanceList;
  }
}

@immutable
class Volunteer extends Equatable {
  final String volunteerId;
  final String userId;
  final String volunteerName;
  final String firstName;
  final String lastName;
  final Map<String, Attendance> attendances;

  Volunteer({
    required this.volunteerId,
    required this.userId,
    required this.volunteerName,
    required this.firstName,
    required this.lastName,
    required this.attendances,
  });

  factory Volunteer.fromJson(Map<String, dynamic> json, String volunteerId) {
    Map<String, Attendance> attendances = {};
    if (json['attendances'] != null) {
      json['attendances'].forEach((key, value) {
        attendances[key] = Attendance.fromJson(
            json: value,
            userId: json['user_id'] as String,
            username: json['volunteer_name'] as String,
            attendanceId: key);
      });
    }
    return Volunteer(
      volunteerId: volunteerId,
      userId: json['user_id'] as String,
      volunteerName: json['volunteer_name'] as String,
      firstName: json['First Name'] as String,
      lastName: json['Last Name'] as String,
      attendances: attendances,
    );
  }

  Volunteer copyWith({
    String? volunteerId,
    String? userId,
    String? volunteerName,
    String? firstName,
    String? lastName,
    Map<String, Attendance>? attendances,
  }) {
    return Volunteer(
      volunteerId: volunteerId ?? this.volunteerId,
      userId: userId ?? this.userId,
      volunteerName: volunteerName ?? this.volunteerName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      attendances: attendances ?? this.attendances,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'volunteer_name': volunteerName,
      'First Name': firstName,
      'Last Name': lastName,
      'attendances':
          attendances.map((key, value) => MapEntry(key, value.toJson())),
    };
  }

  @override
  List<Object?> get props => [
        volunteerId,
        userId,
        volunteerName,
        firstName,
        lastName,
        attendances,
      ];
}
