import 'package:equatable/equatable.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'package:collection/collection.dart'; // For deep list comparison

/// This class defines the variables used in the [vf_eventsignupscreen_screen],
/// and is typically used to hold data that is passed between different parts of the application.

class VfVolunteerProfilescreenModel extends Equatable {
  final String userId;
  final NewVolufrienduser volunteerUser; // Fixed variable name
  final int totalEvents;
  final int totalOrganizationsAssociated;
  final int totalVolunteeringHours;
  final int lastThirtyDaysHours;

  const VfVolunteerProfilescreenModel({
    this.userId = '',
    required this.volunteerUser, // Mark as required or provide default
    this.totalEvents = 0,
    this.totalOrganizationsAssociated = 0,
    this.totalVolunteeringHours = 0,
    this.lastThirtyDaysHours = 0,
  });

  VfVolunteerProfilescreenModel copyWith({
    String? userId,
    NewVolufrienduser? volunteerUser, // Updated name here too
    int? totalEvents,
    int? totalOrganizationsAssociated,
    int? totalVolunteeringHours,
    int? lastThirtyDaysHours,
  }) {
    return VfVolunteerProfilescreenModel(
      userId: userId ?? this.userId,
      volunteerUser: volunteerUser ?? this.volunteerUser, // Correct variable
      totalEvents: totalEvents ?? this.totalEvents,
      totalOrganizationsAssociated:
          totalOrganizationsAssociated ?? this.totalOrganizationsAssociated,
      totalVolunteeringHours:
          totalVolunteeringHours ?? this.totalVolunteeringHours,
      lastThirtyDaysHours: lastThirtyDaysHours ?? this.lastThirtyDaysHours,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        volunteerUser,
        totalEvents,
        totalOrganizationsAssociated,
        totalVolunteeringHours,
        lastThirtyDaysHours,
      ]; // Include all fields in the props for equality check
}
