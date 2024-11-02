import 'package:volufriend/crud_repository/models/volufriendusermodels.dart';
import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';

class EventCache {
  final int _cacheSize = 10;
  final VolufriendCrudService vfcrudService;
  final String userId;

  List<Voluevents> _cachedRecords = [];
  int _currentPage = 1;

  EventCache({required this.vfcrudService, required this.userId});

  // Method to load initial records (e.g., call this on app start)
  Future<void> loadInitialRecords() async {
    _cachedRecords = await fetchFromDatabaseOrNetwork(_currentPage);
    print("Initial records loaded: $_cachedRecords");
  }

  // Method to get cached records
  List<Voluevents> getEventCachedRecords() {
    return _cachedRecords;
  }

  // Method to fetch the next set of records and update the cache
  Future<void> fetchNextBatch() async {
    _currentPage++;
    final newRecords = await fetchFromDatabaseOrNetwork(_currentPage);
    _cachedRecords =
        [..._cachedRecords, ...newRecords].take(_cacheSize).toList();
    print("Updated cache with next batch: $_cachedRecords");
  }

  // Fetch data from the actual service
  Future<List<Voluevents>> fetchFromDatabaseOrNetwork(int page) async {
    try {
      // Pass any necessary parameters such as userId, and handle pagination as per your API's design.
      final List<Voluevents> upcomingEventsData =
          await vfcrudService.getUpcomingEventsforOrgUserPageWise(userId,
              page: page, pageSize: _cacheSize);
      return upcomingEventsData;
    } catch (e) {
      print("Error fetching data: $e");
      return []; // Return an empty list on failure
    }
  }
}
