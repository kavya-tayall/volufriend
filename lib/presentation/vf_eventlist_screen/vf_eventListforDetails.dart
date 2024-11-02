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
import '/core/utils/cause_cache_service.dart'; // Adjust path as needed

class VfEventListDetailsScreen extends StatelessWidget {
  const VfEventListDetailsScreen({Key? key}) : super(key: key);

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
    return VfEventListDetailsScreen();
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
              isApproveMode ? "Approve Hours" : "Select Event to vieww details",
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

                        _handleListOnTap(context, event['eventId']!);

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
            child: _buildEventDetailsList(context),
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
  Widget _buildEventDetailsList(BuildContext context) {
    return BlocListener<orgVoluEventBloc, orgVoluEventState>(
      listener: (context, state) {
        // Check if the current state is the initial state and exit if so
        if (state == orgVoluEventState.initial) return;

        // Listen to the changes in the bloc's state
        if (state.eventDetails && !state.hasNavigated) {
          // Handle navigation to event details when showallorgevents is triggered

          NavigatorService.pushNamed(AppRoutes.vfEventdetailspageScreen);
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
                onTap: () => _handleListOnTap(context, model.id!),
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

  void _handleListOnTap(BuildContext context, String eventId) {
    print('Event ID: ${eventId}');

    // Reset the state
    BlocProvider.of<orgVoluEventBloc>(context).add(resetEvent());

    final upcomingEventsList =
        BlocProvider.of<EventListBloc>(context).state.upcomingEventsList;

    final selectedEvent = upcomingEventsList != null
        ? upcomingEventsList.firstWhere((element) => element.eventId == eventId)
        : null;

    context
        .read<orgVoluEventBloc>()
        .add(eventdetailsEvent(eventId, selectedEvent!));
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
