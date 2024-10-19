import 'package:flutter/material.dart';
import 'package:volufriend/presentation/vf_homescreen_container_screen/bloc/vf_homescreen_container_bloc.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/vf_eventsignupscreen_bloc.dart';
import 'models/vf_eventsignupscreen_model.dart';
import 'widgets/shiftlist_tile_item_widget.dart';
import '../../crud_repository/volufriend_crud_repo.dart';
import 'package:volufriend/auth/bloc/org_event_bloc.dart';
import '../../auth/bloc/login_user_bloc.dart';
import 'package:intl/intl.dart';

/*
// Define the Shift class if not already defined
class Shift {
  final String eventName;
  final int minAge;
  final int registeredParticipants;
  final int totalParticipants;
  final String startTime;
  final String endTime;

  Shift({
    required this.eventName,
    required this.minAge,
    required this.registeredParticipants,
    required this.totalParticipants,
    required this.startTime,
    required this.endTime,
  });
}

// Example shifts
final List<Shift> shifts = [
  Shift(
    eventName: 'Community Cleanup',
    minAge: 15,
    registeredParticipants: 5,
    totalParticipants: 10,
    startTime: '9:00 AM',
    endTime: '11:00 AM',
  ),
  Shift(
    eventName: 'Coding Workshop',
    minAge: 13,
    registeredParticipants: 12,
    totalParticipants: 15,
    startTime: '1:00 PM',
    endTime: '3:00 PM',
  ),
];*/

class VfEventsignupscreenScreen extends StatelessWidget {
  const VfEventsignupscreenScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    final vfcrudService = VolufriendCrudService();

