import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class Voluevents extends Equatable {
  final String eventId;
  final String? orgUserId;
  final String? address;
  final String? causeId;
  final Coordinator? coordinator;
  final DateTime? createdAt;
  final String? createdBy;
  final String? description;
  final DateTime? endDate;
  final String? eventAlbum;
  final String? eventStatus;
  final String? eventWebsite;
  final String? location;
  final String? title;
  final String? orgId;
  final DateTime? startDate;
  final DateTime? regByDate;
  final DateTime? updatedAt;
  final String? updatedBy;
  final EventAdditionalDetails? additionalDetails;
  List<Shift> shifts;
  final List<String>? EventHostingType;
  final String? orgName;
  final String? cause;
  final int? totalEventSignups;
  final int? totalEventCheckins;
  final String? parentOrg;

  Voluevents({
    required this.eventId,
    this.orgUserId,
    this.address,
    this.causeId,
    this.coordinator,
    this.createdAt,
    this.createdBy,
    this.description,
    this.endDate,
    this.eventAlbum,
    this.eventStatus,
    this.eventWebsite,
    this.location,
    this.title,
    this.orgId,
    this.startDate,
    this.regByDate,
    this.updatedAt,
    this.updatedBy,
    this.additionalDetails,
    this.EventHostingType,
    this.orgName,
    this.cause,
    this.totalEventSignups,
    this.totalEventCheckins,
    this.parentOrg,
    List<Shift>? shifts, // Allow null but provide a default empty list
  }) : shifts = shifts ?? <Shift>[];

  factory Voluevents.fromJson(Map<String, dynamic> json, String eventId) {
    String? orgUserId;
    String? address;
    String? causeId;
    Coordinator? coordinator;
    DateTime? createdAt;
    String? createdBy;
    String? description;
    DateTime? endDate;
    String? eventAlbum;
    String? eventStatus;
    String? eventWebsite;
    String? location;
    String? title;
    String? orgId;
    DateTime? startDate;
    DateTime? updatedAt;
    String? updatedBy;
    EventAdditionalDetails? additionalDetails;
    String? orgName;
    String? cause;
    List<Shift> shifts = [];
    List<String>? eventHostingType;
    int? totalEventSignups;
    int? totalEventCheckins;
    String parentOrg;

    try {
      orgUserId = json['event']?['org_user_id'] as String?;
    } catch (e) {
      print('Error parsing org_user_id: $e');
    }

    try {
      address = json['event']?['address'] as String?;
    } catch (e) {
      print('Error parsing address: $e');
    }

    try {
      causeId = json['event']?['cause_id'] as String?;
    } catch (e) {
      print('Error parsing cause_id: $e');
    }

    try {
      coordinator = json['event']?['coordinator'] != null
          ? Coordinator.fromJson(
              json['event']?['coordinator'] as Map<String, dynamic>)
          : null;
    } catch (e) {
      print('Error parsing coordinator: $e');
    }

    try {
      createdAt = json['event']?['created_at'] != null
          ? DateTime.tryParse(json['event']?['created_at'] as String ?? '')
          : null;
    } catch (e) {
      print('Error parsing created_at: $e');
    }

    try {
      createdBy = json['event']?['created_by'] as String?;
    } catch (e) {
      print('Error parsing created_by: $e');
    }

    try {
      description = json['event']?['description'] as String?;
    } catch (e) {
      print('Error parsing description: $e');
    }

    try {
      endDate = json['event']?['end_date'] != null
          ? DateTime.tryParse(json['event']?['end_date'] as String ?? '')
          : null;
    } catch (e) {
      print('Error parsing end_date: $e');
    }

    try {
      eventAlbum = json['event']?['event_album'] as String?;
    } catch (e) {
      print('Error parsing event_album: $e');
    }

    try {
      eventStatus = json['event']?['event_status'] as String?;
    } catch (e) {
      print('Error parsing event_status: $e');
    }

    try {
      eventWebsite = json['event']?['event_website'] as String?;
    } catch (e) {
      print('Error parsing event_website: $e');
    }

    try {
      location = json['event']?['location'] as String?;
    } catch (e) {
      print('Error parsing location: $e');
    }

    try {
      title = json['event']?['title'] as String?;
    } catch (e) {
      print('Error parsing title: $e');
    }

    try {
      orgId = json['event']?['org_id'] as String?;
    } catch (e) {
      print('Error parsing org_id: $e');
    }

    try {
      startDate = json['event']?['start_date'] != null
          ? DateTime.tryParse(json['event']?['start_date'] as String ?? '')
          : null;
    } catch (e) {
      print('Error parsing start_date: $e');
    }

    try {
      updatedAt = json['event']?['updated_at'] != null
          ? DateTime.tryParse(json['event']?['updated_at'] as String ?? '')
          : null;
    } catch (e) {
      print('Error parsing updated_at: $e');
    }

    try {
      updatedBy = json['event']?['updated_by'] as String?;
    } catch (e) {
      print('Error parsing updated_by: $e');
    }

    try {
      orgName = json['event']?['org_name'] as String?;
    } catch (e) {
      print('Error parsing org_name: $e');
    }

    try {
      cause = json['event']?['cause'] as String?;
    } catch (e) {
      print('Error parsing cause: $e');
    }
    try {
      additionalDetails = json['event']?['additional_details'] != null
          ? EventAdditionalDetails.fromJson(
              json['event']?['additional_details'] as Map<String, dynamic>)
          : null;
    } catch (e) {
      print('Error parsing additional_details: $e');
    }

    try {
      totalEventSignups = json['event']?['total_signups'] != null
          ? json['event']['total_signups'] as int
          : 0;
    } catch (e) {
      print('Error parsing total_signups: $e');
      totalEventSignups = 0; // Provide a default value in case of an error
    }

    try {
      totalEventCheckins = json['event']?['total_checkins'] != null
          ? json['event']['total_checkins'] as int
          : 0;
    } catch (e) {
      print('Error parsing total_checkins: $e');
      totalEventCheckins = 0; // Provide a default value in case of an error
    }

    try {
      shifts = json['shifts'] != null
          ? (json['shifts'] as List<dynamic>)
              .map((shiftJson) {
                try {
                  return Shift.fromJson(shiftJson as Map<String, dynamic>);
                } catch (e) {
                  print('Error parsing individual shift: $e');
                  return null;
                }
              })
              .where((shift) => shift != null)
              .cast<Shift>()
              .toList()
          : [];
    } catch (e) {
      print('Error parsing shifts: $e');
    }

    try {
      eventHostingType = json['event']?['event_hosting_type'] != null
          ? List<String>.from(
              json['event']?['event_hosting_type'] as List<dynamic>)
          : null;
    } catch (e) {
      print('Error parsing event_hosting_type: $e');
    }

    try {
      parentOrg = json['parent_org'] as String? ?? '';
    } catch (e) {
      print('Error parsing parent_org: $e');
      parentOrg = ''; // Provide a default value in case of an error
    }
    // Return the Voluevents object with any successfully parsed values
    return Voluevents(
      eventId: eventId,
      orgUserId: orgUserId,
      address: address,
      causeId: causeId,
      coordinator: coordinator,
      createdAt: createdAt,
      createdBy: createdBy,
      description: description,
      endDate: endDate,
      eventAlbum: eventAlbum,
      eventStatus: eventStatus,
      eventWebsite: eventWebsite,
      location: location,
      title: title,
      orgId: orgId,
      startDate: startDate,
      updatedAt: updatedAt,
      updatedBy: updatedBy,
      additionalDetails: additionalDetails,
      shifts: shifts,
      EventHostingType: eventHostingType,
      orgName: orgName,
      cause: cause,
      totalEventSignups: totalEventSignups,
      totalEventCheckins: totalEventCheckins,
      parentOrg: parentOrg,
    );
  }

  Map<String, dynamic> toJson() {
    print('Event ID: $eventId');
    print('parentOrg: $parentOrg');
    return {
      'event_id': eventId,
      'org_user_id': orgUserId,
      'address': address,
      'cause_id': causeId,
      'coordinator': coordinator?.toJson(),
      'created_at': createdAt?.toIso8601String(),
      'created_by': createdBy,
      'description': description,
      'end_date': endDate?.toIso8601String(),
      'event_album': eventAlbum,
      'event_status': eventStatus,
      'event_website': eventWebsite,
      'location': location,
      'title': title,
      'org_id': orgId,
      'start_date': startDate?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'updated_by': updatedBy,
      'additional_details': additionalDetails?.toJson(),
      'shifts': shifts.map((shift) => shift.toJson()).toList(),
      'event_hosting_type': EventHostingType,
      'org_name': orgName,
      'cause': cause,
      'total_signups': totalEventSignups,
      'total_checkins': totalEventCheckins,
      'parent_org': parentOrg,
    };
  }

  @override
  List<Object?> get props => [
        eventId,
        orgUserId,
        address,
        causeId,
        coordinator,
        createdAt,
        createdBy,
        description,
        endDate,
        eventAlbum,
        eventStatus,
        eventWebsite,
        location,
        title,
        orgId,
        startDate,
        regByDate,
        updatedAt,
        updatedBy,
        additionalDetails,
        shifts,
        EventHostingType,
        orgName,
        cause,
        totalEventSignups,
        totalEventCheckins,
        parentOrg,
      ];
}

