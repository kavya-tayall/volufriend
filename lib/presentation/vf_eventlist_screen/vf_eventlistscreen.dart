import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../vf_eventlist_screen/bloc/vf_eventlist_bloc.dart';
import '../vf_eventlist_screen/models/vf_eventlist_model.dart';
import '/crud_repository/volufriend_crud_repo.dart';
import '../vf_homescreen_page/widgets/upcomingeventslist_item_widget.dart';
import '../vf_homescreen_page/models/upcomingeventslist_item_model.dart';
import '../../auth/bloc/login_user_bloc.dart';
import 'package:volufriend/auth/bloc/org_event_bloc.dart';
import '../../core/app_export.dart';
import '../../presentation/vf_homescreen_page/widgets/vf_searchscreen_page.dart';
import '../../widgets/vf_event_filter_widget.dart';
import 'package:volufriend/presentation/vf_createeventscreen2_eventshifts_screen/bloc/vf_createeventscreen2_eventshifts_bloc.dart';
import 'package:volufriend/presentation/vf_createeventscreen1_eventdetails_screen/bloc/vf_createeventscreen1_eventdetails_bloc.dart';
import 'package:volufriend/presentation/vf_createeventscreen3_eventadditionaldetails_screen/bloc/vf_createeventscreen3_eventadditionaldetails_bloc.dart';

class VfEventListScreen extends StatelessWidget {
  const VfEventListScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    final String userRole = getUserRole(context);
    final String userId = getUserId(context);
    final String orgUserId = getOrgUserId(context);
    final String userIdorOrgUserId =
        userRole == 'Volunteer' ? userId : orgUserId;
    var listType = '';

    if (BlocProvider.of<orgVoluEventBloc>(context).state.approvehours) {
      listType = 'Approve';
    } else {
      listType = 'Upcoming';
    }
    print('listType: $listType');
    // Dispatch the initial event
    context.read<EventListBloc>().add(EventListScreenInitialEvent(
          listType: listType,
          role: userRole,
          userId: userIdorOrgUserId,
        ));

