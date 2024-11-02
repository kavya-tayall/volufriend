import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/vf_eventdetailspage_bloc.dart';
import 'models/vf_eventdetailspage_model.dart';
import 'widgets/shiftlist_tile_item_widget.dart';
import '../../crud_repository/volufriend_crud_repo.dart';
import 'package:volufriend/auth/bloc/org_event_bloc.dart';
import 'package:intl/intl.dart';
import '../../widgets/vf_app_bar_with_title_back_button.dart';

class VfEventdetailspageScreen extends StatelessWidget {
  const VfEventdetailspageScreen({Key? key}) : super(key: key);

  static Widget builder(BuildContext context) {
    bool isEventInitialized = false;

    return BlocConsumer<orgVoluEventBloc, orgVoluEventState>(
      listener: (context, state) {},
      builder: (context, orgEventState) {
        final selectedEvent =
            context.read<orgVoluEventBloc>().state.eventSelected;
        if (selectedEvent != null && !isEventInitialized) {
          context
              .read<VfEventsdetailspageBloc>()
              .add(VfEventdetailspageInitialEvent(selectedEvent));
          isEventInitialized = true;
        }
        return const VfEventdetailspageScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<VfEventsdetailspageBloc, VfEventsdetailspageState>(
        listenWhen: (previous, current) {
          // Only trigger the listener if relevant state properties change
          return previous.isLoading != current.isLoading ||
              previous.cancelsucess != current.cancelsucess ||
              previous.successMessage != current.successMessage;
        },
        listener: (context, state) {
          print("In the listener of vf event details page");

          // Avoid further processing if the initial or loading state is active
          if (state == VfEventsdetailspageState.initial || state.isLoading)
            return;

          if (state.cancelsucess) {
            if (state.successMessage?.isNotEmpty ?? false) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.successMessage!),
                backgroundColor: Colors.green,
              ));
              NavigatorService.pushNamed(AppRoutes.vfHomescreenContainerScreen);
            }
          }
        },
        child: Scaffold(
          appBar: VfAppBarWithTitleBackButton(
            title: 'Event Details',
            onBackPressed: () => Navigator.of(context).pop(),
          ),
          body: BlocSelector<VfEventsdetailspageBloc, VfEventsdetailspageState,
              VfEventdetailspageModel?>(
            selector: (state) => state.vfEventdetailsModelObj,
            builder: (context, vfEventdetailsModelObj) {
              if (vfEventdetailsModelObj == null)
                return const Center(child: CircularProgressIndicator());
              if (vfEventdetailsModelObj.orgEvent == null)
                return const Center(child: Text('No event data available'));

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    _buildOrganizerEventOverview(
                        context, vfEventdetailsModelObj),
                    const Divider(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildEventDetails(context, vfEventdetailsModelObj),
                            const SizedBox(height: 8),
                            _buildParticipantSummary(
                                context, vfEventdetailsModelObj),
                            _buildShiftSelection(context,
                                vfEventdetailsModelObj.orgEvent!.shifts),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildOrganizerEventOverview(
      BuildContext context, VfEventdetailspageModel model) {
    final event = model.orgEvent!;
    final daysToGo = event.startDate!.difference(DateTime.now()).inDays;

    return Card(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: ${event.eventStatus ?? "Unknown"}',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 4),
                Text('$daysToGo days to go',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.redAccent)),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () => _handleMenuSelected(context, 'edit', model),
                  icon: const Icon(Icons.edit,
                      color: Colors.blueAccent, size: 20),
                ),
                IconButton(
                  onPressed: () =>
                      _handleMenuSelected(context, 'cancel', model),
                  icon: const Icon(Icons.cancel, color: Colors.red, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantSummary(
      BuildContext context, VfEventdetailspageModel model) {
    final totalSignups = model.orgEvent?.totalEventSignups ?? 0;
    final maxParticipants = model.orgEvent?.shifts.fold(
            0, (sum, shift) => sum + (shift.maxNumberOfParticipants ?? 0)) ??
        0;
    final progress = maxParticipants > 0 ? totalSignups / maxParticipants : 0;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Participant Summary',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 4),
            LinearProgressIndicator(
              value: progress.toDouble(),
              backgroundColor: Colors.grey.shade300,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 4),
            Text(
              '$totalSignups / $maxParticipants participants signed up.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventDetails(
      BuildContext context, VfEventdetailspageModel model) {
    final event = model.orgEvent!;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset('assets/images/img_eventpicture1.png',
                      height: 80, width: 80, fit: BoxFit.cover),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(
                          context, Icons.event, event.title ?? 'No Title',
                          isTitle: true),
                      const SizedBox(height: 6),
                      _buildDetailRow(context, Icons.group,
                          'Organizer: ${event.orgName ?? 'Unknown'}'),
                      const SizedBox(height: 6),
                      _buildDetailRow(
                        context,
                        Icons.calendar_today,
                        event.startDate != null
                            ? DateFormat('MMM d, yyyy').format(event.startDate!)
                            : 'Date not available',
                      ),
                      const SizedBox(height: 6),
                      _buildDetailRow(context, Icons.location_on,
                          'Venue: ${event.address ?? 'Unknown'}'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(event.description ?? 'No Description',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  Widget _buildShiftSelection(BuildContext context, List<Shift> shifts) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: shifts.length,
      itemBuilder: (context, index) => ShiftlistTileItemWidget(shifts[index]),
    );
  }

  Widget _buildDetailRow(BuildContext context, IconData iconData, String text,
      {bool isTitle = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(iconData, size: 20, color: Colors.grey),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: isTitle
                ? Theme.of(context).textTheme.bodyMedium
                : Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  void _handleMenuSelected(BuildContext context, String action,
      VfEventdetailspageModel? vfEventdetailsModelObj) {
    final selectedEvent = vfEventdetailsModelObj?.orgEvent;
    final id = selectedEvent?.eventId ?? '';
    if (action == 'edit' && selectedEvent != null) {
      context.read<orgVoluEventBloc>().add(UpdateEvent(id, selectedEvent));
    } else if (action == 'cancel') {
      _showCancelEventDialog(context, selectedEvent, id);
    }
  }

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
                    context.read<VfEventsdetailspageBloc>().add(
                        CancelSingleEventEvent(
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
}
