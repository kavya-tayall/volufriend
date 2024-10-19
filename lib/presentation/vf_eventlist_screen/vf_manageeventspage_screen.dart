/*class ManageEventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Events'),
        actions: [
          // Search field in the AppBar
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: EventSearchDelegate(),
              );
            },
          ),
          // Filter Button
          IconButton(
            icon: Icon(Icons.filter_alt),
            onPressed: () {
              _openFilterDialog(context);
            },
          ),
        ],
      ),
      body: BlocBuilder<EventListBloc, VfEventListScreenState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return NotificationListener<ScrollEndNotification>(
            onNotification: (scrollEnd) {
              // Infinite Scroll
              if (scrollEnd.metrics.pixels ==
                  scrollEnd.metrics.maxScrollExtent) {
                context.read<EventListBloc>().add(LoadMoreEventsEvent());
              }
              return false;
            },
            child: ListView.builder(
              itemCount: state.eventList.length,
              itemBuilder: (context, index) {
                final event = state.eventList[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index == 0 ||
                        event.startDate
                                .difference(state.eventList[index - 1]
                                    .startDate)
                                .inDays >
                            0)
                      StickyHeader(
                        header: Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.grey[300],
                          child: Text(
                            DateFormat('MMMM dd').format(event.startDate),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        content: _buildEventTile(event, context),
                      ),
                    else
                      _buildEventTile(event, context),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  // Helper method to open the filter dialog
  void _openFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Filter Events'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildFilterOption('Event Status', [
                'Upcoming',
                'Completed',
              ]),
              _buildFilterOption('Event Type', [
                'Fundraiser',
                'Volunteer Event',
              ]),
              _buildDateRangePicker(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Apply Filters'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterOption(String title, List<String> options) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: title),
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: (String? newValue) {
        // Handle filter change
      },
    );
  }

  Widget _buildDateRangePicker() {
    return GestureDetector(
      onTap: () async {
        DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
        );
        if (picked != null) {
          // Handle date range selection
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Select Date Range',
        ),
        child: Text('Select a date range'),
      ),
    );
  }

  Widget _buildEventTile(EventModel event, BuildContext context) {
    return ListTile(
      title: Text(event.name),
      subtitle: Text(
        '${DateFormat('MMMM dd, yyyy').format(event.startDate)} - '
        '${DateFormat('h:mm a').format(event.startTime)}',
      ),
      trailing: Text('${event.volunteersRegistered} volunteers'),
      onTap: () {
        // Navigate to event details page
        Navigator.pushNamed(
          context,
          '/eventDetails',
          arguments: event,
        );
      },
    );
  }
}

// Custom Search Delegate for Event Search
class EventSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Return search results
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show search suggestions as user types
    return Container();
  }
}
*/