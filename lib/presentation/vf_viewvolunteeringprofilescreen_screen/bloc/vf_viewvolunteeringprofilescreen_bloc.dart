import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../../../presentation/vf_viewvolunteeringprofilescreen_screen/models/vf_viewvolunteeringprofilescreen_model.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';

part 'vf_viewvolunteeringprofilescreen_event.dart';
part 'vf_viewvolunteeringprofilescreen_state.dart';

class VfVolunteerProfilescreenBloc
    extends Bloc<VfVolunteerProfilescreeEvent, VfVolunteerProfilescreenState> {
  final VolufriendCrudService vfCrudService;

  VfVolunteerProfilescreenBloc({
    required VfVolunteerProfilescreenState initialState,
    required this.vfCrudService,
  }) : super(initialState) {
    on<LoadVolunteerProfileEvent>(_loadVolunteerProfile);
  }
  void _loadVolunteerProfile(
    VfVolunteerProfilescreeEvent event,
    Emitter<VfVolunteerProfilescreenState> emit,
  ) {
    // Add your implementation here
    // Start by emitting a loading state
    emit(state.copyWith(isLoading: true));

    // Create dummy volunteer user data
    final dummyVolunteerUser = NewVolufrienduser(
      id: 'dummyUserId',
      firstName: 'Jane',
      lastName: 'Doe',
      email: 'janedoe@example.com',
      phone: '9876543210',
      gender: 'Female',
      dob: DateTime(1995, 5, 15),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      pictureUrl: 'https://example.com/dummy-profile-pic.png',
      role: 'Volunteer',
    );

    // Create dummy profile model with all fields
    final dummyProfileModel = VfVolunteerProfilescreenModel(
      userId: 'dummyUserId',
      volunteerUser: dummyVolunteerUser,
      totalEvents: 2,
      totalOrganizationsAssociated: 3,
      totalVolunteeringHours: 25,
      lastThirtyDaysHours: 8,
    );

    // Emit a new state with the dummy profile data and loading set to false
    emit(state.copyWith(
      vfVolunteerProfilescreenModelObj: dummyProfileModel,
      errorMessage: '',
      successMessage: 'Profile loaded successfully.',
      orgId: 'dummyOrgId123',
      eventId: 'dummyEventId456',
      userId: 'dummyUserId789',
      isLoading: false,
    ));
  }
}
