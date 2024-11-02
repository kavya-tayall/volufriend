import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';
import 'bloc/vf_volunteeringcalendarpage_bloc.dart';
import 'models/vf_volunteeringcalendarpage_model.dart';
import '../../auth/bloc/login_user_bloc.dart';

class VfVolunteeringcalendarpageScreen extends StatelessWidget {
  const VfVolunteeringcalendarpageScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    final String role = getUserRole(context);
    final String userId = getUserId(context);
    final String orgUserId = getOrgUserId(context);
    final String userIdorOrgUserId = role == 'Volunteer' ? userId : orgUserId;

    return BlocProvider(
      create: (_) => VfVolunteeringcalendarpageBloc(
        vfCrudService: context.read<VolufriendCrudService>(),
      )..add(InitializeCalendarEvent(
          userId: userIdorOrgUserId!, // Pass correct userId
          currentDate: DateTime.now(),
          role: role,
        )),
      child: const VfVolunteeringcalendarpageScreenContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const VfVolunteeringcalendarpageScreenContent();
  }
}

class VfVolunteeringcalendarpageScreenContent extends StatelessWidget {
  const VfVolunteeringcalendarpageScreenContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volunteering Calendar'),
      ),
      body: Column(
        children: [
          BlocBuilder<VfVolunteeringcalendarpageBloc,
              VfVolunteeringcalendarpageState>(
            builder: (context, state) {
              return TableCalendar<Voluevents>(
                firstDay: DateTime.now(),
                lastDay: DateTime.now().add(const Duration(days: 60)),
                focusedDay: state.focusedDay,
                selectedDayPredicate: (day) =>
                    isSameDay(state.selectedDay, day),
                calendarFormat: state.calendarFormat,
                eventLoader: (day) => context
                    .read<VfVolunteeringcalendarpageBloc>()
                    .getEventsForDayFromCache(day),
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  context.read<VfVolunteeringcalendarpageBloc>().add(
                      SelectDayEvent(selectedDay, focusedDay, state.userId!,
                          getUserRole(context)));
                },
                onFormatChanged: (format) {
                  context
                      .read<VfVolunteeringcalendarpageBloc>()
                      .add(ChangeCalendarFormatEvent(format));
                },
                onPageChanged: (focusedDay) {
                  context.read<VfVolunteeringcalendarpageBloc>().add(
                      InitializeCalendarEvent(
                          userId: state.userId!,
                          currentDate: focusedDay,
                          role: getUserRole(context)));
                },
              );
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: BlocBuilder<VfVolunteeringcalendarpageBloc,
                VfVolunteeringcalendarpageState>(
              builder: (context, state) {
                final selectedDayEvents = context
                    .read<VfVolunteeringcalendarpageBloc>()
                    .getEventsForDayFromCache(state.selectedDay);
                final role = getUserRole(context);

                if (selectedDayEvents.isEmpty) {
                  return const Center(
                    child: Text('No events for the selected day.'),
                  );
                }

                return ListView.builder(
                  itemCount: selectedDayEvents.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final event = selectedDayEvents[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.grey.shade200,
                      ),
                      child: ListTile(
                        onTap: () => print('${event.title}'),
                        subtitle:
                            _buildSelectedEventDetails(context, event, role),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildSelectedEventDetails(
    BuildContext context, Voluevents event, String role) {
  // Check if the role is "Volunteer" to decide the format
  bool isVolunteer = role == 'Volunteer';

  return Padding(
    padding: EdgeInsets.symmetric(
        vertical: 4.0), // Reduced vertical padding between tiles
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color:
                Theme.of(context).colorScheme.surface, // Main container color
            borderRadius: BorderRadius.circular(
                16), // Rounded corners for the main rectangle
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center, // Center vertically
            children: [
              // Smaller vertical rectangle for weekday and date
              Padding(
                padding: EdgeInsets.only(left: 4), // Left padding for alignment
                child: Container(
                  width: 60, // Compact width
                  height: 80, // Adjust height to be compact but proportional
                  padding: EdgeInsets.symmetric(
                      vertical: 12.0), // More compact padding
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .primaryColor, // Vertical rectangle color
                    borderRadius: BorderRadius.circular(
                        12), // Rounded corners for the vertical rectangle
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Align content to the top and bottom
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Center horizontally
                    children: [
                      // Weekday aligned to center-top
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          _getWeekday(
                              event.startDate), // Weekday (e.g., Sunday)
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14, // Smaller font size for weekday
                              ),
                        ),
                      ),

                      // Day of the month aligned to center-bottom
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "${event.startDate?.day ?? ''}", // Day of the month
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        18, // Slightly smaller font size for day of the month
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16),

              // Expanded section for event details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event title
                    Text(
                      event.title ?? "Untitled Event",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 8.0),

                    // Event address and organization name for Volunteer
                    if (isVolunteer) ...[
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              color: Colors.redAccent, size: 16),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              event.address ?? "No address available",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.black54,
                                  ),
                              overflow: TextOverflow
                                  .ellipsis, // Ellipsis for long addresses
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      Row(
                        children: [
                          Icon(Icons.business,
                              color: Colors.blueAccent, size: 16),
                          SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              event.orgName ?? "Organization not specified",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.black54,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),

                      // Shift details for Volunteer
                      if (event.shifts.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Shifts:",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                            ),
                            SizedBox(height: 8.0),
                            ListView.builder(
                              shrinkWrap: true,
                              physics:
                                  NeverScrollableScrollPhysics(), // Prevent nested scroll
                              itemCount: event.shifts.length,
                              itemBuilder: (context, index) {
                                final shift = event.shifts[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 4.0),
                                      child: Text(
                                        "${_formatTime(shift.startTime)} - ${_formatTime(shift.endTime)}: ${shift.activity}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Colors.black54,
                                            ),
                                      ),
                                    ),
                                    // Separator line between shifts
                                    if (index < event.shifts.length - 1)
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: Divider(
                                          color: Colors.grey
                                              .shade300, // Soft grey separator line
                                          thickness:
                                              1, // Thickness of the separator line
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                    ] else ...[
                      // Original format if not Volunteer
                      if (event.shifts.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: event.shifts.length,
                              itemBuilder: (context, index) {
                                final shift = event.shifts[index];
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Shift time and activity in the same row
                                          Expanded(
                                            child: Text(
                                              "${_formatTime(shift.startTime)} - ${_formatTime(shift.endTime)}: ${shift.activity}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: Colors.black54,
                                                  ),
                                            ),
                                          ),
                                          // Sign-up details for non-volunteer roles
                                          GestureDetector(
                                            onTap: () {
                                              // Handle on tap to open attendees list page
                                            },
                                            child: Text(
                                              "Sign-ups: ${shift.numberOfParticipants}/${shift.maxNumberOfParticipants}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: Colors.blue,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Separator line between shifts
                                    if (index < event.shifts.length - 1)
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8.0),
                                        child: Divider(
                                          color: Colors.grey
                                              .shade300, // Soft grey separator line
                                          thickness:
                                              1, // Thickness of the separator line
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                    ],
                    SizedBox(height: 16.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper function to get the weekday as a string
String _getWeekday(DateTime? date) {
  if (date == null) return '';
  return ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.weekday % 7];
}

// Helper function to format time
String _formatTime(DateTime? date) {
  if (date == null) return '';
  return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
}

String getUserRole(BuildContext context) {
  // Access the bloc for user role
  final userBloc = BlocProvider.of<UserBloc>(context);
  final userState = userBloc.state;

  if (userState is LoginUserWithHomeOrg) {
    return userState.user.userHomeOrg?.role == "Volunteer"
        ? "Volunteer"
        : "Organization";
  }
  return "";
}

String getUserId(BuildContext context) {
  // Access the bloc for user role

  final userBloc = BlocProvider.of<UserBloc>(context);
  final userState = userBloc.state;
  final userId = userState.userId ?? '';
  return userId;
}

String getOrgUserId(BuildContext context) {
  // Access the bloc for user role

  final userBloc = BlocProvider.of<UserBloc>(context);
  final userState = userBloc.state;
  if (userState is LoginUserWithHomeOrg) {
    print('User is logged in with home org');
    final userHomeOrg = userState.user.userHomeOrg;
    return userHomeOrg?.useridinorg ?? '';
  }
  return '';
}
