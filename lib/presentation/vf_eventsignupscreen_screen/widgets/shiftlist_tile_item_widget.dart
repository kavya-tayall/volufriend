import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class EventListTile extends StatelessWidget {
  final String eventName;
  final int minAge;
  final int registeredParticipants;
  final int totalParticipants;
  final String startTime;
  final String endTime;
  final bool isSelected;
  final Function(bool?) onSelected;

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
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
        child: Stack(
          children: [
            // Min Age Label at the top-left corner with a clean design
            Positioned(
              top: 4,
              left: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.cake_rounded, // Softer icon to indicate min age
                        size: 16,
                        color: Colors.teal[700],
                      ),
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
                  ),
                  const SizedBox(
                      height: 8), // Little vertical space after Min Age
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8), // Adjusted to avoid overlapping with Min Age
              child: Row(
                children: [
                  // Checkbox
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

                  // Event details (left section)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Event Name (Unbolded)
                        Text(
                          eventName,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.normal, // Unbolded
                                    fontSize: 14,
                                    color: Colors.teal[900],
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),

                        // Start and End time (Unbolded)
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.teal[700],
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$startTime - $endTime',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: Colors.teal[900],
                                    fontWeight: FontWeight.normal, // Unbolded
                                    fontSize: 12,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Participant Circle Indicator with Spots Left Label
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 6),

                      // Participant Circle
                      _buildParticipantIndicator(context),

                      const SizedBox(height: 4),

                      // Spots Left below the Circle
                      Text(
                        '${totalParticipants - registeredParticipants} spots left',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.grey[600],
                              fontSize: 10,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Circular indicator for participants
  Widget _buildParticipantIndicator(BuildContext context) {
    return CircularPercentIndicator(
      radius: 18.0, // Reduced the radius for a smaller circle
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
    );
  }
}
