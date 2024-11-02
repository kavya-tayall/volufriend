import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<List<Map<String, String>>> filteredEventsNotifier =
      ValueNotifier<List<Map<String, String>>>([]);
  final ValueNotifier<String?> selectedCauseNotifier =
      ValueNotifier<String?>(null); // Use ValueNotifier for selectedCause

  final List<String> socialCauses;
  final List<Map<String, String>> allEvents;
  final void Function(Map<String, String> event)? onEventTap;

  SearchPage({
    Key? key,
    required this.socialCauses,
    required this.allEvents,
    this.onEventTap,
  }) : super(key: key);

  // Combined filtering function for search query and selected cause
  void filterEvents(String query) {
    filteredEventsNotifier.value = allEvents.where((event) {
      final matchesQuery = query.isEmpty ||
          event['title']!.toLowerCase().contains(query.toLowerCase()) ||
          event['cause']!.toLowerCase().contains(query.toLowerCase()) ||
          event['org_name']!.toLowerCase().contains(query.toLowerCase());

      final matchesCause = selectedCauseNotifier.value == null ||
          event['cause']!.toLowerCase() ==
              selectedCauseNotifier.value!.toLowerCase();

      return matchesQuery && matchesCause;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize filtered events with all events initially
    filteredEventsNotifier.value = allEvents;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Search Events',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0XFF0070BB),
        centerTitle: true,
        elevation: 4.0,
        toolbarHeight: 70,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: "Search by event name, cause, or organization",
                labelStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: const Color(0XFF0070BB)),
                ),
                prefixIcon: Icon(Icons.search, color: const Color(0XFF0070BB)),
              ),
              onChanged: (query) {
                filterEvents(query);
              },
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  Flexible(
                    child: ValueListenableBuilder<String?>(
                      valueListenable: selectedCauseNotifier,
                      builder: (context, selectedCause, child) {
                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Filter by social cause',
                            labelStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          dropdownColor: Colors.white,
                          style: TextStyle(color: Colors.black),
                          items: socialCauses.map((String cause) {
                            return DropdownMenuItem<String>(
                              value: cause,
                              child: Text(cause),
                            );
                          }).toList(),
                          onChanged: (newCause) {
                            selectedCauseNotifier.value = newCause;
                            filterEvents(searchController.text);
                          },
                          value: selectedCauseNotifier.value,
                        );
                      },
                    ),
                  ),
                  // Show clear icon only when there's a valid selection
                  ValueListenableBuilder<String?>(
                    valueListenable: selectedCauseNotifier,
                    builder: (context, selectedCause, child) {
                      return selectedCause != null
                          ? IconButton(
                              icon: Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                selectedCauseNotifier.value = null;
                                filterEvents(searchController.text);
                              },
                            )
                          : Container();
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ValueListenableBuilder<List<Map<String, String>>>(
                valueListenable: filteredEventsNotifier,
                builder: (context, filteredEvents, child) {
                  if (filteredEvents.isEmpty) {
                    return Center(
                      child: Text(
                        'No events found.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: filteredEvents.length,
                      itemBuilder: (context, index) {
                        final event = filteredEvents[index];
                        return GestureDetector(
                          onTap: () {
                            if (onEventTap != null) {
                              onEventTap!(event);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 56,
                                  width: 56,
                                  child:
                                      Placeholder(), // Placeholder for event image
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        event['title'] ?? '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.lightBlue[900]),
                                      ),
                                      Text(
                                        "Cause: ${event['cause'] ?? ''} | Org: ${event['org_name'] ?? ''}",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
