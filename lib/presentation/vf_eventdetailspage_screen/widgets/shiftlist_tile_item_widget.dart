import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:volufriend/crud_repository/models/voluevents.dart';
import 'package:intl/intl.dart';

class EventListTile extends StatelessWidget {
  final String eventName;
  final int minAge;
  final int registeredParticipants;
  final int totalParticipants;
  final String startTime;
  final String endTime;
  final bool isSelected;
  final ValueChanged<bool?> onSelected;

  const EventListTile({
    Key? key,
    required this.eventName,
    required this.minAge,
    required this.registeredParticipants,
    required this.totalParticipants,
    required this.startTime,
    required this.endTime,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Positioned(
              top: 4,
              left: 4,
              child: _buildMinAgeLabel(context),
            ),
            Row(
              children: [
                Checkbox(
                  value: isSelected,
                  onChanged: onSelected,
                  activeColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                const SizedBox(width: 6),
                Expanded(child: _buildEventDetails(context)),
                const SizedBox(width: 8),
                _buildParticipantIndicator(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMinAgeLabel(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.cake_rounded, size: 16, color: Colors.teal[700]),
        const SizedBox(width: 4),
        Text(
          'Min Age: $minAge',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.teal[700],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
        ),
      ],
    );
  }

  Widget _buildEventDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          eventName,
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                fontSize: 14,
                color: Colors.teal[900],
              ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.access_time, color: Colors.teal[700], size: 14),
            const SizedBox(width: 4),
            Text(
              '$startTime - $endTime',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.teal[900],
                    fontSize: 12,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildParticipantIndicator(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularPercentIndicator(
          radius: 18.0,
          lineWidth: 3.5,
          animation: true,
          percent: registeredParticipants / totalParticipants,
          center: Text(
            '$registeredParticipants/$totalParticipants',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.teal[900],
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
          ),
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: Colors.teal,
          backgroundColor: Colors.grey[300]!,
        ),
        const SizedBox(height: 4),
        Text(
          '${totalParticipants - registeredParticipants} spots left',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.grey[600],
                fontSize: 10,
              ),
        ),
      ],
    );
  }
}

class ShiftlistTileItemWidget extends StatelessWidget {
  final Shift shift;

  const ShiftlistTileItemWidget(this.shift, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if shift activity is null, blank, or empty
    if (shift.activity == null || shift.activity!.trim().isEmpty) {
      return const SizedBox
          .shrink(); // Return an empty widget if activity is invalid
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Shift: ${shift.activity ?? "Unknown Shift"}",
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal[900],
                  ),
            ),
            const SizedBox(height: 8),
            _buildDetailRow(
              context,
              Icons.access_time,
              'Start Time: ${formatTimeToAmPm(shift.startTime)}',
            ),
            _buildDetailRow(
              context,
              Icons.access_time,
              'End Time: ${formatTimeToAmPm(shift.endTime)}',
            ),
            _buildDetailRow(
              context,
              Icons.person,
              'Min Age: ${shift.minAge ?? "No age limit"}',
            ),
            _buildDetailRow(
              context,
              Icons.people,
              'Participants: ${shift.totalSignups ?? 0} / ${shift.maxNumberOfParticipants ?? "Unlimited"}',
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to format time to AM/PM
  String formatTimeToAmPm(DateTime? time) {
    if (time == null) return "Not Available";
    return DateFormat('h:mm a').format(time); // Formats to "12:00 PM"
  }

  Widget _buildDetailRow(BuildContext context, IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.teal[700]),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.teal[900],
                    fontSize: 12,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
