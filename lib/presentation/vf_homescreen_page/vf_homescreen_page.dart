import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Added import
import 'package:volufriend/auth/bloc/org_event_bloc.dart';
import 'package:volufriend/crud/crud.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_icon_button.dart';
import 'bloc/vf_homescreen_bloc.dart';
import 'models/actionbuttons_item_model.dart';
import 'models/upcomingeventslist_item_model.dart';
import 'models/vf_homescreen_model.dart';
import 'widgets/actionbuttons_item_widget.dart';
import 'widgets/upcomingeventslist_item_widget.dart';
import 'widgets/volunteergoalhours_graph_widget.dart';
import 'widgets/vf_searchscreen_page.dart';
import 'widgets/todayevent_item_widget.dart';
import '/crud_repository/volufriend_crud_repo.dart';
import '../../auth/bloc/login_user_bloc.dart';
import '../vf_homescreen_container_screen/bloc/vf_homescreen_container_bloc.dart';
import 'package:volufriend/presentation/vf_createeventscreen2_eventshifts_screen/bloc/vf_createeventscreen2_eventshifts_bloc.dart';
import 'package:volufriend/presentation/vf_createeventscreen1_eventdetails_screen/bloc/vf_createeventscreen1_eventdetails_bloc.dart';
import 'package:volufriend/presentation/vf_createeventscreen3_eventadditionaldetails_screen/bloc/vf_createeventscreen3_eventadditionaldetails_bloc.dart';
import 'package:volufriend/presentation/vf_eventlist_screen/bloc/vf_eventlist_bloc.dart';
import '/core/utils/cause_cache_service.dart'; // Adjust path as needed

class VfHomescreenPage extends StatelessWidget {
  const VfHomescreenPage({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    final String userRole = getUserRole(context);
    final String userId = getUserId(context);
    final String orgUserId = getOrgUserId(context);
    final String userIdorOrgUserId =
        userRole == 'Volunteer' ? userId : orgUserId;

    context.read<VfHomescreenBloc>().add(
        VfHomescreenInitialEvent(userId: userIdorOrgUserId, role: userRole));
    context.read<orgVoluEventBloc>().add(resetEvent());
    return const VfHomescreenPage();
  }

  @override
  Widget build(BuildContext context) {
    final String userRole = getUserRole(context);
    final causes = CauseCacheService().getCauseNamesList(); // Uses cached data

    Voluevents fetchTodayEvent() {
      return Voluevents(
        eventId: 'event123',
        orgUserId: 'orgUser456',
        address: '123 Main St, Springfield',
        causeId: 'cause789',
        coordinator: Coordinator(
          name: 'John Doe',
          email: "abc@gmail.com",
          phone: '123-456-7890',
        ),
        createdAt: DateTime.now().subtract(Duration(days: 10)),
        createdBy: 'admin',
        description: 'A community event to help clean the park.',
        endDate: DateTime.now().add(Duration(days: 1)),
        eventAlbum: 'album123',
        eventStatus: 'Active',
        eventWebsite: 'https://example.com/event',
        location: 'Springfield Park',
        title: 'Park Cleanup',
        orgId: 'org123',
        startDate: DateTime.now(),
        regByDate: DateTime.now().subtract(Duration(days: 1)),
        updatedAt: DateTime.now(),
        updatedBy: 'admin',
        EventHostingType: ['In-Person'],
        orgName: 'Springfield Volunteers',
        totalEventSignups: 7,
        shifts: [
          Shift(
            shiftId: 'shift123',
            eventId: 'event123',
            activity: 'Morning Shift',
            startTime: DateTime.now(),
            endTime: DateTime.now().add(Duration(hours: 4)),
            maxNumberOfParticipants: 10,
            totalSignups: 7,
            totalCheckins: 5,
          ),
        ],
      );
    }

    final Voluevents todayEvent = fetchTodayEvent();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),

              // Search Bar - Applicable for both roles
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => SearchPage(
                      allEvents: BlocProvider.of<VfHomescreenBloc>(context)
                          .state
                          .allEvents,
                      socialCauses: causes,
                      onEventTap: (event) {
                        print('Event tapped: $event');
                        final upcomingEventsList =
                            BlocProvider.of<VfHomescreenBloc>(context)
                                .state
                                .upcomingEventsList;

                        final selectedEvent = upcomingEventsList?.firstWhere(
                          (element) => element.eventId == event['eventId'],
                          orElse: () => Voluevents(
                              eventId:
                                  ''), // Return a default instance if no matching event is found
                        );

                        if (selectedEvent != null &&
                            (!selectedEvent.eventId.isEmpty ||
                                selectedEvent.eventId != '')) {
                          // Dispatch an event in your BLoC with the selected event data
                          print('Selected event: ${selectedEvent.eventId}');
                          if (getUserRole(context) == "Organization") {
                            context.read<orgVoluEventBloc>().add(
                                eventdetailsEvent(
                                    event['eventId']!, selectedEvent));
                          } else {
                            context
                                .read<orgVoluEventBloc>()
                                .add(eventsignupEvent(event['eventId']!));
                          }
                        }
                        Navigator.pop(context); // Dismiss the search page
                      },
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Search events, causes, organizations...",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 16),
                      ),
                      Icon(Icons.search, color: Colors.grey.shade600),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Today's Event
              if (todayEvent != null)
                TodayEventWidget(
                  event: todayEvent,
                  userRole: userRole,
                  onButtonPressed: () {
                    // Custom behavior you want to define when the button is pressed
                    context
                        .read<orgVoluEventBloc>()
                        .add(eventdetailsEvent(todayEvent.eventId, todayEvent));
                  },
                ),
              SizedBox(height: 20),

              // Organization-Specific Content
              if (userRole == 'Organization')
                _buildOrganizationHomeContent(context),

              // Volunteer-Specific Content
              if (userRole == 'Volunteer') _buildVolunteerHomeContent(context),
            ],
          ),
        ),
      ),
    );
  }