@immutable
class Coordinator extends Equatable {
  final String? email;
  final String? name;
  final String? phone;

  const Coordinator({this.email, this.name, this.phone});

  // Factory constructor to create an instance from JSON
  factory Coordinator.fromJson(Map<String, dynamic> json) {
    return Coordinator(
      email: json['email'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
    );
  }

  // Method to convert an instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
    };
  }

  @override
  List<Object?> get props => [email, name, phone];
}

@immutable
class EventAdditionalDetails extends Equatable {
  final String? accessibilityInfo;
  final int? actualCost;
  final int? budget;
  final String? cancellationPolicy;
  final String? charityBeneficiary;
  final String? dressCode;
  final List<String>? equipmentNeeded;
  final String? eventFrequency;
  final List<String>? eventPhotos;
  final String? eventType;
  final String? eventVisibility;
  final String? feedbackLink;
  final bool? feedbackRequired;
  final ImpactMetrics? impactMetrics;
  final bool? mealsProvided;
  final bool? notificationSent;
  final String? postEventReport;
  final String? sponsor;
  final List<String>? tags;
  final String? transportationDetails;

  const EventAdditionalDetails({
    this.accessibilityInfo,
    this.actualCost,
    this.budget,
    this.cancellationPolicy,
    this.charityBeneficiary,
    this.dressCode,
    this.equipmentNeeded,
    this.eventFrequency,
    this.eventPhotos,
    this.eventType,
    this.eventVisibility,
    this.feedbackLink,
    this.feedbackRequired,
    this.impactMetrics,
    this.mealsProvided,
    this.notificationSent,
    this.postEventReport,
    this.sponsor,
    this.tags,
    this.transportationDetails,
  });

