import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilterPage extends StatefulWidget {
  final void Function({
    required String timeOfDay,
    required DateTimeRange? dateRange,
    required List<String> daysOfWeek,
  }) onApplyFilters;

  const FilterPage({Key? key, required this.onApplyFilters}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String selectedTimeOfDay = 'Morning'; // Default value
  DateTimeRange? selectedDateRange;
  List<String> selectedDaysOfWeek = [];

  final List<String> timeOfDayOptions = ['Morning', 'Afternoon', 'Evening'];
  final List<String> daysOfWeekOptions = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  // Function to open date range picker
  Future<void> selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      initialDateRange: selectedDateRange,
    );
    if (picked != null && picked != selectedDateRange) {
      setState(() {
        selectedDateRange = picked;
      });
    }
  }

  // Function to toggle selected days of the week
  void toggleDayOfWeek(String day) {
    setState(() {
      if (selectedDaysOfWeek.contains(day)) {
        selectedDaysOfWeek.remove(day);
      } else {
        selectedDaysOfWeek.add(day);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Events'),
        backgroundColor: const Color(0xFF0070BB),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time of the Day Filter with icons
            const Text('Time of the Day:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: timeOfDayOptions.map((time) {
                IconData icon;
                if (time == 'Morning') {
                  icon = Icons.wb_sunny_outlined; // Morning icon
                } else if (time == 'Afternoon') {
                  icon = Icons.wb_sunny; // Afternoon icon
                } else {
                  icon = Icons.nights_stay_outlined; // Evening icon
                }
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTimeOfDay = time;
                    });
                  },
                  child: Column(
                    children: [
                      Icon(
                        icon,
                        size: 40,
                        color: selectedTimeOfDay == time
                            ? Colors.blue
                            : Colors.grey,
                      ),
                      Text(time),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Date Range Filter with calendar icon
            const Text('Date Range:', style: TextStyle(fontSize: 16)),
            GestureDetector(
              onTap: () => selectDateRange(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.date_range_outlined, color: Colors.blue),
                    const SizedBox(width: 10),
                    Text(
                      selectedDateRange == null
                          ? 'Select Date Range'
                          : '${DateFormat('yyyy/MM/dd').format(selectedDateRange!.start)} - ${DateFormat('yyyy/MM/dd').format(selectedDateRange!.end)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Day of the Week Filter with icons
            const Text('Day of the Week:', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: daysOfWeekOptions.map((day) {
                final bool isSelected = selectedDaysOfWeek.contains(day);
                return GestureDetector(
                  onTap: () => toggleDayOfWeek(day),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 30,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                        Text(
                          day,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Apply Filters Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'timeOfDay': selectedTimeOfDay,
                    'dateRange': selectedDateRange,
                    'daysOfWeek': selectedDaysOfWeek,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0070BB),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Apply Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
