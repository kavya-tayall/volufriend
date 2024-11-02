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
    this.onWithdraw,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _foldingCellKey = GlobalKey<SimpleFoldingCellState>();

    return GestureDetector(
      onTap: () {
        _foldingCellKey.currentState?.toggleFold();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
        child: SimpleFoldingCell.create(
          key: _foldingCellKey,
          frontWidget: _buildFrontWidget(context, _foldingCellKey),
          innerWidget: _buildInnerWidget(context, _foldingCellKey),
          cellSize: Size(MediaQuery.of(context).size.width, 110),
          padding: const EdgeInsets.all(8),
          animationDuration: const Duration(milliseconds: 300),
          borderRadius: 10,
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
          borderRadius: BorderRadius.circular(10),
          color: isFirstRow ? Theme.of(context).primaryColor : Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 1),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isFirstRow)
              Text(
                "Your next volunteering event is",
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            if (isFirstRow) const SizedBox(height: 2.0),
            Text(
              eventName,
              style: TextStyle(
                color: isFirstRow ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6.0),
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: isFirstRow ? Colors.white70 : Colors.grey[700],
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    _formatDate(eventDate),
                    style: TextStyle(
                      fontSize: 12,
                      color: isFirstRow ? Colors.white70 : Colors.grey[700],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            Row(
              children: [
                Icon(
                  Icons.location_pin,
                  size: 14,
                  color: isFirstRow ? Colors.white70 : Colors.grey[700],
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    location,
                    style: TextStyle(
                      fontSize: 12,
                      color: isFirstRow ? Colors.white70 : Colors.grey[700],
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
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 6, spreadRadius: 1),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.access_time, size: 14, color: Colors.teal),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    '$shift1Name: ${_formatTime(shift1StartTime)} - ${_formatTime(shift1EndTime)}',
                    style: const TextStyle(fontSize: 12, color: Colors.black87),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6.0),
            if (shift2Name != null &&
                shift2StartTime != null &&
                shift2EndTime != null)
              Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: Colors.teal),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      '$shift2Name: ${_formatTime(shift2StartTime!)} - ${_formatTime(shift2EndTime!)}',
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black87),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    text: "Withdraw",
                    onPressed: onWithdraw, // Use the passed callback
                    buttonStyle: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: CustomElevatedButton(
                    text: "Edit",
                    onPressed: () {
                      cellKey.currentState?.toggleFold(); // Close after action
                    },
                    buttonStyle: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
    final DateFormat formatter = DateFormat('EEE, MMM d');
    return formatter.format(date);
  }

  String _formatTime(DateTime time) {
    final DateFormat timeFormatter = DateFormat('h:mm a');
    return timeFormatter.format(time);
  }
}
