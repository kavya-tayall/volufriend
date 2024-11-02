import 'package:flutter/material.dart';
import 'package:volufriend/presentation/vf_homescreen_container_screen/bloc/vf_homescreen_container_bloc.dart';
import 'package:volufriend/widgets/vf_app_bar_with_title_back_button.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/vf_eventsignupscreen_bloc.dart';
import 'models/vf_eventsignupscreen_model.dart';
import 'widgets/shiftlist_tile_item_widget.dart';
import '../../crud_repository/volufriend_crud_repo.dart';
import 'package:volufriend/auth/bloc/org_event_bloc.dart';
import '../../auth/bloc/login_user_bloc.dart';
import 'package:intl/intl.dart';

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
          if (orgEventState.isLoading) {
            print('Create mode started');
          }
        },
        builder: (context, orgEventState) {
          final eventId = orgEventState.eventId ?? '';
          final userBloc = BlocProvider.of<UserBloc>(context);
          final userState = userBloc.state;

          if (userState is LoginUserWithHomeOrg) {
            final userId = userState.userId;
            final userHomeOrg = userState.user.userHomeOrg;
            final String? orgId = userHomeOrg?.orgid;

            context.read<VfEventsignupscreenBloc>().add(
                  VfEventsignupscreenInitialEvent(
                    eventId,
                    userId ?? '',
                    orgId ?? '',
                  ),
                );
          }

          return const VfEventsignupscreenScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const VfAppBarWithTitleBackButton(
          title: 'Event Sign Up',
          showSearchIcon: false,
          showFilterIcon: false,
        ),
        body: BlocListener<VfEventsignupscreenBloc, VfEventsignupscreenState>(
          listenWhen: (previous, current) =>
              previous.successMessage != current.successMessage &&
              current.successMessage!.isNotEmpty,
          listener: (context, state) {
            if (state.successMessage!.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.successMessage ?? ''),
                  backgroundColor: Colors.green,
                ),
              );
            }
          },
          child: BlocSelector<VfEventsignupscreenBloc, VfEventsignupscreenState,
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
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildEventDetails(
                              context, vfEventsignupscreenModelObj),
                          const SizedBox(height: 16),
                          Text(
                            "Select Shifts",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: const Color(0xFF0070BB)),
                          ),
                          const SizedBox(height: 8),
                          _buildShiftSelection(context,
                              vfEventsignupscreenModelObj.orgEvent!.shifts),
                          const SizedBox(height: 40),
                          Center(
                            child: CustomElevatedButton(
                              width: 120,
                              text: "Sign Up",
                              onPressed: () {
                                final List<String> selectedShiftIds = [];
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
      color: Colors.white,
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
                        "Organizer: ${vfEventsignupscreenModelObj.orgEvent?.orgName ?? 'Unknown Organizer'}",
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
                        "Venue: ${vfEventsignupscreenModelObj.orgEvent!.address ?? 'Unknown Address'}",
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
                  .bodyMedium!
                  .copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                context
                    .read<VfEventsignupscreenBloc>()
                    .add(ToggleContactInfoEvent());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0070BB),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: BlocBuilder<VfEventsignupscreenBloc,
                  VfEventsignupscreenState>(
                builder: (context, state) {
                  return Text(state.showContactInfo
                      ? 'Hide Coordinator Info'
                      : 'Show Coordinator Info');
                },
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
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: Colors.black87), // Improved visibility
                      ),
                      _buildContactInfo(context),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
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
        Icon(icon, color: const Color(0xFF0070BB), size: isTitle ? 24 : 20),
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
        Icon(icon, color: const Color(0xFF0070BB), size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color:
                      Colors.black87, // Improved text color for better contrast
                  decoration: isEmail ? TextDecoration.underline : null,
                ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildShiftSelection(BuildContext context, List<Shift> shifts) {
    return BlocBuilder<VfEventsignupscreenBloc, VfEventsignupscreenState>(
      builder: (context, state) {
        if (shifts.isEmpty) {
          return const Center(child: Text('No shifts available.'));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: shifts.length,
          itemBuilder: (context, index) {
            final shift = shifts[index];
            return EventListTile(
              key: ValueKey(shift.shiftId),
              eventName: shift.activity,
              minAge: shift.minAge ?? 0,
              registeredParticipants: shift.numberOfParticipants ?? 0,
              totalParticipants: shift.maxNumberOfParticipants ?? 0,
              startTime: DateFormat('hh:mm a').format(shift.startTime),
              endTime: DateFormat('hh:mm a').format(shift.endTime),
              isSelected: state.selectedShifts[index],
              onSelected: (value) {
                final shiftId = key.toString();
                context.read<VfEventsignupscreenBloc>().add(
                      ToggleShiftSelectionEvent(index, value ?? false, shiftId),
                    );
              },
            );
          },
        );
      },
    );
  }
}