  factory EventAdditionalDetails.fromJson(Map<String, dynamic> json) {
    return EventAdditionalDetails(
      accessibilityInfo: json['accessibility_info'] as String?,
      actualCost:
          json['actual_cost'] != null ? json['actual_cost'] as int : null,
      budget: json['budget'] != null ? json['budget'] as int : null,
      cancellationPolicy: json['cancellation_policy'] as String?,
      charityBeneficiary: json['charity_beneficiary'] as String?,
      dressCode: json['dress_code'] as String?,
      equipmentNeeded: (json['equipment_needed'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      eventFrequency: json['event_frequency'] as String?,
      eventPhotos: (json['event_photos'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      eventType: json['event_type'] as String?,
      eventVisibility: json['event_visibility'] as String?,
      feedbackLink: json['feedback_link'] as String?,
      feedbackRequired: json['feedback_required'] as bool?,
      impactMetrics: json['impact_metrics'] != null
          ? ImpactMetrics.fromJson(
              json['impact_metrics'] as Map<String, dynamic>)
          : null,
      mealsProvided: json['meals_provided'] as bool?,
      notificationSent: json['notification_sent'] as bool?,
      postEventReport: json['post_event_report'] as String?,
      sponsor: json['sponsor'] as String?,
      tags: (json['tags'] as List<dynamic>?)
          ?.map((item) => item as String)
          .toList(),
      transportationDetails: json['transportation_details'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessibility_info': accessibilityInfo,
      'actual_cost': actualCost,
      'budget': budget,
      'cancellation_policy': cancellationPolicy,
      'charity_beneficiary': charityBeneficiary,
      'dress_code': dressCode,
      'equipment_needed': equipmentNeeded,
      'event_frequency': eventFrequency,
      'event_photos': eventPhotos,
      'event_type': eventType,
      'event_visibility': eventVisibility,
      'feedback_link': feedbackLink,
      'feedback_required': feedbackRequired,
      'impact_metrics': impactMetrics?.toJson(),
      'meals_provided': mealsProvided,
      'notification_sent': notificationSent,
      'post_event_report': postEventReport,
      'sponsor': sponsor,
      'tags': tags,
      'transportation_details': transportationDetails,
    };
  }

  @override
  List<Object?> get props => [
        accessibilityInfo,
        actualCost,
        budget,
        cancellationPolicy,
        charityBeneficiary,
        dressCode,
        equipmentNeeded,
        eventFrequency,
        eventPhotos,
        eventType,
        eventVisibility,
        feedbackLink,
        feedbackRequired,
        impactMetrics,
        mealsProvided,
        notificationSent,
        postEventReport,
        sponsor,
        tags,
        transportationDetails,
      ];
}

@immutable
class Shift extends Equatable {
  final String? shiftId; // Nullable as it's generated on the server
  final DateTime? createdAt; // Nullable if not provided during creation
  final DateTime endTime; // Required field
  final String? eventId; // Nullable if not available at the time of creation
  final int? minAge; // Nullable if not provided during creation
  final int? numberOfParticipants; // Nullable, defaults to 0
  final DateTime startTime; // Required field
  final DateTime? updatedAt; // Nullable, may not be set initially
  final String? createdBy; // Nullable as it might not be set at creation time
  final String? updatedBy; // Nullable, may not be set initially
  final int? maxNumberOfParticipants; // Nullable, defaults to 0
  final String
      activity; // Required field, corrected to lowercase for consistency
  final int? totalSignups;
  final int? totalCheckins;

  const Shift({
    this.shiftId, // Nullable
    this.createdAt, // Nullable
    required this.endTime, // Required
    this.eventId, // Nullable
    this.minAge, // Nullable
    this.numberOfParticipants = 0, // Default to 0
    required this.startTime, // Required
    this.updatedAt, // Nullable
    this.createdBy, // Nullable
    this.updatedBy, // Nullable
    this.maxNumberOfParticipants = 0, // Default to 0
    required this.activity, // Required
    this.totalSignups,
    this.totalCheckins,
  });

  factory Shift.fromJson(Map<String, dynamic> json) {
    return Shift(
      shiftId: json['shift_id'] as String?, // Nullable, from server
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null, // Nullable
      endTime: () {
        String endTimeString = json['end_time'] as String;

        // Check if the string contains date information
        if (endTimeString.contains('T') || endTimeString.contains('-')) {
          // Parse as full date-time
          DateTime parsedDateTime = DateTime.parse(endTimeString);
          return parsedDateTime;
        } else {
          // Parse as time only (assuming today's date)
          return DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            int.parse(endTimeString.split(":")[0]), // Hours
            int.parse(endTimeString.split(":")[1]), // Minutes
          );
        }
      }(), // Required
      eventId: json['event_id'] as String?, // Nullable
      minAge: json['min_age'] != null
          ? int.tryParse(json['min_age'].toString()) ?? 0
          : null, // Convert string to int
      numberOfParticipants: json['number_of_participants'] != null
          ? int.tryParse(json['number_of_participants'].toString()) ?? 0
          : 0, // Defaults to 0 if not provided

      startTime: () {
        String startTimeString = json['start_time'] as String;

        // Check if the string contains date information
        if (startTimeString.contains('T') || startTimeString.contains('-')) {
          // Parse as full date-time
          DateTime parsedDateTime = DateTime.parse(startTimeString);
          return parsedDateTime;
        } else {
          // Parse as time only (assuming today's date)
          return DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            int.parse(startTimeString.split(":")[0]), // Hours
            int.parse(startTimeString.split(":")[1]), // Minutes
          );
        }
      }(),
      // Required
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null, // Nullable
      createdBy: json['created_by'] as String?, // Nullable
      updatedBy: json['updated_by'] as String?, // Nullable
      maxNumberOfParticipants: json['max_number_of_participants'] != null
          ? int.tryParse(json['max_number_of_participants'].toString()) ?? 0
          : 0, // Defaults to 0 if not provided
      activity: json['activity'] as String, // Required, corrected case
      totalCheckins: json['total_checkins'] as int?,
      totalSignups: json['total_signups'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shift_id': shiftId, // Nullable
      'created_at': createdAt?.toIso8601String(), // Nullable
      'end_time': endTime.toIso8601String(), // Required
      'event_id': eventId, // Nullable
      'min_age': minAge, // Nullable
      'number_of_participants': numberOfParticipants, // Defaults to 0
      'start_time': startTime.toIso8601String(), // Required
      'updated_at': updatedAt?.toIso8601String(), // Nullable
      'created_by': createdBy, // Nullable
      'updated_by': updatedBy, // Nullable
      'max_number_of_participants': maxNumberOfParticipants, // Defaults to 0
      'activity': activity, // Required, corrected case
      'total_checkins': totalCheckins,
      'total_signups': totalSignups,
    };
  }

  @override
  List<Object?> get props => [
        shiftId,
        createdAt,
        endTime,
        eventId,
        minAge,
        numberOfParticipants,
        startTime,
        updatedAt,
        createdBy,
        updatedBy,
        maxNumberOfParticipants,
        activity,
        totalCheckins,
        totalSignups,
      ];
}

@immutable
class ImpactMetrics extends Equatable {
  final String? metricType;
  final String? metricValue;

  const ImpactMetrics({this.metricType, this.metricValue});

  factory ImpactMetrics.fromJson(Map<String, dynamic> json) {
    return ImpactMetrics(
      metricType: json['metric_type'] as String?,
      metricValue: json['metric_value'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metric_type': metricType,
      'metric_value': metricValue,
    };
  }

  @override
  List<Object?> get props => [metricType, metricValue];
}

// New method to parse the entire response
List<Voluevents> parseVolueventsResponse(Map<String, dynamic> jsonResponse) {
  return jsonResponse.entries.map((entry) {
    return Voluevents.fromJson(entry.value as Map<String, dynamic>, entry.key);
  }).toList();
}
