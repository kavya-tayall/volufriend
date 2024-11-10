import 'package:flutter/material.dart';
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
import '/core/utils/cause_cache_service.dart'; // Adjust path as needed
import '../../presentation/vf_homescreen_page/navigation_helper.dart';

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
    final causes = CauseCacheService().getCauseNamesList(); // Uses cached data

    return BlocBuilder<EventListBloc, VfEventListScreenState>(
      builder: (context, State) {
        if (State.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        // Check if in Approve Hours Mode
        bool isApproveMode =
            BlocProvider.of<orgVoluEventBloc>(context).state.approvehours;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                context.read<EventListBloc>().add(ResetEventListScreenEvent());
                //Navigator.of(context).pop();
                Navigator.of(context).popUntil(
                    ModalRoute.withName(AppRoutes.vfHomescreenContainerScreen));
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
                      socialCauses: causes,
                      onEventTap: (event) {
                        print('Event tapped: $event');

                        _handleListOnTap(
                            context, event['eventId']!, getUserRole(context));

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
                            required String? timeOfDay}) {
                          //dispatch the filter event FilterEventsEvent
                          print('dateRange: $dateRange');
                          print('daysOfWeek: $daysOfWeek');
                          print('timeOfDay: $timeOfDay');
                          context.read<EventListBloc>().add(
                                FilterEventsEvent(
                                  dateRange: dateRange,
                                  daysOfWeek: daysOfWeek,
                                  timeOfDay: timeOfDay ?? '',
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
                ? _buildEventDetailsList(
                    context, isApproveMode, getUserRole(context))
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
        // Check if the current state is the initial state and exit if so
        if (state == orgVoluEventState.initial) return;

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
                onMenuSelected: (action, id) =>
                    _handleMenuSelected(context, action, id, model),
                onTap: () =>
                    _handleListOnTap(context, model.id!, getUserRole(context)),

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

  /// Section Widget
  Widget _buildEventDetailsList(
      BuildContext context, bool isApproveMode, String userRole) {
    return BlocListener<orgVoluEventBloc, orgVoluEventState>(
      listener: (context, state) {
        /*
        // Check if the current state is the initial state and exit if so
        if (state == orgVoluEventState.initial) return;

        // Listen to the changes in the bloc's state
        if (state.eventDetails && !state.hasNavigated) {
          // Handle navigation to event details when showallorgevents is triggered

          NavigatorService.pushNamed(AppRoutes.vfEventdetailspageScreen);
        }*/
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
                showMenu: userRole == "Volunteer" ? false : true,
                onMenuSelected: (action, id) =>
                    _handleMenuSelected(context, action, id, model),
                onTap: () =>
                    _handleListOnTap(context, model.id!, getUserRole(context)),

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

  void _handleListOnTap(BuildContext context, String eventId, String userRole) {
    NavigationHelper.endNavigation;
    print('Event ID in tap: ${eventId}');

    // Trigger the event signup or event details action
    final orgEventBloc = BlocProvider.of<orgVoluEventBloc>(context);
    final orgEventState = orgEventBloc.state;

    String prevstate = '';

    // preserve the state
    if (orgEventState.showalluserevents) {
      prevstate = 'showalluserevents';
    } else if (orgEventState.showallorgevents &&
        getUserRole(context) == "Organization") {
      prevstate = 'showallorgevents';
    } else if (orgEventState.approvehours) {
      prevstate = 'approvehours';
    } else if (orgEventState.manageEvents) {
      prevstate = 'manageEvents';
    } else if (orgEventState.eventDetails) {
      prevstate = 'eventDetails';
    }
    print('prevstate: ' + prevstate);

    if (prevstate == '' && userRole == 'Volunteer') {
      prevstate = 'showalluserevents';
    }
    // Reset the state
    // orgEventBloc.add(resetEvent());

    final upcomingEventsList =
        BlocProvider.of<EventListBloc>(context).state.upcomingEventsList;

    final selectedEvent = upcomingEventsList != null
        ? upcomingEventsList.firstWhere((element) => element.eventId == eventId)
        : null;

    if (prevstate == 'showalluserevents') {
      context.read<orgVoluEventBloc>().add(eventsignupEvent(eventId));
    } else if (prevstate == 'showallorgevents' &&
        getUserRole(context) == "Organization") {
      context
          .read<orgVoluEventBloc>()
          .add(eventdetailsEvent(eventId, selectedEvent!));
    } else if (prevstate == 'approvehours') {
      // Fetch the shift IDs
      final shiftid1 = selectedEvent?.shifts[0].shiftId ?? '';
      final shiftid2 = selectedEvent?.shifts[1].shiftId ?? '';

      // Dispatch the event to the Bloc
      if (selectedEvent != null) {
        context
            .read<orgVoluEventBloc>()
            .add(approvehoursEvent(eventId, shiftid1, shiftid2, selectedEvent));
      } else {
        // Handle the case where selectedEvent is null
        print('Selected event is null');
      }
    } else if (prevstate == 'manageEvents') {
      context
          .read<orgVoluEventBloc>()
          .add(eventdetailsEvent(eventId, selectedEvent!));
    } else if (prevstate == 'eventDetails') {
      print('eventDetails');
      context
          .read<orgVoluEventBloc>()
          .add(eventdetailsEvent(eventId, selectedEvent!));
    } else if (prevstate == '') {
      context.read<orgVoluEventBloc>().add(resetEvent());
      NavigationHelper.endNavigation();
      if (userRole == 'Volunteer') {
        context.read<orgVoluEventBloc>().add(eventsignupEvent(eventId));
      } else {
        context
            .read<orgVoluEventBloc>()
            .add(eventdetailsEvent(eventId, selectedEvent!));
      }
    }
  }

  /// Handles the selection of menu actions on an event item
  void _handleMenuSelected(BuildContext context, String action, String id,
      UpcomingeventslistItemModel model) {
    final upcomingEventsList =
        BlocProvider.of<EventListBloc>(context).state.upcomingEventsList;
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
                    context.read<EventListBloc>().add(CancelEventEvent(
                        eventId: id, notifyParticipants: notifyParticipants));
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

  Widget _buildApproveEventList(BuildContext context, bool isApproveMode) {
    return BlocListener<orgVoluEventBloc, orgVoluEventState>(
      listener: (context, state) {
        // Check if the current state is the initial state and exit if so
        if (state == orgVoluEventState.initial) return;
        if (state.hasNavigated) return;
        // Check if the event approval was successful
        if (state.approvehours &&
            state.eventId.isNotEmpty &&
            state.shiftId1.isNotEmpty &&
            state.shiftId2.isNotEmpty) {
          // Navigate to the Approve Hours screen once the event processing is complete
          print(" I am here listner");
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
                onTap: () =>
                    _handleListOnTap(context, model.id!, getUserId(context)),
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
