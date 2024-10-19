import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/vf_eventdetailspage_bloc.dart';
import 'models/vf_eventdetailspage_model.dart';
import 'widgets/shiftlist_tile_item_widget.dart';
import '../../crud_repository/volufriend_crud_repo.dart';
import 'package:volufriend/auth/bloc/org_event_bloc.dart';
import 'package:intl/intl.dart';

class VfEventdetailspageScreen extends StatelessWidget {
  const VfEventdetailspageScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    final vfcrudService = VolufriendCrudService();

    return BlocProvider<VfEventsdetailspageBloc>(
      create: (context) => VfEventsdetailspageBloc(
        initialState: VfEventsdetailspageState(
          vfEventdetailsModelObj: const VfEventdetailspageModel(),
        ),
        vfcrudService: vfcrudService,
      ),
      child: BlocConsumer<orgVoluEventBloc, orgVoluEventState>(
        listener: (context, orgEventState) {},
        builder: (context, orgEventState) {
          final Voluevents? selectedevent =
              BlocProvider.of<orgVoluEventBloc>(context).state.eventSelected;

          if (selectedevent != null) {
            context.read<VfEventsdetailspageBloc>().add(
                  VfEventdetailspageInitialEvent(selectedevent),
                );
          }

          return const VfEventdetailspageScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<VfEventsdetailspageBloc, VfEventsdetailspageState>(
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
        child: Scaffold(
          body: BlocSelector<VfEventsdetailspageBloc, VfEventsdetailspageState,
              VfEventdetailspageModel?>(
            selector: (state) => state.vfEventdetailsModelObj,
            builder: (context, vfEventdetailsModelObj) {
              if (vfEventdetailsModelObj == null) {
                return const Center(child: CircularProgressIndicator());
              }

              if (vfEventdetailsModelObj.orgEvent == null) {
                return const Center(child: Text('No event data available'));
              }

              return Column(
                children: [
                  SizedBox(height: 30.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: _buildOrganizerEventOverview(
                        context, vfEventdetailsModelObj),
                  ),
                  const Divider(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildEventDetails(context, vfEventdetailsModelObj),
                          SizedBox(height: 6.h),
                          _buildParticipantSummary(
                              context, vfEventdetailsModelObj),
                          const SizedBox(height: 5),
                          _buildShiftSelection(
                              context, vfEventdetailsModelObj.orgEvent!.shifts),
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

  // Event overview panel with quick summary for organizers
  Widget _buildOrganizerEventOverview(
      BuildContext context, VfEventdetailspageModel vfEventdetailsModelObj) {
    final event = vfEventdetailsModelObj.orgEvent!;
    final DateTime now = DateTime.now();
    final int daysToGo = event.startDate!.difference(now).inDays;
    final int participantsSignedUp = event.totalEventSignups ?? 0;
    final int totalParticipantsAllowed =
        (event.shifts[0].maxNumberOfParticipants ?? 0) +
            (event.shifts[1].maxNumberOfParticipants ?? 0);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: ${event.eventStatus ?? "Unknown"}',
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                Text(
                  '$daysToGo days to go',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.redAccent, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit, color: Colors.green),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantSummary(
      BuildContext context, VfEventdetailspageModel vfEventdetailsModelObj) {
    final totalSignups =
        vfEventdetailsModelObj.orgEvent?.totalEventSignups ?? 0;
    final maxParticipants = (vfEventdetailsModelObj
                .orgEvent?.shifts[0].maxNumberOfParticipants ??
            0) +
        (vfEventdetailsModelObj.orgEvent?.shifts[1].maxNumberOfParticipants ??
            0);

    final progress = maxParticipants > 0 ? totalSignups / maxParticipants : 0;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Participant Summary',
              //   style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress.toDouble(),
              backgroundColor: Colors.grey.shade200,
              color: Colors.green,
            ),
            const SizedBox(height: 8),
            Text(
              '$totalSignups out of $maxParticipants participants have signed up.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventDetails(
    BuildContext context,
    VfEventdetailspageModel vfEventdetailsModelObj,
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
                        vfEventdetailsModelObj.orgEvent?.title ?? 'No Title',
                        isTitle: true,
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        context,
                        Icons.group,
                        "Organizer: " +
                            (vfEventdetailsModelObj.orgEvent?.orgName ??
                                'Unknown Organizer'),
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        context,
                        Icons.calendar_today,
                        vfEventdetailsModelObj.orgEvent?.startDate != null
                            ? DateFormat('EEEE, MMMM d, yyyy').format(
                                vfEventdetailsModelObj.orgEvent!.startDate!)
                            : 'Unknown Date',
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        context,
                        Icons.location_on,
                        "Venue: " +
                            (vfEventdetailsModelObj.orgEvent?.address ??
                                'Unknown Address'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              vfEventdetailsModelObj.orgEvent?.description ?? 'No Description',
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  // Event Shift section
  Widget _buildShiftSelection(BuildContext context, List<Shift> shifts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Shifts',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          itemCount: shifts.length,
          itemBuilder: (context, index) {
            return ShiftlistTileItemWidget(shifts[index]);
          },
        ),
      ],
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String text,
      {bool isTitle = false}) {
    return Row(
      crossAxisAlignment:
          isTitle ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: Colors.black54),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            //   style: isTitle
            //     ? Theme.of(context).textTheme.titleMedium
            //   : Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
