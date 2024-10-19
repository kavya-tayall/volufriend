import 'package:equatable/equatable.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'package:collection/collection.dart'; // For deep list comparison

/// This class defines the variables used in the [vf_eventsignupscreen_screen],
/// and is typically used to hold data that is passed between different parts of the application.

class VfUserattendancereportpageModel extends Equatable {
  final List<Attendance> userAttendance;

  const VfUserattendancereportpageModel({
    this.userAttendance =
        const [], // Default to empty list to avoid null issues
  });

  VfUserattendancereportpageModel copyWith({
    List<Attendance>? userAttendance,
  }) {
    return VfUserattendancereportpageModel(
      userAttendance: userAttendance ?? this.userAttendance,
    );
  }

  @override
  List<Object?> get props =>
      [const ListEquality().equals(userAttendance, userAttendance)];
}
