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

class VfEventListScreenForApprove extends StatelessWidget {
  const VfEventListScreenForApprove({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    final String userRole = getUserRole(context);
    final String userId = getUserId(context);
    final String orgUserId = getOrgUserId(context);
    final String userIdorOrgUserId =
        userRole == 'Volunteer' ? userId : orgUserId;
    var listType = '';

    context.read<EventListBloc>().add(LoadEventListForApprovalEvent(
          userId: userIdorOrgUserId,
        ));

    return VfEventListScreenForApprove();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventListBloc, VfEventListScreenState>(
      builder: (context, State) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: Text(
              "Select Event to Approve Hours",
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
                                  .approveEventsList;

                          final selectedEvent = upcomingEventsList?.firstWhere(
                            (element) => element.eventId == event['eventId'],
                            orElse: () => Voluevents(
                                eventId:
                                    ''), // Return a default instance if no matching event is found
                          );

                          if (selectedEvent != null &&
                              (!selectedEvent.eventId.isEmpty ||
                                  selectedEvent.eventId != '')) {
                            if (selectedEvent != null) {
                              final shiftid1 =
                                  selectedEvent.shifts[0].shiftId ?? '';
                              final shiftid2 =
                                  selectedEvent.shifts[1].shiftId ?? '';
                              print('shiftid1: $shiftid1');
                              print('shiftid2: $shiftid2');

                              // You can add your event dispatch here if needed
                              // context.read<orgVoluEventBloc>().add(approvehoursEvent(model.id!, shiftid1, shiftid2, selectedEvent));
                            } else {
                              // Handle the case where selectedEvent is null
                              print('Selected event is null');
                            }
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
                            required String? timeOfDay}) {
                          //dispatch the filter event FilterEventsEvent
                          context.read<EventListBloc>().add(
                                FilterEventsEvent(
                                  dateRange: dateRange,
                                  daysOfWeek: daysOfWeek,
                                  timeOfDay: timeOfDay!,
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
            child: _buildApproveEventList(context),
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
  Widget _buildApproveEventList(BuildContext context) {
    return BlocSelector<EventListBloc, VfEventListScreenState,
        VfEventListModel?>(
      selector: (state) => state.vfEventListModelObj,
      builder: (context, vfEventListModelObj) {
        // Debugging the state object and list
        print('vfEventListModelObj: $vfEventListModelObj');
        if (vfEventListModelObj != null) {
          print(
              'upcomingeventslistItemList length: ${vfEventListModelObj.upcomingeventslistItemList.length}');
          vfEventListModelObj.upcomingeventslistItemList.forEach((item) {
            print('Event Item: ${item.id}');
          });
        } else {
          print('vfEventListModelObj is null');
        }

        if (vfEventListModelObj == null ||
            vfEventListModelObj.upcomingeventslistItemList.isEmpty) {
          return Center(
              child: CircularProgressIndicator()); // Loading indicator
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: vfEventListModelObj.upcomingeventslistItemList.length,
          itemBuilder: (context, index) {
            UpcomingeventslistItemModel model =
                vfEventListModelObj.upcomingeventslistItemList[index];

            // Debugging each event item
            print('Event ID: ${model.id}');

            return UpcomingeventslistItemWidget(
              upcomingeventslistItemModelObj: model,
              onMenuSelected: (p0, p1) => {},
              onTap: () {
                print('Tapped Event ID: ${model.id}');

                final upcomingEventsList =
                    BlocProvider.of<EventListBloc>(context)
                        .state
                        .upcomingEventsList;

                final selectedEvent = upcomingEventsList != null
                    ? upcomingEventsList.firstWhere(
                        (element) => element.eventId == model.id,
                        orElse: () => Voluevents(eventId: ''))
                    : null;

                if (selectedEvent != null) {
                  final shiftid1 = selectedEvent.shifts[0].shiftId ?? '';
                  final shiftid2 = selectedEvent.shifts[1].shiftId ?? '';
                  print('shiftid1: $shiftid1');
                  print('shiftid2: $shiftid2');

                  // You can add your event dispatch here if needed
                  // context.read<orgVoluEventBloc>().add(approvehoursEvent(model.id!, shiftid1, shiftid2, selectedEvent));
                } else {
                  // Handle the case where selectedEvent is null
                  print('Selected event is null');
                }
              },
              trailing: Icon(Icons.radio_button_unchecked,
                  color: Colors.blueAccent, size: 24.0),
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