    return VfEventListScreen();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventListBloc, VfEventListScreenState>(
      builder: (context, State) {
        // Check if in Approve Hours Mode
        bool isApproveMode =
            BlocProvider.of<orgVoluEventBloc>(context).state.approvehours;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              isApproveMode
                  ? "Select Event to Approve Hours"
                  : "Events You Might Be Interested In",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: const Color(0XFF0070BB),
            centerTitle: true,
            elevation: 4.0,
            actions: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  // Show SearchPage as a bottom sheet
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => SearchPage(
                      allEvents: BlocProvider.of<EventListBloc>(context)
                          .state
                          .allEvents,
                      socialCauses: [],
                      onEventTap: (event) {
                        print('Event tapped: $event');

                        // Trigger the event signup or event details action
                        final orgEventBloc =
                            BlocProvider.of<orgVoluEventBloc>(context);
                        final orgEventState = orgEventBloc.state;
                        if (orgEventState.showalluserevents) {
                          context
                              .read<orgVoluEventBloc>()
                              .add(eventsignupEvent(event['eventId']!));
                        } else if (orgEventState.showallorgevents ||
                            getUserRole(context) == "Organization") {
                          print('Show all org events');

                          final upcomingEventsList =
                              BlocProvider.of<EventListBloc>(context)
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
                            context.read<orgVoluEventBloc>().add(
                                eventdetailsEvent(
                                    event['eventId']!, selectedEvent));
                          }
                        }
                        Navigator.pop(context); // Dismiss the search page
                      },
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.filter_list, color: Colors.white),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FilterPage(
                        onApplyFilters: (
                            {required DateTimeRange? dateRange,
                            required List<String> daysOfWeek,
                            required String timeOfDay}) {
                          //dispatch the filter event FilterEventsEvent
                          context.read<EventListBloc>().add(
                                FilterEventsEvent(
                                  dateRange: dateRange,
                                  daysOfWeek: daysOfWeek,
                                  timeOfDay: timeOfDay,
                                ),
                              );
                        },
                      ),
                    ),
                  );

                  if (result != null) {
                    // Handle the filters
                    print('Filter result: $result');
                    print('dateRange: $result.dateRange');
                    print('daysOfWeek: $result.daysOfWeek');
                    print('timeOfDay: $result.timeOfDay');

                    _handleFilterResult(result, context);
                  }
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: !isApproveMode
                ? _buildEventList(context, isApproveMode)
                : _buildApproveEventList(context, isApproveMode),
          ),
        );
      },
    );
  }

  void _handleFilterResult(Map<String, dynamic> result, BuildContext context) {
    // Extract values from the result map
    String timeOfDay =
        result['timeOfDay'] ?? ''; // Default to an empty string if null
    DateTimeRange? dateRange = result['dateRange'] as DateTimeRange?;
    List<String> daysOfWeek = List<String>.from(result['daysOfWeek'] ?? []);

    // Now dispatch the FilterEventsEvent
    FilterEventsEvent filterEvent = FilterEventsEvent(
      dateRange: dateRange,
      daysOfWeek: daysOfWeek,
      timeOfDay: timeOfDay,
    );

    // Dispatch the event to the EventListBloc
    context.read<EventListBloc>().add(filterEvent);
  }

  /// Section Widget
  Widget _buildEventList(BuildContext context, bool isApproveMode) {
    return BlocListener<orgVoluEventBloc, orgVoluEventState>(
      listener: (context, state) {
        // Listen to the changes in the bloc's state
        if (state.eventsignup) {
          // Handle navigation when eventsignup is triggered
          NavigatorService.pushNamed(AppRoutes.vfEventsignupscreenScreen);
        } else if (state.eventDetails) {
          // Handle navigation to event details when showallorgevents is triggered
          NavigatorService.pushNamed(AppRoutes.vfEventdetailspageScreen);
        } else if (state.updateEvent) {
          // Handle navigation to event details when showalluserevents is triggered
          resetEventInitializationFlags(context);
          NavigatorService.pushNamed(
              AppRoutes.vfCreateeventscreen1EventdetailsScreen);
        }
      },
      child: BlocSelector<EventListBloc, VfEventListScreenState,
          VfEventListModel?>(
        selector: (state) => state.vfEventListModelObj,
        builder: (context, vfEventListModelObj) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:
                vfEventListModelObj?.upcomingeventslistItemList.length ?? 0,
            itemBuilder: (context, index) {
              UpcomingeventslistItemModel model =
                  vfEventListModelObj?.upcomingeventslistItemList[index] ??
                      UpcomingeventslistItemModel();

              return UpcomingeventslistItemWidget(
                upcomingeventslistItemModelObj: model,
                onMenuSelected: (String action, String id) {
                  // Handle the selected menu action and use the ID
                  if (action == 'edit') {
                    print('Edit action selected for ID: $id');

                    // Get the selected event
                    final upcomingEventsList =
                        BlocProvider.of<EventListBloc>(context)
                            .state
                            .upcomingEventsList;
                    final selectedEvent = upcomingEventsList != null
                        ? upcomingEventsList.firstWhere(
                            (element) => element.eventId == model.id)
                        : null;

                    if (selectedEvent != null) {
                      context
                          .read<orgVoluEventBloc>()
                          .add(UpdateEvent(model.id!, selectedEvent));
                    }
                    // Perform edit action with the given ID
                  } else if (action == 'delete') {
                    print('Delete action selected for ID: $id');
                    // Perform delete action with the given ID
                  }
                },
                onTap: () {
                  print('Event ID: ${model.id}');

                  // Trigger the event signup or event details action
                  final orgEventBloc =
                      BlocProvider.of<orgVoluEventBloc>(context);
                  final orgEventState = orgEventBloc.state;
                  print(orgEventState);
                  if (orgEventState.showalluserevents) {
                    context
                        .read<orgVoluEventBloc>()
                        .add(eventsignupEvent(model.id!));
                  } else if (orgEventState.showallorgevents ||
                      getUserRole(context) == "Organization") {
                    print('Show all org events');
                    final upcomingEventsList =
                        BlocProvider.of<EventListBloc>(context)
                            .state
                            .upcomingEventsList;

                    final selectedEvent = upcomingEventsList != null
                        ? upcomingEventsList.firstWhere(
                            (element) => element.eventId == model.id)
                        : null;

                    context
                        .read<orgVoluEventBloc>()
                        .add(eventdetailsEvent(model.id!, selectedEvent!));
                  }
                },

                // Add trailing indicator based on approveMode
                trailing: isApproveMode
                    ? Icon(Icons.radio_button_unchecked,
                        color: Colors.blueAccent, size: 24.0)
                    : null,
                onLongPress: () {
                  // Handle long press
                },
                onDismissed: () {
                  // Handle dismiss action
                },
              );
            },
          );
        },
      ),
    );
  }

  void resetEventInitializationFlags(BuildContext context) {
    // Access the bloc for VfCreateeventscreen1EventdetailsBloc
    print('Resetting event initialization flags');
    final eventDetailsBloc1 =
        BlocProvider.of<VfCreateeventscreen1EventdetailsBloc>(context);
    // Emit state with isInitialized set to false
    eventDetailsBloc1
        .add(VfCreateeventscreen1EventdetailsResetInitializationEvent());

    // Access the bloc for VfCreateeventscreen2EventdetailsBloc
    final eventDetailsBloc2 =
        BlocProvider.of<VfCreateeventscreen2EventshiftsBloc>(context);
    // Emit state with isInitialized set to false
    eventDetailsBloc2.add(VfCreateeventscreen2ShiftsResetInitializationEvent());

    // Access the bloc for VfCreateeventscreen3EventadditionaldetailsBloc
    final eventDetailsBloc3 =
        BlocProvider.of<VfCreateeventscreen3EventadditionaldetailsBloc>(
            context);
    // Emit state with isInitialized set to false
    eventDetailsBloc3.add(
        VfCreateeventscreen3EventadditionaldetailsResetInitializationEvent());
  }

  /// Section Widget
  Widget _buildApproveEventList(BuildContext context, bool isApproveMode) {
    return BlocListener<orgVoluEventBloc, orgVoluEventState>(
      listener: (context, state) {
        // Check if the event approval was successful
        if (state.approvehours &&
            state.eventId.isNotEmpty &&
            state.shiftId1.isNotEmpty &&
            state.shiftId2.isNotEmpty) {
          // Navigate to the Approve Hours screen once the event processing is complete
          NavigatorService.pushNamed(AppRoutes.vfApprovehoursscreenScreen);
        }
      },
      child: BlocSelector<EventListBloc, VfEventListScreenState,
          VfEventListModel?>(
        selector: (state) => state.vfEventListModelObj,
        builder: (context, vfEventListModelObj) {
          if (vfEventListModelObj == null ||
              vfEventListModelObj.upcomingeventslistItemList.isEmpty) {
            return Center(
                child: CircularProgressIndicator()); // Loading indicator
          }
          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount:
                vfEventListModelObj?.upcomingeventslistItemList.length ?? 0,
            itemBuilder: (context, index) {
              UpcomingeventslistItemModel model =
                  vfEventListModelObj?.upcomingeventslistItemList[index] ??
                      UpcomingeventslistItemModel();

              return UpcomingeventslistItemWidget(
                upcomingeventslistItemModelObj: model,
                onMenuSelected: (p0, p1) => {},
                onTap: () {
                  print('Event ID: ${model.id}');

                  final upcomingEventsList =
                      BlocProvider.of<EventListBloc>(context)
                          .state
                          .upcomingEventsList;

                  final selectedEvent = upcomingEventsList != null
                      ? upcomingEventsList
                          .firstWhere((element) => element.eventId == model.id)
                      : null;
                  // Fetch the shift IDs
                  final shiftid1 = selectedEvent?.shifts[0].shiftId ?? '';
                  final shiftid2 = selectedEvent?.shifts[1].shiftId ?? '';

                  print('shiftid1: $shiftid1');
                  print('shiftid2: $shiftid2');

                  // Dispatch the event to the Bloc
                  if (selectedEvent != null) {
                    context.read<orgVoluEventBloc>().add(approvehoursEvent(
                        model.id!, shiftid1, shiftid2, selectedEvent));
                  } else {
                    // Handle the case where selectedEvent is null
                    print('Selected event is null');
                  }

                  // Navigation is now handled by the BlocListener, so remove it here
                },
                // Add trailing indicator based on approveMode
                trailing: isApproveMode
                    ? Icon(Icons.radio_button_unchecked,
                        color: Colors.blueAccent, size: 24.0)
                    : null,
                onLongPress: () {
                  // Handle long press
                },
                onDismissed: () {
                  // Handle dismiss action
                },
              );
            },
          );
        },
      ),
    );
  }

  // Helper method to get user role
  static String getUserRole(BuildContext context) {
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
    final userBloc = BlocProvider.of<UserBloc>(context);
    final userState = userBloc.state;
    final userId = userState.userId ?? '';
    return userId;
  }

  static String getOrgUserId(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final userState = userBloc.state;
    if (userState is LoginUserWithHomeOrg) {
      final userHomeOrg = userState.user.userHomeOrg;
      return userHomeOrg?.useridinorg ?? '';
    }
    return '';
  }
}
