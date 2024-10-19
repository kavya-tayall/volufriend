import 'package:flutter/material.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:intl/intl.dart';
import '../../../widgets/custom_elevated_button.dart';

class EventTile extends StatelessWidget {
  final String eventName;
  final String location;
  final DateTime eventDate;
  final String shift1Name;
  final DateTime shift1StartTime;
  final DateTime shift1EndTime;
  final String? shift2Name;
  final DateTime? shift2StartTime;
  final DateTime? shift2EndTime;
  final bool isSelected;
  final bool isFirstRow;

  // New callback function to handle withdraw action
  final Function()? onWithdraw;

  EventTile({
    Key? key,
    required this.eventName,
    required this.location,
    required this.eventDate,
    required this.shift1Name,
    required this.shift1StartTime,
    required this.shift1EndTime,
    this.shift2Name,
    this.shift2StartTime,
    this.shift2EndTime,
    this.isSelected = false,
    this.isFirstRow = false,
    this.onWithdraw, // Add this to the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();

    return GestureDetector(
      onTap: () {
        _foldingCellKey.currentState?.toggleFold();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: SimpleFoldingCell.create(
          key: _foldingCellKey,
          frontWidget: _buildFrontWidget(context, _foldingCellKey),
          innerWidget: _buildInnerWidget(context, _foldingCellKey),
          cellSize: Size(MediaQuery.of(context).size.width, 130),
          padding: const EdgeInsets.all(10),
          animationDuration: const Duration(milliseconds: 300),
          borderRadius: 12,
        ),
      ),
    );
  }

  Widget _buildFrontWidget(
      BuildContext context, GlobalKey<SimpleFoldingCellState> cellKey) {
    return GestureDetector(
      onTap: () {
        cellKey.currentState?.toggleFold();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isFirstRow ? Theme.of(context).primaryColor : Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isFirstRow)
              Text(
                "Your next volunteering event is",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            if (isFirstRow) const SizedBox(height: 4.0),
            Text(
              eventName,
              style: TextStyle(
                color: isFirstRow ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 18,
                  color: isFirstRow ? Colors.white : Colors.black,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    _formatDate(eventDate),
                    style: TextStyle(
                      fontSize: 16,
                      color: isFirstRow ? Colors.white : Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 18,
                  color: isFirstRow ? Colors.white : Colors.black,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    location,
                    style: TextStyle(
                      fontSize: 16,
                      color: isFirstRow ? Colors.white : Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInnerWidget(
      BuildContext context, GlobalKey<SimpleFoldingCellState> cellKey) {
    return GestureDetector(
      onTap: () {
        cellKey.currentState?.toggleFold(); // Close on outside tap
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.access_time, size: 18, color: Colors.black),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    '$shift1Name: ${_formatTime(shift1StartTime)} - ${_formatTime(shift1EndTime)}',
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            if (shift2Name != null &&
                shift2StartTime != null &&
                shift2EndTime != null)
              Row(
                children: [
                  const Icon(Icons.access_time, size: 18, color: Colors.black),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      '$shift2Name: ${_formatTime(shift2StartTime!)} - ${_formatTime(shift2EndTime!)}',
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 12.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: CustomElevatedButton(
                    text: "Withdraw",
                    onPressed: onWithdraw, // Use the passed callback
                    buttonStyle: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: CustomElevatedButton(
                    text: "Edit",
                    onPressed: () {
                      cellKey.currentState?.toggleFold(); // Close after action
                    },
                    buttonStyle: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('EEEE, MMMM d');
    return formatter.format(date);
  }

  String _formatTime(DateTime time) {
    final DateFormat timeFormatter = DateFormat('h:mm a');
    return timeFormatter.format(time);
  }
}
