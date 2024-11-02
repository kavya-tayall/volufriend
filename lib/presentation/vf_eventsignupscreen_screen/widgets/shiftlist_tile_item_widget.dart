import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:volufriend/core/app_export.dart';

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
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Stack(
          children: [
            // Min Age Label at the top-left corner
            Positioned(
              top: 4,
              left: 4,
              child: Row(
                children: [
                  Icon(
                    Icons.cake_rounded,
                    size: 16,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Min Age: $minAge',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: theme.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  // Checkbox
                  Checkbox(
                    value: isSelected,
                    onChanged: onSelected,
                    activeColor: theme.primaryColor,
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
                        // Event Name
                        Text(
                          eventName,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: theme.primaryColor,
                                  ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),

                        // Start and End time
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: theme.primaryColor,
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '$startTime - $endTime',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: theme.primaryColor,
                                    fontWeight: FontWeight.normal,
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
      radius: 20.0,
      lineWidth: 4.0,
      animation: true,
      percent: registeredParticipants / totalParticipants,
      center: Text(
        '$registeredParticipants/$totalParticipants',
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: theme.primaryColor,
      backgroundColor: Colors.grey[300]!,
    );
  }
}
