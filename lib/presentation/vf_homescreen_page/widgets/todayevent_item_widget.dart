import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';

class TodayEventWidget extends StatelessWidget {
  final Voluevents event; // Replace `Voluevents` with your actual Event model

  TodayEventWidget({required this.event});

  @override
  Widget build(BuildContext context) {
    if (event == null) return SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(12), // Made the padding smaller
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "Today’s Event" at the top left, moved slightly up
          Padding(
            padding:
                const EdgeInsets.only(bottom: 4), // Moves the text up a bit
            child: Text(
              "Today’s Event",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 13, // Slightly reduced font size
              ),
            ),
          ),

          // Main row with icon, event name, and check-in button
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Event Icon
              Icon(
                Icons.event_available,
                color: Colors.white,
                size: 28, // Reduced icon size
              ),
              SizedBox(width: 10),

              // Event Name and Time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${event.title ?? "Upcoming Event"} at ${DateFormat('h:mm a').format(event.shifts[0].startTime)}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16, // Reduced font size of event name
                      ),
                    ),
                  ],
                ),
              ),

              // Check-In Button (aligned to center right)
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      '/event-details',
                      arguments: event,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8), // Slightly smaller button
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Check-In",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 8),

          // Event Address at the bottom
          Row(
            children: [
              Icon(Icons.location_on,
                  color: Colors.white70, size: 14), // Reduced icon size
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  event.address ?? "Event location",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13, // Reduced font size of the address
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
