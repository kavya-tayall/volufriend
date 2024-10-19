import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volufriend/core/utils/size_utils.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'bloc/vf_viewvolunteeringprofilescreen_bloc.dart';
import 'models/vf_viewvolunteeringprofilescreen_model.dart';
import '../../auth/bloc/login_user_bloc.dart';
import 'package:intl/intl.dart';

class VfVolunteerProfileScreen extends StatelessWidget {
  const VfVolunteerProfileScreen({Key? key}) : super(key: key);

  // Builder method to initiate the BLoC events and setup MultiBlocProvider
  static Widget builder(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final userBloc = BlocProvider.of<UserBloc>(context);
            final userState = userBloc.state;

            // Check if the user is logged in with a home organization
            if (userState is LoginUserWithHomeOrg) {
              print('User is logged in with home org');
              final userId = userState.userId;

              // Create and return the VfVolunteerProfilescreenBloc
              return VfVolunteerProfilescreenBloc(
                vfCrudService: context.read<VolufriendCrudService>(),
                initialState: const VfVolunteerProfilescreenState(
                  vfVolunteerProfilescreenModelObj:
                      VfVolunteerProfilescreenModel(
                    volunteerUser: NewVolufrienduser(id: ''),
                  ),
                ),
              )..add(LoadVolunteerProfileEvent(userId: userId!));
            } else {
              // Handle the case where the user is not logged in with home org
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).pushReplacementNamed(
                    '/login'); // Replace with your login route
              });

              // Return a default instance to avoid null return
              return VfVolunteerProfilescreenBloc(
                vfCrudService: context.read<VolufriendCrudService>(),
                initialState: const VfVolunteerProfilescreenState(
                  vfVolunteerProfilescreenModelObj:
                      VfVolunteerProfilescreenModel(
                    volunteerUser: NewVolufrienduser(id: ''),
                  ),
                ),
              );
            }
          },
        ),
      ],
      child: const VfVolunteerProfileScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: primaryColor, // Set background to primary color
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Volunteer Profile'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Profile Section
          BlocBuilder<VfVolunteerProfilescreenBloc,
              VfVolunteerProfilescreenState>(
            builder: (context, state) {
              if (!state.isLoading) {
                return Column(
                  children: [
                    // User Image
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: CircleAvatar(
                        radius: 75,
                        backgroundImage: NetworkImage(state
                                .vfVolunteerProfilescreenModelObj
                                ?.volunteerUser
                                .pictureUrl
                                .toString() ??
                            ''),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // User Name
                    Text(
                      (state.vfVolunteerProfilescreenModelObj?.volunteerUser
                                  .firstName ??
                              '') +
                          ' ' +
                          (state.vfVolunteerProfilescreenModelObj?.volunteerUser
                                  .lastName ??
                              ''),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // User Email
                    Text(
                      state.vfVolunteerProfilescreenModelObj?.volunteerUser
                              .email ??
                          '',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // User Phone
                    Text(
                      state.vfVolunteerProfilescreenModelObj?.volunteerUser
                              .phone ??
                          '',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // User Address
                    Text(
                      'dummy address', // Replace with user address
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                );
              } else if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return const Center(child: Text('Error loading profile'));
              }
            },
          ),
          const SizedBox(height: 24),
          // Stats Section
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: BlocBuilder<VfVolunteerProfilescreenBloc,
                  VfVolunteerProfilescreenState>(
                builder: (context, state) {
                  if (!state.isLoading) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Total Volunteering Hours
                        Text(
                          "Total Volunteering Hours",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${state.vfVolunteerProfilescreenModelObj?.totalVolunteeringHours} hours",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 24),
                        // Hours in Last 30 Days
                        Text(
                          "Volunteering in Last 30 Days",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${state.vfVolunteerProfilescreenModelObj?.lastThirtyDaysHours ?? 0} hours",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 24),
                        // Total Companies Volunteered With
                        Text(
                          "Total Companies Volunteered With",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${state.vfVolunteerProfilescreenModelObj?.totalOrganizationsAssociated ?? 0} companies",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        // Edit Profile Button
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle edit profile action
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 16),
                            ),
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else if (state.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const Center(
                        child: Text('Error loading statistics'));
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
