import 'package:volufriend/crud_repository/volufriend_crud_repo.dart';

class CauseCacheService {
  // Singleton pattern
  static final CauseCacheService _instance = CauseCacheService._internal();
  factory CauseCacheService() => _instance;
  CauseCacheService._internal();

  List<causes> _causesCache = [];

  Future<List<causes>> getCauses() async {
    // Check if cache is already populated
    if (_causesCache.isNotEmpty) {
      return _causesCache;
    }
    // Fetch and cache data if not already cached
    try {
      final causesData = await VolufriendCrudService().getcauses();
      _causesCache = causesData;
      return causesData;
    } catch (error) {
      print('Failed to load causes: $error');
      return []; // Return an empty list on error
    }
  }

// New method to get only cause names
  List<String> getCauseNamesList() {
    // Map _causesCache to extract names, and filter out any null names
    return _causesCache
        .where((cause) => cause.name != null)
        .map((cause) => cause.name!)
        .toList();
  }

  // Optional: A method to clear the cache if needed
  void clearCausesCache() {
    _causesCache = [];
  }
}