    return BlocProvider<VfEventsignupscreenBloc>(
      create: (context) => VfEventsignupscreenBloc(
        initialState: VfEventsignupscreenState(
          vfEventsignupscreenModelObj: const VfEventsignupscreenModel(),
        ),
        vfcrudService: vfcrudService,
      ),
      child: BlocConsumer<orgVoluEventBloc, orgVoluEventState>(
        listener: (context, orgEventState) {
          // Listener for state changes
          print('Event details screen state: $orgEventState');

          if (orgEventState.isLoading) {
            print('Create mode started');
            // Handle any actions for create mode, like showing a loader
          }
        },
        builder: (context, orgEventState) {
          String formContext = '';

          // Access state properties
          final eventId = orgEventState.eventId ?? ''; // Non-null eventId
          final isCreateMode = orgEventState.isLoading;

          if (isCreateMode) {
            print('Create mode started');
            formContext = 'create';
          } else {
            print('Edit mode started');
            formContext = 'edit';
          }

          // Logging for debugging
          print('eventId: $eventId');
          print('formContext: $formContext');

          final userBloc = BlocProvider.of<UserBloc>(context);
          final userState = userBloc.state;

          // Check user login state and fire the event
          if (userState is LoginUserWithHomeOrg) {
            print('User is logged in with home org');
            // Access user properties
            final userId = userState.userId;
            final userHomeOrg = userState.user.userHomeOrg;
            final String? orgId = userHomeOrg?.orgid;
            //final String? usrorgid = userHomeOrg?.useridinorg;

            // Dispatch initial event
            context.read<VfEventsignupscreenBloc>().add(
                  VfEventsignupscreenInitialEvent(
                    eventId,
                    userId ?? '',
                    orgId ?? '',
                  ),
                );
          }

          // Return the actual screen widget
          return const VfEventsignupscreenScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<VfEventsignupscreenBloc, VfEventsignupscreenState>(
        listenWhen: (previous, current) =>
            previous.successMessage != current.successMessage &&
            current.successMessage!.isNotEmpty,
        listener: (context, state) {
          if (state.successMessage!.isNotEmpty) {
            // Show the success message in a SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage ?? ''),
                backgroundColor: Colors.green, // Optional styling
              ),
            );
          }
        },
        child: Scaffold(
          body: BlocSelector<VfEventsignupscreenBloc, VfEventsignupscreenState,
              VfEventsignupscreenModel?>(
            selector: (state) => state.vfEventsignupscreenModelObj,
            builder: (context, vfEventsignupscreenModelObj) {
              if (vfEventsignupscreenModelObj == null) {
                return const Center(child: CircularProgressIndicator());
              }

              if (vfEventsignupscreenModelObj.orgEvent == null) {
                return const Center(child: Text('No event data available'));
              }

              return Column(
                children: [
                  SizedBox(height: 50.h),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildEventDetails(
                              context, vfEventsignupscreenModelObj),
                          SizedBox(height: 6.h),
                          Text(
                            "lbl_select_shifts".tr,
                            style: CustomTextStyles.titleMediumGray90003,
                          ),
                          SizedBox(height: 8.h),
                          _buildShiftSelection(context,
                              vfEventsignupscreenModelObj.orgEvent!.shifts),
                          SizedBox(height: 40.h),
                          Center(
                            child: CustomElevatedButton(
                              width: 106.h,
                              text: "lbl_sign_up".tr,
                              onPressed: () {
                                final List<String> selectedShiftIds =
                                    []; // Gather selected shift IDs from your state or UI
                                context.read<VfEventsignupscreenBloc>().add(
                                      SaveEventSignUp(selectedShiftIds),
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEventDetails(
    BuildContext context,
    VfEventsignupscreenModel vfEventsignupscreenModelObj,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/img_eventpicture1.png',
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(
                        context,
                        Icons.event,
                        vfEventsignupscreenModelObj.orgEvent?.title ??
                            'No Title',
                        isTitle: true,
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        context,
                        Icons.group,
                        "Organizer: " +
                            (vfEventsignupscreenModelObj.orgEvent?.orgName ??
                                'Unknown Organizer'),
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        context,
                        Icons.calendar_today,
                        vfEventsignupscreenModelObj.orgEvent?.startDate != null
                            ? DateFormat('EEEE, MMMM d, yyyy').format(
                                vfEventsignupscreenModelObj
                                    .orgEvent!.startDate!)
                            : 'Unknown Date',
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        context,
                        Icons.location_on,
                        "Venue: " +
                            (vfEventsignupscreenModelObj.orgEvent!.address ??
                                'Unknown Address'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              vfEventsignupscreenModelObj.orgEvent?.description ??
                  'No Description',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Dispatch an event to update the visibility state
                context
                    .read<VfEventsignupscreenBloc>()
                    .add(ToggleContactInfoEvent());
              },
              child: BlocBuilder<VfEventsignupscreenBloc,
                  VfEventsignupscreenState>(
                builder: (context, state) {
                  return Text(state.showContactInfo
                      ? 'Hide Coordinator Info'
                      : 'Show Coordinator Info');
                },
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            BlocBuilder<VfEventsignupscreenBloc, VfEventsignupscreenState>(
              builder: (context, state) {
                if (state.showContactInfo) {
                  return Column(
                    children: [
                      const Divider(),
                      Text(
                        "Coordinator Contact Information",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.black87),
                      ),
                      _buildContactInfo(
                          context), // Assuming _buildContactInfo is defined
                    ],
                  );
                } else {
                  return SizedBox
                      .shrink(); // Return an empty widget when hidden
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String text,
      {bool isTitle = false}) {
    return Row(
      children: [
        Icon(icon, color: Colors.green, size: isTitle ? 24 : 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: isTitle
                ? Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.black87)
                : Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey[700]),
          ),
        ),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactRow(context, Icons.person, "Peggy Brown"),
            const SizedBox(height: 8),
            _buildContactRow(context, Icons.phone, "+1 409-456-7889"),
            const SizedBox(height: 8),
            _buildContactRow(context, Icons.email, "peg23_smith@nsd.org",
                isEmail: true),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(BuildContext context, IconData icon, String text,
      {bool isEmail = false}) {
    return Row(
      children: [
        Icon(icon, color: Colors.green, size: 20),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.black87,
                decoration: isEmail ? TextDecoration.underline : null,
              ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildShiftSelection(BuildContext context, List<Shift> shifts) {
    return BlocBuilder<VfEventsignupscreenBloc, VfEventsignupscreenState>(
      builder: (context, state) {
        // Check if shifts are available
        if (shifts.isEmpty) {
          return Center(child: Text('No shifts available.'));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: shifts.length,
          itemBuilder: (context, index) {
            final shift = shifts[index];
            // print("shift: $shift");
            return EventListTile(
              key: ValueKey(shift.shiftId), // Assigning the shiftId as key
              eventName: shift.activity,
              minAge: shift.minAge ?? 0,
              registeredParticipants: shift.numberOfParticipants ?? 0,
              totalParticipants: shift.maxNumberOfParticipants ?? 0,
              startTime: DateFormat('hh:mm a').format(shift.startTime),
              endTime: DateFormat('hh:mm a').format(shift.endTime),
              isSelected: state.selectedShifts[index], // Bind to selected state
              onSelected: (value) {
                // Retrieve the shiftId along with the selection
                final shiftId = key.toString();
                //  print("shiftId: $shiftId");
                // Pass both the index and shiftId to the BLoC event
                context.read<VfEventsignupscreenBloc>().add(
                      ToggleShiftSelectionEvent(
                          index, value ?? false, shiftId ?? ''),
                    );
              },
            );
          },
        );
      },
    );
  }
}
