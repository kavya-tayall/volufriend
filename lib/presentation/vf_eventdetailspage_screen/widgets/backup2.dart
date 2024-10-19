import 'package:flutter/material.dart';

class EventListTile extends StatelessWidget {
  final String eventName;
  final String eventDescription;
  final int minAge;
  final int registeredParticipants;
  final int totalParticipants;
  final String startTime;
  final String endTime;

  const EventListTile({
    Key? key,
    required this.eventName,
    required this.eventDescription,
    required this.minAge,
    required this.registeredParticipants,
    required this.totalParticipants,
    required this.startTime,
    required this.endTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event Name (Header)
            Text(
              eventName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Event Description (Event Details)
            Text(
              eventDescription,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            // Event Minimum Age (Supporting Information)
            Row(
              children: [
                const Icon(Icons.cake, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  'Minimum Age: $minAge',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Event Registered / Total Participants (Supporting Information)
            Row(
              children: [
                const Icon(Icons.people, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text(
                  'Participants: $registeredParticipants / $totalParticipants',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Event Start and End Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.schedule, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(
                      'Start: $startTime',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.schedule, color: Colors.redAccent),
                    const SizedBox(width: 8),
                    Text(
                      'End: $endTime',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