// Volunteer Home Content - Includes GoalProgressWidget
  Widget _buildVolunteerHomeContent(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Show GoalProgressWidget only for volunteers
                GoalProgressWidget(completedHours: 100, goalHours: 500),
                SizedBox(height: 24),
                Text(
                  "Events you might be interested in",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade900,
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),

          // Volunteer Interested Events
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildVolunteerIntrestedEvents(context),
          ),
          SizedBox(height: 16),

          // "Show All" Button
          _buildShowAllButton(context),

          SizedBox(height: 32),

          // Action Buttons for Volunteers
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: _buildActionButtonsForVolunteer(context),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

// Define the Volunteer button builder
  Widget _buildActionButtonsForVolunteer(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 356.h,
      child: BlocListener<orgVoluEventBloc, orgVoluEventState>(
        listener: _handleVolunteerActionStateChanges,
        child: BlocSelector<VfHomescreenBloc, VfHomescreenState,
            VfHomescreenModel?>(
          selector: (state) => state.vfHomescreenModelObj,
          builder: (context, vfHomescreenModelObj) {
            if (vfHomescreenModelObj?.actionbuttonsItemList == null ||
                vfHomescreenModelObj!.actionbuttonsItemList.isEmpty) {
              return Center(child: Text('No action buttons available'));
            }
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => SizedBox(width: 42.h),
              itemCount: vfHomescreenModelObj.actionbuttonsItemList.length,
              itemBuilder: (context, index) {
                ActionbuttonsItemModel model =
                    vfHomescreenModelObj.actionbuttonsItemList[index];
                return ActionbuttonsItemWidget(model,
                    onPressed: () =>
                        _handleActionButtonPressed(context, model));
              },
            );
          },
        ),
      ),
    );
  }

  void _handleVolunteerActionStateChanges(
      BuildContext context, orgVoluEventState state) {
    // Check if the current state is the initial state and exit if so
    if (state == orgVoluEventState.initial) return;

    if (state.scheduledEvents) {
      NavigatorService.pushNamed(AppRoutes.vfMyupcomingeventscreenScreen);
    } else if (state.volunteerProfile) {
      NavigatorService.pushNamed(
          AppRoutes.vfViewvolunteeringprofilescreenScreen);
    } else if (state.attendanceReport) {
      NavigatorService.pushNamed(AppRoutes.vfuserattendancereportpageScreen);
    }
  }

  void _handleActionButtonPressed(
      BuildContext context, ActionbuttonsItemModel model) {
    if (model.text == 'New opportunities') {
      context.read<orgVoluEventBloc>().add(findNewOpportunitiesEvent());
    } else if (model.text == 'View report') {
      context.read<orgVoluEventBloc>().add(attendanceReportEvent());
    } else if (model.text == 'My events') {
      context.read<orgVoluEventBloc>().add(scheduledEventsEvent());
    } else if (model.text == 'Volunteering profile') {
      final userBloc = BlocProvider.of<UserBloc>(context);
      final userState = userBloc.state;
      if (userState is LoginUserWithHomeOrg) {
        context
            .read<orgVoluEventBloc>()
            .add(volunteerProfileEvent(userState.userId!));
      }
    }
  }

  Widget _buildVolunteerIntrestedEvents(BuildContext context) {
    return BlocListener<orgVoluEventBloc, orgVoluEventState>(
      listener: (context, state) {
        print(
            'Listening to orgVoluEventBloc state change from home screen _buildVolunteerIntrestedEvents');
        if (state.eventsignup) {
          print('Navigating to vfEventsignupscreenScreen');
          NavigatorService.pushNamed(AppRoutes.vfEventsignupscreenScreen);
        }
      },
      child:
          BlocSelector<VfHomescreenBloc, VfHomescreenState, VfHomescreenModel?>(
        selector: (state) => state.vfHomescreenModelObj,
        builder: (context, vfHomescreenModelObj) {
          final eventList =
              vfHomescreenModelObj?.upcomingeventslistItemList ?? [];
          final itemCount = eventList.length > 3 ? 3 : eventList.length;
          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              final model = eventList[index];
              return UpcomingeventslistItemWidget(
                upcomingeventslistItemModelObj: model,
                onTap: () => _handleEventTapped(context, model, "Volunteer"),
                onLongPress: () => print('Long pressed on: ${model.id}'),
                onDismissed: () => context
                    .read<VfHomescreenBloc>()
                    .add(UpcomingEventDismissedEvent(eventId: model.id!)),
                onMenuSelected: (action, id) => (),
                showMenu: false, // Pass showMenu as false here
              );
            },
          );
        },
      ),
    );
  }

  void _handleEventTapped(
      BuildContext context, UpcomingeventslistItemModel model, String Role) {
    context.read<orgVoluEventBloc>().add(resetEvent());

    context
        .read<VfHomescreenBloc>()
        .add(UpcomingEventTappedEvent(eventId: model.id!));
    final upcomingEventsList =
        BlocProvider.of<VfHomescreenBloc>(context).state.upcomingEventsList;

    final selectedEvent = upcomingEventsList != null
        ? upcomingEventsList
            .firstWhere((element) => element.eventId == model.id)
        : null;
    if (Role == "Volunteer") {
      context
          .read<orgVoluEventBloc>()
          .add(UpdateEvent(model.id!, selectedEvent!));
      NavigatorService.pushNamed(AppRoutes.vfEventsignupscreenScreen);
    }
  }

  void _handleMenuAction(String action, String id) {
    if (action == 'edit') {
      print('Edit action selected for ID: $id');
    } else if (action == 'delete') {
      print('Delete action selected for ID: $id');
    }
  }

