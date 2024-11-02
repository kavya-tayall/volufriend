import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'vf_app_bar_with_title_back_button.dart';

class FilterPage extends StatefulWidget {
  final void Function({
    required String? timeOfDay, // Make nullable to handle deselection
    required DateTimeRange? dateRange,
    required List<String> daysOfWeek,
  }) onApplyFilters;

  const FilterPage({Key? key, required this.onApplyFilters}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  String? selectedTimeOfDay = ''; // Nullable to allow deselection
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

  void toggleDayOfWeek(String day) {
    setState(() {
      if (selectedDaysOfWeek.contains(day)) {
        selectedDaysOfWeek.remove(day);
      } else {
        selectedDaysOfWeek.add(day);
      }
    });
  }

  void selectTimeOfDay(String time) {
    setState(() {
      selectedTimeOfDay = selectedTimeOfDay == time ? null : time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VfAppBarWithTitleBackButton(
        title: 'Filter Events',
        onBackPressed: () {
          Navigator.of(context).pop();
        },
        showSearchIcon: false,
        showFilterIcon: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSection(
              title: 'Time of the Day',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: timeOfDayOptions.map((time) {
                  IconData icon = Icons.wb_sunny;
                  if (time == 'Morning') icon = Icons.wb_sunny_outlined;
                  if (time == 'Evening') icon = Icons.nights_stay_outlined;

                  return GestureDetector(
                    onTap: () => selectTimeOfDay(time),
                    child: Column(
                      children: [
                        Icon(
                          icon,
                          size: 40,
                          color: selectedTimeOfDay == time
                              ? Colors.blueAccent
                              : Colors.grey,
                        ),
                        Text(time),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            buildSection(
              title: 'Date Range',
              child: GestureDetector(
                onTap: () => selectDateRange(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.date_range_outlined, color: Colors.blueAccent),
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
            ),
            const SizedBox(height: 24),
            buildSection(
              title: 'Day of the Week',
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: daysOfWeekOptions.map((day) {
                  final bool isSelected = selectedDaysOfWeek.contains(day);
                  return GestureDetector(
                    onTap: () => toggleDayOfWeek(day),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? Colors.blueAccent : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(12),
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
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  widget.onApplyFilters(
                    timeOfDay: selectedTimeOfDay,
                    dateRange: selectedDateRange,
                    daysOfWeek: selectedDaysOfWeek,
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0070BB),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: const Text(
                  'Apply Filters',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection({required String title, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}
