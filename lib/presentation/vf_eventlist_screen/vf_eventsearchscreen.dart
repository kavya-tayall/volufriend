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
import '../../widgets/vf_app_bar_with_title_back_button.dart';

class VfEventSearchScreen extends StatelessWidget {
  const VfEventSearchScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    final String userRole = getUserRole(context);
    final String userId = getUserId(context);
    final String orgUserId = getOrgUserId(context);
    final String userIdorOrgUserId =
        userRole == 'Volunteer' ? userId : orgUserId;
    var listType = 'Upcoming'; // Default list type for search

    // Ensure the event is only dispatched once
    if (context.read<EventListBloc>().state.isLoading == false) {
      context.read<EventListBloc>().add(EventListScreenInitialEvent(
            listType: listType,
            role: userRole,
            userId: userIdorOrgUserId,
          ));
    }

    return const VfEventSearchScreen();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventListBloc, VfEventListScreenState>(
      builder: (context, state) {
        return Scaffold(
          appBar: VfAppBarWithTitleBackButton(
            title: "Manage Events",
            onBackPressed: () {
              Navigator.of(context).pop();
            },
            onSearchPressed: () {
              // Show SearchPage as a bottom sheet
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => SearchPage(
                  allEvents: state.allEvents,
                  socialCauses: [], // Populate if available
                  onEventTap: (event) {
                    _handleListOnTap(context, event['eventId']!);
                    Navigator.pop(context); // Dismiss the search page
                  },
                ),
              );
            },
            onFilterPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FilterPage(
                    onApplyFilters: ({
                      required DateTimeRange? dateRange,
                      required List<String> daysOfWeek,
                      required String? timeOfDay,
                    }) {
                      context.read<EventListBloc>().add(FilterEventsEvent(
                          dateRange: dateRange,
                          daysOfWeek: daysOfWeek,
                          timeOfDay: timeOfDay!));
                    },
                  ),
                ),
              );
              if (result != null) {
                // Handle filter result if needed
              }
            },
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
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _highlightSelectedEvent(context, model.id!);
        _handleListOnTap(context, model.id!);
      },
      child: Container(
        color: (model.isSelected ?? false)
            ? Colors.blue.withOpacity(0.1)
            : Colors.transparent,
        child: UpcomingeventslistItemWidget(
          onLongPress: () => {},
          onDismissed: () {},
          onMenuSelected: (p0, p1) => {},
          upcomingeventslistItemModelObj: model,
          trailing: isApproveMode
              ? Icon(Icons.radio_button_unchecked,
                  color: Colors.blueAccent, size: 24.0)
              : null,
          onTap: () {
            _highlightSelectedEvent(context, model.id!);
            _handleListOnTap(context, model.id!);
          },
        ),
      ),
    );
  }

  void _highlightSelectedEvent(BuildContext context, String eventId) {
    context.read<EventListBloc>().add(HighlightEvent(eventId: eventId));
  }

  void _handleListOnTap(BuildContext context, String eventId) {
    print('Event ID: ${eventId}');

    // Trigger the event signup or event details action
    final orgEventBloc = BlocProvider.of<orgVoluEventBloc>(context);
    final orgEventState = orgEventBloc.state;

    final upcomingEventsList =
        BlocProvider.of<EventListBloc>(context).state.upcomingEventsList;

    final selectedEvent = upcomingEventsList != null
        ? upcomingEventsList.firstWhere((element) => element.eventId == eventId)
        : null;

    if (orgEventState.showalluserevents) {
      context.read<orgVoluEventBloc>().add(eventsignupEvent(eventId));
    } else if (orgEventState.showallorgevents &&
        getUserRole(context) == "Organization") {
      context
          .read<orgVoluEventBloc>()
          .add(eventdetailsEvent(eventId, selectedEvent!));
    } else if (orgEventState.approvehours) {
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
    } else if (orgEventState.manageEvents) {
      context
          .read<orgVoluEventBloc>()
          .add(eventdetailsEvent(eventId, selectedEvent!));
    } else if (orgEventState.eventDetails) {
      context
          .read<orgVoluEventBloc>()
          .add(eventdetailsEvent(eventId, selectedEvent!));
    }
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