// Helper method to get user role
  static String getUserRole(BuildContext context) {
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

  static String getUserId(BuildContext context) {
    // Access the bloc for user role

    final userBloc = BlocProvider.of<UserBloc>(context);
    final userState = userBloc.state;
    final userId = userState.userId ?? '';
    return userId;
  }

  static String getOrgUserId(BuildContext context) {
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

  /// Builds the Organization Home Content widget without GoalProgressWidget.
  Widget _buildOrganizationHomeContent(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: _buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context, "Upcoming Events"),
          _buildSectionContent(context, _buildOrgUpcomingEventsList(context)),
          _buildShowAllButton(context),
          SizedBox(height: 32),
          _buildActionButtonsForOrgProfile(context),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  /// BoxDecoration for the container
  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: Colors.blueGrey.shade50,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    );
  }

  /// Section header for organization home content
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900,
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  /// Section content padding
  Widget _buildSectionContent(BuildContext context, Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: child,
    );
  }

  /// Show all events button for organization
  Widget _buildShowAllButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: GestureDetector(
          onTap: () => _handleShowAllEventsTap(context),
          child: Text(
            "Show All",
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  /// Handle the "Show All" button tap for organization
  void _handleShowAllEventsTap(BuildContext context) {
    final String userRole = getUserRole(context);
    if (userRole == 'Organization') {
      context.read<orgVoluEventBloc>().add(showallorgeventsEvent());
    } else {
      context.read<orgVoluEventBloc>().add(showallusereventsEvent());
    }

    NavigatorService.pushNamed(AppRoutes.vfEventListScreen);
  }

  /// Builds the list of upcoming events for the organization
  Widget _buildOrgUpcomingEventsList(BuildContext context) {
    return BlocListener<orgVoluEventBloc, orgVoluEventState>(
      listener: (context, state) => _handleOrgEventStateChange(context, state),
      child:
          BlocSelector<VfHomescreenBloc, VfHomescreenState, VfHomescreenModel?>(
        selector: (state) => state.vfHomescreenModelObj,
        builder: (context, vfHomescreenModelObj) {
          return _buildOrgEventsList(context, vfHomescreenModelObj);
        },
      ),
    );
  }

  void _handleOrgEventStateChange(
      BuildContext context, orgVoluEventState state) {
    // Local flag to track if navigation has occurred
    bool _hasNavigated = false;

    print('Listening to orgVoluEventBloc state change from home screen');

    if (state == orgVoluEventState.initial || _hasNavigated) {
      return; // Prevent navigation if state is initial or navigation has already occurred
    }

    if (state.eventsignup) {
      _hasNavigated = true;
      NavigatorService.pushNamed(AppRoutes.vfEventsignupscreenScreen)
          .then((_) => _hasNavigated = false); // Reset flag after returning
    } else if (state.eventDetails &&
        state.eventId != null &&
        state.eventId.isNotEmpty &&
        !state.showallorgevents) {
      print('Navigating to vfEventdetailspageScreen');
      _hasNavigated = true;
      NavigatorService.pushNamed(AppRoutes.vfEventdetailspageScreen)
          .then((_) => _hasNavigated = false); // Reset flag after returning
    } else if (state.updateEvent) {
      resetEventInitializationFlags(context);
      _hasNavigated = true;
      NavigatorService.pushNamed(
              AppRoutes.vfCreateeventscreen1EventdetailsScreen)
          .then((_) => _hasNavigated = false); // Reset flag after returning
    }
  }

  /// Builds the upcoming events list
  Widget _buildOrgEventsList(
      BuildContext context, VfHomescreenModel? vfHomescreenModelObj) {
    final itemCount =
        (vfHomescreenModelObj?.upcomingeventslistItemList.length ?? 0)
            .clamp(0, 3);

    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (context, index) {
        final model = vfHomescreenModelObj?.upcomingeventslistItemList[index] ??
            UpcomingeventslistItemModel();
        return UpcomingeventslistItemWidget(
          upcomingeventslistItemModelObj: model,
          onTap: () => _handleOrgEventTap(context, model),
          onLongPress: () => _handleEventLongPress(model.id),
          onDismissed: () => _handleEventDismiss(context, model.id),
          onMenuSelected: (action, id) =>
              _handleMenuSelected(context, action, id, model),
        );
      },
    );
  }

  /// Handles the tap on an event item
  void _handleOrgEventTap(
      BuildContext context, UpcomingeventslistItemModel model) {
    context.read<orgVoluEventBloc>().add(resetEvent());

    final upcomingEventsList =
        BlocProvider.of<VfHomescreenBloc>(context).state.upcomingEventsList;
    final selectedEvent = upcomingEventsList?.firstWhere(
        (element) => element.eventId == model.id,
        orElse: () => Voluevents(eventId: ''));

    if (selectedEvent != null) {
      context
          .read<orgVoluEventBloc>()
          .add(eventdetailsEvent(model.id!, selectedEvent));
    }
  }

  /// Handles the long press on an event item
  void _handleEventLongPress(String? eventId) {
    print('Long pressed on: $eventId');
  }

  /// Handles the dismiss of an event item
  void _handleEventDismiss(BuildContext context, String? eventId) {
    context
        .read<VfHomescreenBloc>()
        .add(UpcomingEventDismissedEvent(eventId: eventId!));
  }

  /// Handles the selection of menu actions on an event item
  void _handleMenuSelected(BuildContext context, String action, String id,
      UpcomingeventslistItemModel model) {
    final upcomingEventsList =
        BlocProvider.of<VfHomescreenBloc>(context).state.upcomingEventsList;
    final selectedEvent =
        upcomingEventsList?.firstWhere((element) => element.eventId == model.id,
            orElse: () => Voluevents(
                  eventId: '',
                ));

    if (action == 'edit' && selectedEvent != null) {
      context
          .read<orgVoluEventBloc>()
          .add(UpdateEvent(model.id!, selectedEvent));
    } else if (action == 'cancel') {
      _showCancelEventDialog(context, selectedEvent, id);
    }
  }

  /// Displays a dialog to confirm event cancellation
  void _showCancelEventDialog(
      BuildContext context, dynamic selectedEvent, String id) {
    bool notifyParticipants = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                  'Cancel Event: ${selectedEvent?.title ?? 'Unknown Event'}?'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                      'Are you sure you want to cancel this event? This action cannot be undone and will notify all participants by default.'),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Checkbox(
                        value: notifyParticipants,
                        onChanged: (bool? value) {
                          setState(() {
                            notifyParticipants = value ?? true;
                          });
                        },
                      ),
                      Expanded(
                          child: Text('Notify participants of cancellation')),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Keep Event'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                ElevatedButton(
                  child: Text('Cancel Event'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    context.read<VfHomescreenBloc>().add(
                        CancelEventFromListEvent(
                            eventId: id,
                            notifyParticipants: notifyParticipants));
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Resets the initialization flags for event creation
  void resetEventInitializationFlags(BuildContext context) {
    print('Resetting event initialization flags');
    BlocProvider.of<VfCreateeventscreen1EventdetailsBloc>(context)
        .add(VfCreateeventscreen1EventdetailsResetInitializationEvent());
    BlocProvider.of<VfCreateeventscreen2EventshiftsBloc>(context)
        .add(VfCreateeventscreen2ShiftsResetInitializationEvent());
    BlocProvider.of<VfCreateeventscreen3EventadditionaldetailsBloc>(context).add(
        VfCreateeventscreen3EventadditionaldetailsResetInitializationEvent());
  }

  Widget _buildActionButtonsForOrgProfile(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 356.h,
      child: BlocListener<orgVoluEventBloc, orgVoluEventState>(
        listener: _onOrgVoluEventStateChange,
        child: BlocSelector<VfHomescreenBloc, VfHomescreenState,
            VfHomescreenModel?>(
          selector: (state) => state.vfHomescreenModelObj,
          builder: (context, vfHomescreenModelObj) {
            return vfHomescreenModelObj?.actionbuttonsItemList.isNotEmpty ??
                    false
                ? _buildActionButtonsList(
                    vfHomescreenModelObj!.actionbuttonsItemList, context)
                : Center(child: Text('No action buttons available'));
          },
        ),
      ),
    );
  }

  void _onOrgVoluEventStateChange(
      BuildContext context, orgVoluEventState state) {
    if (state.isLoading) {
      resetEventInitializationFlags(context);
      _navigateToCreateEventScreen(context);
    } else if (state.orgschedule) {
      _navigateToScheduleScreen(context);
    } else if (state.approvehours) {
      _navigateToApproveHoursScreen(context);
    } else if (state.manageEvents) {
      _navigateToManageEventsScreen(context);
    }
  }

  void _navigateToCreateEventScreen(BuildContext context) {
    print('Navigating to VfCreateeventscreen1EventdetailsScreen for create');
    NavigatorService.pushNamed(
        AppRoutes.vfCreateeventscreen1EventdetailsScreen);
  }

  void _navigateToScheduleScreen(BuildContext context) {
    print('Navigating to vfOrgschedulescreenScreen');
    NavigatorService.pushNamed(AppRoutes.vfOrgschedulescreenScreen);
  }

  void _navigateToApproveHoursScreen(BuildContext context) {
    print('Navigating to vfApprovehoursscreenScreen');
    NavigatorService.pushNamed(AppRoutes.vfEventListScreen);
  }

  void _navigateToManageEventsScreen(BuildContext context) {
    print('Navigating to vfEventsearchScreen');
    NavigatorService.pushNamed(AppRoutes.vfEventsearchScreen);
  }

  Widget _buildActionButtonsList(
      List<ActionbuttonsItemModel> actionButtons, BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => SizedBox(width: 42.h),
      itemCount: actionButtons.length,
      itemBuilder: (context, index) {
        final model = actionButtons[index];
        return ActionbuttonsItemWidget(model,
            onPressed: () => _onActionButtonPressed(model, context));
      },
    );
  }

  void _onActionButtonPressed(
      ActionbuttonsItemModel model, BuildContext context) {
    context.read<orgVoluEventBloc>().add(resetEvent());
    print('Tapped on: ${model.text}');
    switch (model.text) {
      case 'Create Event':
        context.read<orgVoluEventBloc>().add(CreateEvent());
        break;
      case 'Approve Hours':
        context
            .read<orgVoluEventBloc>()
            .add(approvehoursEvent("j", "j", "j", Voluevents(eventId: '')));
        context.read<EventListBloc>().add(ResetEventListScreenEvent());
        break;
      case 'Manage Events':
        context.read<orgVoluEventBloc>().add(manageEventsEvent());
        context.read<EventListBloc>().add(ResetEventListScreenEvent());
        break;
      default:
        print('No action defined for ${model.text}');
    }
  }
}
