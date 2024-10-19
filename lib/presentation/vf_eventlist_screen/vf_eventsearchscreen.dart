import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../vf_eventlist_screen/bloc/vf_eventlist_bloc.dart';
import '../vf_eventlist_screen/models/vf_eventlist_model.dart';
import '../vf_homescreen_page/widgets/upcomingeventslist_item_widget.dart';
import '../vf_homescreen_page/models/upcomingeventslist_item_model.dart';
import '../../auth/bloc/login_user_bloc.dart';
import 'package:volufriend/auth/bloc/org_event_bloc.dart';
import '../../core/app_export.dart';
import '../../presentation/vf_homescreen_page/widgets/vf_searchscreen_page.dart';
import '../../widgets/vf_event_filter_widget.dart';

class VfEventSearchScreen extends StatelessWidget {
  const VfEventSearchScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    final String userRole = getUserRole(context);
    final String userId = getUserId(context);
    final String orgUserId = getOrgUserId(context);
    final String userIdorOrgUserId =
        userRole == 'Volunteer' ? userId : orgUserId;
    var listType = 'Upcoming'; // Default list type for search

    // Dispatch the initial search event
    context.read<EventListBloc>().add(EventListScreenInitialEvent(
          listType: listType,
          role: userRole,
          userId: userIdorOrgUserId,
        ));

    return VfEventSearchScreen();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventListBloc, VfEventListScreenState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Text(
              "Search Events",
              style: TextStyle(
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
                      allEvents: state.allEvents,
                      socialCauses: [], // Populate if available
                      onEventTap: (event) {
                        Navigator.pop(context); // Dismiss the bottom sheet
                        // Handle event tap actions
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
                          // Apply filter logic here
                          context.read<EventListBloc>().add(FilterEventsEvent(
                              dateRange: dateRange,
                              daysOfWeek: daysOfWeek,
                              timeOfDay: timeOfDay));
                        },
                      ),
                    ),
                  );
                  if (result != null) {
                    // Handle filter result
                  }
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: state.vfEventListModelObj?.upcomingeventslistItemList
                        .isNotEmpty ??
                    false
                ? _buildEventSearchResults(context)
                : const Center(
                    child: Text(
                      'No events found matching your search criteria',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ),
          ),
        );
      },
    );
  }

  /// Widget for displaying search results
  Widget _buildEventSearchResults(BuildContext context) {
    return BlocSelector<EventListBloc, VfEventListScreenState,
            VfEventListModel?>(
        selector: (state) => state.vfEventListModelObj,
        builder: (context, vfEventListModelObj) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount:
                vfEventListModelObj?.upcomingeventslistItemList.length ?? 0,
            itemBuilder: (context, index) {
              UpcomingeventslistItemModel model =
                  vfEventListModelObj?.upcomingeventslistItemList[index] ??
                      UpcomingeventslistItemModel();

              return _buildEventList(context, false, model);
            },
          );
        });
  }

  Widget _buildEventList(BuildContext context, bool isApproveMode,
      UpcomingeventslistItemModel model) {
    return Dismissible(
      key: Key(model.id ?? DateTime.now().toString()), // Unique key
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        child: Icon(Icons.check_circle, color: Colors.white),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          // Mark event as completed
          _markEventAsCompleted(context, model.id!);
        } else {
          // Delete event
          _deleteEvent(context, model.id!);
        }
      },
      child: GestureDetector(
        onTap: () {
          _highlightSelectedEvent(context, model.id!);

          // Trigger event signup or event details
          final orgEventBloc = BlocProvider.of<orgVoluEventBloc>(context);
          final orgEventState = orgEventBloc.state;

          if (orgEventState.showalluserevents) {
            context.read<orgVoluEventBloc>().add(eventsignupEvent(model.id!));
          } else if (orgEventState.showallorgevents ||
              getUserRole(context) == "Organization") {
            final upcomingEventsList = BlocProvider.of<EventListBloc>(context)
                .state
                .upcomingEventsList;
            final selectedEvent = upcomingEventsList
                ?.firstWhere((element) => element.eventId == model.id);

            context
                .read<orgVoluEventBloc>()
                .add(eventdetailsEvent(model.id!, selectedEvent!));
          }
        },
        child: Container(
          color: (model.isSelected ?? false)
              ? Colors.blue.withOpacity(0.1)
              : Colors.transparent,
          child: UpcomingeventslistItemWidget(
            onMenuSelected: (p0, p1) => {},
            upcomingeventslistItemModelObj: model,
            trailing: isApproveMode
                ? Icon(Icons.radio_button_unchecked,
                    color: Colors.blueAccent, size: 24.0)
                : null,
            onTap: () {
              // Handle tap event
            },
            onLongPress: () {
              // Handle long press event
            },
            onDismissed: () {
              // Handle dismiss event
            },
          ),
        ),
      ),
    );
  }

  // Helper method to mark event as completed
  void _markEventAsCompleted(BuildContext context, String eventId) {
    context
        .read<EventListBloc>()
        .add(MarkEventAsCompletedEvent(eventId: eventId));
  }

  // Helper method to delete event
  void _deleteEvent(BuildContext context, String eventId) {
    context.read<EventListBloc>().add(DeleteEvent(eventId: eventId));
  }

  // Helper method to highlight selected event
  void _highlightSelectedEvent(BuildContext context, String eventId) {
    context.read<EventListBloc>().add(HighlightEvent(eventId: eventId));
  }

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
    return userState.userId ?? '';
  }

  static String getOrgUserId(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final userState = userBloc.state;
    if (userState is LoginUserWithHomeOrg) {
      return userState.user.userHomeOrg?.useridinorg ?? '';
    }
    return '';
  }
}
