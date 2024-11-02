import 'dart:async';

import 'package:dio/dio.dart';
import 'package:volufriend/crud_repository/models/voluevents.dart';
import 'volufriend_crud_repo.dart';

class VolufriendCrudService {
  Future<Map<String, String>> saveUserProfile(
      NewVolufrienduser profiledata) async {
    // Simulate an API call that returns user details
    return {
      'userId': '123',
      'username': 'JohnDoe',
      'orgId': '456',
      'orgName': 'OpenAI',
    };
  }

  Future<List<causes>> getcauses() async {
    try {
      print('Fetching causes list from URL: ${Paths.causesUrl}');

      final response = await VoluFriendDioClient.instance.get(Paths.causesUrl);

      //  print('Response: $response');
      //final Map<String, dynamic> data = response as Map<String, dynamic>;

      final List<causes> causelist = response.entries
          .map((entry) => causes.fromJson(entry.value, entry.key))
          .toList();

      return causelist;
    } on DioException catch (e) {
      print('DioException occurred in getcauseslist: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in getcauseslist: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<Map<String, String>> checkUserStatus() async {
    // Simulate an API call that returns user details
    return {
      'userId': '123',
      'username': 'JohnDoe',
      'orgId': '456',
      'orgName': 'OpenAI',
    };
  }

  Future<Map<String, String>> registerUser() async {
    // Simulate an API call that returns user details
    return {
      'userId': '123',
      'username': 'JohnDoe',
      'orgId': '456',
      'orgName': 'OpenAI',
    };
  }

  Future<UserHomeOrg> getloginUserHomeOrg(String userId) async {
    final response = await VoluFriendDioClient.instance
        .get('${Paths.userhomeorgUrl}/$userId');
    print(response);
    // Return the parsed UserHomeOrg object
    return UserHomeOrg.fromJson(response);
  }

  Future<Voluevents> getEventDetailsWithShifts(String eventId) async {
    try {
      print(
          'Now Fetching event details with shifts for event ID: $eventId from URL: ${Paths.eventswithshiftsurl}/$eventId');

      // Fetch the response
      final response = await VoluFriendDioClient.instance
          .get('${Paths.eventswithshiftsurl}/$eventId');

      // Check if the response data is not null
      if (response == null) {
        throw Exception('No data returned from the API.');
      }

      // Cast the response to a Map<String, dynamic>
      final Map<String, dynamic> data = response as Map<String, dynamic>;

      // Check if the event ID is present in the response
      if (!data.containsKey(eventId)) {
        throw Exception('Event ID not found in the response.');
      }

      // Access the event and shifts from the response
      final Map<String, dynamic>? eventData =
          data[eventId]?['event'] as Map<String, dynamic>?;
      final List<dynamic>? shiftsData =
          data[eventId]?['shifts'] as List<dynamic>?;

      if (eventData == null) {
        throw Exception('No event data found for event ID: $eventId');
      }

      // Parse the Voluevents object
      final Voluevents event = Voluevents.fromJson(data[eventId], eventId);

      // Parse the shifts and assign them to the event object
      if (shiftsData != null) {
        event.shifts = shiftsData.map((shift) {
          return Shift.fromJson(shift as Map<String, dynamic>);
        }).toList();
      } else {
        event.shifts = <Shift>[]; // Default to empty list if shiftsData is null
      }
      return event;
    } catch (e) {
      print('Error fetching event details: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<void> createEventDetailsWithShifts(
      Voluevents orgEvent, List<String>? imageUrls) async {
    try {
      // Convert the Voluevents object to a Map<String, dynamic>
      Map<String, dynamic> orgEventData = orgEvent.toJson(imageUrls: imageUrls);

      print('Save event details with shifts for event orgEvent: ');

      // Send the data to the API endpoint
      final response = await VoluFriendDioClient.instance.post(
        '${Paths.eventsurl}/',
        data: orgEventData,
      );

      // Check if the response data is not null
      if (response == null) {
        throw Exception('No data returned from the API.');
      }

      // Optional: Print or process the response if needed
    } catch (e) {
      print('Error saving event details with shifts: $e');
      throw Exception('An error occurred while saving event details: $e');
    }
  }

  Future<void> saveEventDetailsWithShifts(
      Voluevents orgEvent, List<String>? imageUrls) async {
    try {
      String eventId = orgEvent.eventId;
      print('Updating event with ID: $eventId');

      // Convert the Voluevents object to a Map<String, dynamic>
      final Map<String, dynamic> orgEventData =
          orgEvent.toJson(imageUrls: imageUrls);

      final updateResponse = await VoluFriendDioClient.instance.put(
        '${Paths.eventsurl}/$eventId',
        data: orgEventData,
      );
    } catch (e) {
      print('Error updating event details: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<Voluevents> cancelEvent({
    required String eventId,
    bool? notifyParticipants,
  }) async {
    try {
      print('Canceling event with ID: $eventId');

      // Send the PUT request to cancel the event
      final cancelResponse = await VoluFriendDioClient.instance.put(
        '${Paths.canceleventsurl}/$eventId',
      );
      // Assuming the response is a Map, cast it properly
      final Map<String, dynamic> data = cancelResponse as Map<String, dynamic>;

      // Check if the response contains at least one event (using keys)
      if (data.isEmpty) {
        throw Exception('No events found in the response.');
      }

      // Get the first key from the map
      final String firstKey = data.keys.first;

      // Check if the event key exists in the response using the first key
      final Map<String, dynamic> eventData = data[firstKey]['event'];

      // Verify if the event data exists
      if (eventData == null) {
        throw Exception('Event data not found in the response.');
      }

      // Access the shifts from the response
      final List<dynamic>? shiftsData =
          data[firstKey]['shifts'] as List<dynamic>?;

      // Parse the Voluevents object
      final Voluevents event = Voluevents.fromJson(data[eventId], eventId);

      // Parse the shifts and assign them to the event object
      if (shiftsData != null) {
        event.shifts = shiftsData.map((shift) {
          return Shift.fromJson(shift as Map<String, dynamic>);
        }).toList();
      } else {
        event.shifts =
            <Shift>[]; // Default to an empty list if shiftsData is null
      }

      return event;
    } catch (e) {
      print('Error canceling event: $e');
      throw Exception('An error occurred while canceling the event: $e');
    }
  }

  Future<List<Voluevents>> getEventsListWithShifts() async {
    final String url =
        Paths.eventswithshiftsurl; // Update this with your actual events URL
    print('Fetching events list from URL: $url');

    // Check if the URL starts with 'http://' or 'https://'
    if (!(url.startsWith('http://') || url.startsWith('https://'))) {
      throw Exception('Invalid URL format: $url');
    }

    try {
      // Make the HTTP request using Dio client
      final response = await VoluFriendDioClient.instance.get(url);

      final Map<String, dynamic> data = response as Map<String, dynamic>;

      // Use the parseVolueventsResponse method to convert the map into a list of Voluevents objects
      // final List<Voluevents> events = parseVolueventsResponse(data);
      print('Response: $data');
      final List<Voluevents> events = data.entries.map((entry) {
        return Voluevents.fromJson(
            entry.value as Map<String, dynamic>, entry.key);
      }).toList();

/*
      final List<Voluevents> events = response.entries
          .map((entry) => Voluevents.fromJson(entry.value, entry.key))
          .toList(); */

      return events;
    } on DioException catch (e) {
      print('DioException occurred in getUserList: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in getUserList: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Voluevents>> getUpcomingEventsforOrgUser(String orgUserId,
      {DateTime? filterStartDate, DateTime? filterEndDate}) async {
    String apiUrl =
        Paths.orgupcomingeventsUrl; // Update this with your actual events URL

    // Start building query parameters
    List<String> queryParams = ['org_user_id=$orgUserId'];

    // Append start_date if filterStartDate is provided
    if (filterStartDate != null) {
      String filterStartDateStr = filterStartDate.toIso8601String();
      queryParams.add('start_date=$filterStartDateStr');
    }

    // Append end_date if filterEndDate is provided
    if (filterEndDate != null) {
      String filterEndDateStr = filterEndDate.toIso8601String();
      queryParams.add('end_date=$filterEndDateStr');
    }

    // Construct the full API URL with query parameters
    apiUrl = '$apiUrl?${queryParams.join('&')}';

    print('Fetching events list from URL: $apiUrl');

    // Check if the URL starts with 'http://' or 'https://'
    if (!(apiUrl.startsWith('http://') || apiUrl.startsWith('https://'))) {
      throw Exception('Invalid URL format: $apiUrl');
    }

    try {
      // Make the HTTP request using Dio client
      final response = await VoluFriendDioClient.instance.get(apiUrl);
      final Map<String, dynamic> data = response as Map<String, dynamic>;

      // Use the parseVolueventsResponse method to convert the map into a list of Voluevents objects
      final List<Voluevents> events = data.entries.map((entry) {
        return Voluevents.fromJson(
            entry.value as Map<String, dynamic>, entry.key);
      }).toList();

      return events;
    } on DioException catch (e) {
      print(
          'DioException occurred in getUpcomingEventsforOrgUser: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in getUpcomingEventsforOrgUser: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Voluevents>> getUpcomingEventsforOrgUserPageWise(
    String orgUserId, {
    DateTime? filterStartDate,
    DateTime? filterEndDate,
    int page = 1,
    int pageSize = 10,
  }) async {
    String apiUrl = Paths.orgupcomingeventsUrlPageWise;

    // Start building query parameters
    List<String> queryParams = [
      'org_user_id=$orgUserId',
      'page=$page',
      'pageSize=$pageSize',
    ];

    // Append start_date if filterStartDate is provided
    if (filterStartDate != null) {
      String filterStartDateStr = filterStartDate.toIso8601String();
      queryParams.add('start_date=$filterStartDateStr');
    }

    // Append end_date if filterEndDate is provided
    if (filterEndDate != null) {
      String filterEndDateStr = filterEndDate.toIso8601String();
      queryParams.add('end_date=$filterEndDateStr');
    }

    // Construct the full API URL with query parameters
    apiUrl = '$apiUrl?${queryParams.join('&')}';

    print('Fetching paginated events list from URL: $apiUrl');

    // Check if the URL starts with 'http://' or 'https://'
    if (!(apiUrl.startsWith('http://') || apiUrl.startsWith('https://'))) {
      throw Exception('Invalid URL format: $apiUrl');
    }

    try {
      // Make the HTTP request using Dio client
      final response = await VoluFriendDioClient.instance.get(apiUrl);
      final Map<String, dynamic> data = response as Map<String, dynamic>;

      // Extract events and pagination info from response data
      final List<Voluevents> events = (data['events'] as Map<String, dynamic>)
          .entries
          .map((entry) => Voluevents.fromJson(entry.value, entry.key))
          .toList();

      // Optional: Parse pagination metadata if needed
      final pagination = data['pagination'] ?? {};
      final int totalPages = pagination['totalPages'] ?? 1;
      final int totalEvents = pagination['totalEvents'] ?? 0;

      print(
          "Fetched ${events.length} events. Total pages: $totalPages, Total events: $totalEvents");

      return events;
    } on DioException catch (e) {
      print(
          'DioException in getUpcomingEventsforOrgUserPageWise: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('Exception in getUpcomingEventsforOrgUserPageWise: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Voluevents>> getPastEventsForUser(String orgUserId,
      DateTime? filterStartDate, DateTime? filterEndDate) async {
    final String url =
        Paths.orgupcomingeventsUrl; // Update this with your actual events URL

    // Append filterDate to the URL if it is provided
    final String filterStartDateStr = filterStartDate?.toIso8601String() ?? '';
    final String filterEndDateStr = filterEndDate?.toIso8601String() ?? '';

    // Construct the base API URL
    String apiUrl = '$url?org_user_id=$orgUserId';

    // Append the start_date and end_date if they are provided
    if (filterStartDateStr.isNotEmpty) {
      apiUrl += '&start_date=$filterStartDateStr';
    } else {
      // Fallback to current date if no start date is provided
      apiUrl += '&start_date=${DateTime.now().toIso8601String()}';
    }

    if (filterEndDateStr.isNotEmpty) {
      apiUrl += '&end_date=$filterEndDateStr'; // Append end_date if provided
    }

    print('Fetching events list from URL: $apiUrl');

    // Check if the URL starts with 'http://' or 'https://'
    if (!(apiUrl.startsWith('http://') || apiUrl.startsWith('https://'))) {
      throw Exception('Invalid URL format: $apiUrl');
    }

    try {
      // Make the HTTP request using Dio client
      final response = await VoluFriendDioClient.instance.get(apiUrl);

      final Map<String, dynamic> data = response as Map<String, dynamic>;

      // Use the parseVolueventsResponse method to convert the map into a list of Voluevents objects
      final List<Voluevents> events = data.entries.map((entry) {
        return Voluevents.fromJson(
            entry.value as Map<String, dynamic>, entry.key);
      }).toList();

      return events;
    } on DioException catch (e) {
      print(
          'DioException occurred in getUpcomingEventsforOrgUser: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in getUpcomingEventsforOrgUser: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Voluevents>> geteventandshiftforapproval(String orgUserId,
      {DateTime? filterDate}) async {
    final String url = Paths
        .geteventandshiftforapprovalUrl; // Update this with your actual events URL

    // Append filterDate to the URL if it is provided
    final String filterDateStr = filterDate?.toIso8601String() ?? '';
    final String apiUrl = filterDateStr.isNotEmpty
        ? '$url?org_user_id=$orgUserId&filterDate=$filterDateStr'
        : '$url?org_user_id=$orgUserId';

    print('Fetching events list from URL: $apiUrl');

    // Check if the URL starts with 'http://' or 'https://'
    if (!(apiUrl.startsWith('http://') || apiUrl.startsWith('https://'))) {
      throw Exception('Invalid URL format: $apiUrl');
    }

    try {
      // Make the HTTP request using Dio client
      final response = await VoluFriendDioClient.instance.get(apiUrl);

      final Map<String, dynamic> data = response as Map<String, dynamic>;

      // Use the parseVolueventsResponse method to convert the map into a list of Voluevents objects
      final List<Voluevents> events = data.entries.map((entry) {
        return Voluevents.fromJson(
            entry.value as Map<String, dynamic>, entry.key);
      }).toList();

/*
      final List<Voluevents> events = response.entries
          .map((entry) => Voluevents.fromJson(entry.value, entry.key))
          .toList(); */
      return events;
    } on DioException catch (e) {
      print(
          'DioException occurred in geteventandshiftforapproval: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in geteventandshiftforapproval: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Attendance>> getAttendancesForApproval(
      {required String eventId}) async {
    final String url = Paths
        .geteventattendanceUrl; // Update this with your actual attendance URL

    print('Fetching Attendance list from URL: $url for shiftid: $eventId');

    // Check if the URL starts with 'http://' or 'https://'
    if (!(url.startsWith('http://') || url.startsWith('https://'))) {
      throw Exception('Invalid URL format: $url');
    }

    try {
      // Prepare query parameters including userId and optional volunteerId
      final Map<String, dynamic> queryParams = {'event_id': eventId};

      queryParams['event_id'] = eventId;
      queryParams['shift_id'] = '';

      print('querparams: $queryParams');
      // Make the HTTP request using Dio client
      final response = await VoluFriendDioClient.instance
          .get(url, queryParameters: queryParams);
      final Map<String, dynamic>? data = response; // Access the response data

      // Check if data is not null and not empty
      if (data == null || data.isEmpty) {
        print('No data found in response');
        return []; // Return empty list
      }

      // Utilize the fromJsonList method to extract attendance records
      List<Attendance> allAttendances =
          Attendance.convertJsonReponseToList(response);

      return allAttendances; // Return the list of all attendances
    } on DioException catch (e) {
      print(
          'DioException occurred in getAttendancesForUserOrVolunteer: ${e.message}');
      var error = DioErrors(e);
      throw Exception(error
          .errorMessage); // Throwing a generic Exception with the error message
    } catch (e) {
      print(
          'General exception occurred in getAttendancesForUserOrVolunteer: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<int> saveAttendanceApproval(
      List<Attendance> attendanceListToApprove) async {
    try {
      print(
          'Saving attendance approval data: $attendanceListToApprove at URL: ${Paths.approveattendanceUrl}');

      // Convert the list of Attendance objects to a Map with attendanceId as the key
      final Map<String, dynamic> attendanceJsonToApprove =
          Attendance.listToJson(attendanceListToApprove);
      print('attendanceJsonToApprove' + attendanceJsonToApprove.toString());
      // Make the PUT request and pass the JSON map as the data
      final response = await VoluFriendDioClient.instance.put(
        Paths.approveattendanceUrl,
        data: attendanceJsonToApprove,
      );

      // Log the response for debugging
      print('Response: ${response}'); // Assuming response has a `data` field
      return 200;
    } on DioException catch (e) {
      print('DioException occurred in saveAttendanceApproval: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in saveAttendanceApproval: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Voluevents>> getUpcomingEventsforVolunteer(String volunteerId,
      {DateTime? filterDate}) async {
    final String url =
        Paths.eventswithshiftsurl; // Update this with your actual events URL

    // Append filterDate to the URL if it is provided
    final String filterDateStr = filterDate?.toIso8601String() ?? '';
    final String apiUrl = filterDateStr.isNotEmpty
        ? '$url?volunteerId=$volunteerId&filterDate=$filterDateStr'
        : '$url?volunteerId=$volunteerId&filterDate=${DateTime.now().toIso8601String()}';

    print('Fetching events list from URL: $apiUrl');

    // Check if the URL starts with 'http://' or 'https://'
    if (!(apiUrl.startsWith('http://') || apiUrl.startsWith('https://'))) {
      throw Exception('Invalid URL format: $apiUrl');
    }

    try {
      // Make the HTTP request using Dio client
      final response = await VoluFriendDioClient.instance.get(apiUrl);

      final Map<String, dynamic> data = response as Map<String, dynamic>;

      // Use the parseVolueventsResponse method to convert the map into a list of Voluevents objects
      // final List<Voluevents> events = parseVolueventsResponse(data);
      print('Response: $data');
      final List<Voluevents> events = data.entries.map((entry) {
        return Voluevents.fromJson(
            entry.value as Map<String, dynamic>, entry.key);
      }).toList();

/*
      final List<Voluevents> events = response.entries
          .map((entry) => Voluevents.fromJson(entry.value, entry.key))
          .toList(); */

      return events;
    } on DioException catch (e) {
      print('DioException occurred in getUserList: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in getUserList: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Attendance>> getAttendancesForUserOrVolunteer({
    required String userId,
    String? volunteerId,
    DateTime? filterDate,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final String url =
        Paths.eventattendanceUrl; // Update this with your actual attendance URL

    print('Fetching Attendance list from URL: $url for user: $userId');

    // Check if the URL starts with 'http://' or 'https://'
    if (!(url.startsWith('http://') || url.startsWith('https://'))) {
      throw Exception('Invalid URL format: $url');
    }

    try {
      // Prepare query parameters including userId and optional volunteerId
      final Map<String, dynamic> queryParams = {'user_id': userId};
      if (volunteerId != null) {
        queryParams['volunteer_id'] = volunteerId;
      }
      if (startDate != null) {
        queryParams['start_date'] = startDate.toIso8601String();
      }
      if (endDate != null) {
        queryParams['end_date'] = endDate.toIso8601String();
      }
      print('querparams: $queryParams');
      // Make the HTTP request using Dio client
      final response = await VoluFriendDioClient.instance
          .get(url, queryParameters: queryParams);
      final Map<String, dynamic>? data = response; // Access the response data

      // Check if data is not null and not empty
      if (data == null || data.isEmpty) {
        print('No data found in response');
        return []; // Return empty list
      }

      // Utilize the fromJsonList method to extract attendance records
      List<Attendance> allAttendances = Attendance.fromJsonList(data, userId);

      return allAttendances; // Return the list of all attendances
    } on DioException catch (e) {
      print(
          'DioException occurred in getAttendancesForUserOrVolunteer: ${e.message}');
      var error = DioErrors(e);
      throw Exception(error
          .errorMessage); // Throwing a generic Exception with the error message
    } catch (e) {
      print(
          'General exception occurred in getAttendancesForUserOrVolunteer: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Voluevents>> getUserInterestedEvents(
    String userId, {
    List<String>? causesIdList,
    List<String>? orgIdsList,
  }) async {
    final String url =
        Paths.userinterestevents; // Update this with your actual events URL
    print('Fetching events list from URL: $url for user: $userId');

    // Check if the URL starts with 'http://' or 'https://'
    if (!(url.startsWith('http://') || url.startsWith('https://'))) {
      throw Exception('Invalid URL format: $url');
    }

    try {
      // Prepare query parameters including userId
      final Map<String, dynamic> queryParams = {
        'userId': userId,
        'currentDate': DateTime.now().toIso8601String(),
        if (causesIdList != null && causesIdList.isNotEmpty)
          'causesIdList': causesIdList,
        if (orgIdsList != null && orgIdsList.isNotEmpty)
          'orgIdsList': orgIdsList,
      };

      // Make the HTTP request using Dio client
      final response = await VoluFriendDioClient.instance
          .get(url, queryParameters: queryParams);

      final Map<String, dynamic> data = response as Map<String, dynamic>;

      print('Response: $data');
      final List<Voluevents> events = data.entries.map((entry) {
        return Voluevents.fromJson(
            entry.value as Map<String, dynamic>, entry.key);
      }).toList();

      return events;
    } on DioException catch (e) {
      print('DioException occurred in getUserInterestedEvents: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in getUserInterestedEvents: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Voluevents>> getmyupcomingevents(String userId) async {
    final String url =
        Paths.myupcomingevents; // Update this with your actual events URL
    print('Fetching events list from URL: $url for user: $userId');

    // Check if the URL starts with 'http://' or 'https://'
    if (!(url.startsWith('http://') || url.startsWith('https://'))) {
      throw Exception('Invalid URL format: $url');
    }

    try {
      // Prepare query parameters including userId
      final Map<String, dynamic> queryParams = {'user_id': userId};
      print(queryParams);
      // Make the HTTP request using Dio client
      final response = await VoluFriendDioClient.instance
          .get(url, queryParameters: queryParams);

      final Map<String, dynamic> data = response as Map<String, dynamic>;

      //  print('Response: $data');
      final List<Voluevents> events = data.entries.map((entry) {
        return Voluevents.fromJson(
            entry.value as Map<String, dynamic>, entry.key);
      }).toList();

      return events;
    } on DioException catch (e) {
      print('DioException occurred in getUserInterestedEvents: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in getUserInterestedEvents: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Voluevents>> getEventsForDay({
    required String userId,
    required DateTime eventDate,
    required String role,
  }) async {
    String url = '';
    if (role == 'Volunteer') {
      url = Paths.myupcomingevents; // Update this with your actual events URL
      print(
          'Fetching events list from URL: $url for user: $userId for date: $eventDate');
    } else if (role == 'Organization') {
      return getUpcomingEventsforOrgUser(userId, filterStartDate: eventDate);
    }

    // Check if the URL starts with 'http://' or 'https://'
    if (!(url.startsWith('http://') || url.startsWith('https://'))) {
      throw Exception('Invalid URL format: $url');
    }

    try {
      // Prepare query parameters including userId
      final Map<String, dynamic> queryParams = {
        'user_id': userId,
        'start_date': eventDate.toIso8601String()
      };
      print(queryParams);
      // Make the HTTP request using Dio client
      final response = await VoluFriendDioClient.instance
          .get(url, queryParameters: queryParams);

      final Map<String, dynamic> data = response as Map<String, dynamic>;

      // print('Response: $data');
      final List<Voluevents> events = data.entries.map((entry) {
        return Voluevents.fromJson(
            entry.value as Map<String, dynamic>, entry.key);
      }).toList();

      return events;
    } on DioException catch (e) {
      print('DioException occurred in getEventsForDay: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in getEventsForDay: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Voluevents>> getEventsForRange({
    required String userId,
    required DateTime eventRangeStartDate,
    required DateTime eventRangeEndtDate,
    required String role,
  }) async {
    String url = '';
    if (role == 'Volunteer') {
      url = Paths.myupcomingevents; // Update this with your actual events URL
      print(
          'Fetching events list from URL: $url for user: $userId during range: $eventRangeStartDate to $eventRangeEndtDate');
    } else if (role == 'Organization') {
      return getUpcomingEventsforOrgUser(userId,
          filterStartDate: eventRangeStartDate,
          filterEndDate: eventRangeEndtDate);
    }

    print(
        'Fetching events list from URL: $url for user: $userId during range: $eventRangeStartDate to $eventRangeEndtDate');

    // Check if the URL starts with 'http://' or 'https://'
    if (!(url.startsWith('http://') || url.startsWith('https://'))) {
      throw Exception('Invalid URL format: $url');
    }

    try {
      // Prepare query parameters including userId
      final Map<String, dynamic> queryParams = {
        'user_id': userId,
        'start_date': eventRangeStartDate.toIso8601String(),
        'end_date': eventRangeEndtDate.toIso8601String()
      };
      print(queryParams);
      // Make the HTTP request using Dio client
      final response = await VoluFriendDioClient.instance
          .get(url, queryParameters: queryParams);

      final Map<String, dynamic> data = response as Map<String, dynamic>;

      print('Response: $data');
      final List<Voluevents> events = data.entries.map((entry) {
        return Voluevents.fromJson(
            entry.value as Map<String, dynamic>, entry.key);
      }).toList();

      return events;
    } on DioException catch (e) {
      print('DioException occurred in getEventsForRange: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in getEventsForRange: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<int> sendFcmToken(
      {required String userId, required String? token}) async {
    if (token == null) {
      print('Token is null, not sending to server.');
      return 400; // Return an error code or handle it as needed
    }

    final Map<String, dynamic> tokenData = {
      'token': token,
    };

    try {
      print(
          'Sending FCM token: $tokenData to URL: ${Paths.usersUrl}'); // Make sure to define Paths.storeTokenUrl

      final response = await VoluFriendDioClient.instance.put(
        '${Paths.usersUrl}/$userId', // Append the userId to the URL
        data: tokenData,
      );

      // Log the response for debugging
      print('Response: $response');
      return 200; // Return success code
    } on DioException catch (e) {
      print('DioException occurred in sendFcmToken: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage; // Throw a custom error message
    } catch (e) {
      print('General exception occurred in sendFcmToken: $e');
      throw Exception('An error occurred: $e'); // Handle other exceptions
    }
  }

  Future<int> saveEventSignUp(
      String userId, Map<String, dynamic> signUpData) async {
    try {
      print(
          'Saving event sign-up data: $signUpData at URL: ${Paths.eventsignupUrl}');

      // Make the POST request and get the response
      final response = await VoluFriendDioClient.instance.post(
        Paths.eventsignupUrl,
        data: signUpData,
      );

      // Log the response for debugging
      print('Response: $response');
      return 200;
    } on DioException catch (e) {
      print('DioException occurred in saveEventSignUp: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in saveEventSignUp: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<UserHomeOrg> joinHomeOrg(
      String userId, Map<String, dynamic> userData) async {
    final updateResponse = await VoluFriendDioClient.instance.put(
      '${Paths.setuserhomeorgUrl}/$userId',
      data: userData,
    );
    print('Response: $updateResponse');
    // Return the parsed UserHomeOrg object
    return UserHomeOrg.fromJson(updateResponse);
  }

  Future<NewVolufrienduser> addNewUser(
      String id, Map<String, dynamic> userData) async {
    try {
      print('Adding new user with ID: $id');
      print('User data: $userData');

      final String userId = id;
      final response = await VoluFriendDioClient.instance.post(
        '${Paths.usersUrl}/$userId', // Append the userId to the URL
        data: userData,
/* 
      final response = await VoluFriendDioClient.instance.post(
        Paths.usersUrl,
        data: userData, */
      );

      // Assuming that Firebase returns the new ID in the response under the 'id' key
      final newId = response['id'] as String?;
      if (newId == null) {
        throw Exception('Failed to retrieve the new user ID from the response');
      }

      print('Response: $response');

      // Create and return the NewVolufrienduser object
      return NewVolufrienduser.fromJson(userData, newId);
    } on DioException catch (e) {
      print('DioException occurred in addNewUser: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in addNewUser: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<NewVolufrienduser> getUser(String id) async {
    try {
      print('Fetching user with ID: $id');

      final response =
          await VoluFriendDioClient.instance.get('${Paths.usersUrl}/$id');

      print('Response: $response');
      //if (response.containsKey(id)) {
      //return NewVolufrienduser.fromJson(response[id], id);
      return NewVolufrienduser.fromJson(response, id);
      //} else {
      //  throw Exception('User data not found in response');
      // }
    } on DioException catch (e) {
      print('DioException occurred in getUser: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in getUser: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<NewVolufrienduser>> getUserList() async {
    try {
      print('Fetching users list from URL: ${Paths.usersUrl}');

      // Check if the URL starts with 'http://' or 'https://'
      if (!(Paths.usersUrl.startsWith('http://') ||
          Paths.usersUrl.startsWith('https://'))) {
        throw Exception('Invalid URL format: ${Paths.usersUrl}');
      }

      final response = await VoluFriendDioClient.instance.get(Paths.usersUrl);

      print('Response: $response');
      final Map<String, dynamic> data = response as Map<String, dynamic>;

      final List<NewVolufrienduser> users = data.entries
          .map((entry) => NewVolufrienduser.fromJson(entry.value, entry.key))
          .toList();

      return users;
    } on DioException catch (e) {
      print('DioException occurred in getUserList: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in getUserList: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<NewVolufrienduser> updateUser(
      String id, Map<String, dynamic> userData) async {
    try {
      print('Updating user with ID: $id');
      print('User data: $userData');

      final updateResponse = await VoluFriendDioClient.instance.put(
        '${Paths.usersUrl}/$id',
        data: userData,
      );
      print('Response: $updateResponse');

      if (updateResponse is Map<String, dynamic> && updateResponse.isNotEmpty) {
        // Fetch the updated user details
        final getResponse =
            await VoluFriendDioClient.instance.get('${Paths.usersUrl}/$id');
        print('Updated user response: $getResponse');

        // Return the updated user
        return NewVolufrienduser.fromJson(getResponse, id);
      } else {
        throw Exception('Update request failed or returned an empty response');
      }
    } on DioException catch (e) {
      print('DioException occurred in updateUser: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in updateUser: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      print('Deleting user with ID: $id');

      await VoluFriendDioClient.instance.delete('${Paths.usersUrl}/$id');

      print('User deleted successfully');
    } on DioException catch (e) {
      print('DioException occurred in deleteUser: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in deleteUser: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<NotificationModel> saveNotification(
      Map<String, dynamic> notification) async {
    try {
      print('Adding new notification with');
      print('Org data: $notification');

      final response = await VoluFriendDioClient.instance.post(
        '${Paths.messageUrl}/', // Append the userId to the URL
        data: notification,
      );

      // Assuming that Firebase returns the new ID in the response under the 'id' key
      final newId = response['id'] as String?;
      if (newId == null) {
        throw Exception('Failed to retrieve the new user ID from the response');
      }

      print('Response: $response');

      // Create and return the Organization object
      return NotificationModel.fromJson(notification, dbid: newId);
    } on DioException catch (e) {
      print('DioException occurred in addNewOrg: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in addNewOrg: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<NotificationModel>> getNotificationsList(String userId) async {
    try {
      if (userId.isEmpty) {
        return [];
      }
      print(
          'Fetching getNotificationsList list from URL: ${Paths.messageUrl} for user: $userId');

      // Check if the URL starts with 'http://' or 'https://'
      if (!(Paths.messageUrl.startsWith('http://') ||
          Paths.messageUrl.startsWith('https://'))) {
        throw Exception('Invalid URL format: ${Paths.messageUrl}');
      }

      final Map<String, dynamic> queryParams = {'user_id': userId};
      print(queryParams);
      // Make the HTTP request using Dio client
      final response = await VoluFriendDioClient.instance
          .get(Paths.messageUrl, queryParameters: queryParams);

      // final response = await VoluFriendDioClient.instance.get(Paths.messageUrl);

      // print('Response: $response');
      final Map<String, dynamic> data = response as Map<String, dynamic>;

      final List<NotificationModel> notificationList = data.entries
          .map((entry) =>
              NotificationModel.fromJson(entry.value, dbid: entry.key))
          .toList();

      return notificationList;
    } on DioException catch (e) {
      print('DioException occurred in notificationList: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in notificationList: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<void> deleteNotificationsList(
      Map<String, dynamic> notificationsList) async {
    try {
      print(
          'deleteAllNotifications at URL: ${Paths.messagedeleteUrl} of list $notificationsList');

      return await VoluFriendDioClient.instance
          .delete('${Paths.messagedeleteUrl}', data: notificationsList);
    } on DioException catch (e) {
      print('DioException occurred in deleteNotificationsList: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in deleteNotificationsList: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<Organization> addNewOrg(Map<String, dynamic> OrgData) async {
    try {
      print('Adding new Org with');
      print('Org data: $OrgData');

      final response = await VoluFriendDioClient.instance.post(
        '${Paths.orgUrl}/', // Append the userId to the URL
        data: OrgData,
      );

      // Assuming that Firebase returns the new ID in the response under the 'id' key
      final newId = response['id'] as String?;
      if (newId == null) {
        throw Exception('Failed to retrieve the new user ID from the response');
      }

      print('Response: $response');

      // Create and return the Organization object
      return Organization.fromJson(OrgData, newId);
    } on DioException catch (e) {
      print('DioException occurred in addNewOrg: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in addNewOrg: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<Organization> getOrganization(String OrgId) async {
    try {
      print('Fetching user with ID: $OrgId');

      final response =
          await VoluFriendDioClient.instance.get('${Paths.orgUrl}/$OrgId');

      print('Response: $response');
      //if (response.containsKey(id)) {
      //return Organization.fromJson(response[id], id);
      return Organization.fromJson(response, OrgId);
      //} else {
      //  throw Exception('Organization data not found in response');
      // }
    } on DioException catch (e) {
      print('DioException occurred in getOrganization: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in getOrganization: $e');
      throw Exception('An error occurred: $e');
    }
  }

  Future<List<Organization>> getOrgList() async {
    try {
      print('Fetching Org list from URL: ${Paths.orgUrl}');

      // Check if the URL starts with 'http://' or 'https://'
      if (!(Paths.orgUrl.startsWith('http://') ||
          Paths.orgUrl.startsWith('https://'))) {
        throw Exception('Invalid URL format: ${Paths.orgUrl}');
      }

      final response = await VoluFriendDioClient.instance.get(Paths.orgUrl);

      // print('Response: $response');
      final Map<String, dynamic> data = response as Map<String, dynamic>;

      final List<Organization> users = data.entries
          .map((entry) => Organization.fromJson(entry.value, entry.key))
          .toList();

      return users;
    } on DioException catch (e) {
      print('DioException occurred in getUserList: ${e.message}');
      var error = DioErrors(e);
      throw error.errorMessage;
    } catch (e) {
      print('General exception occurred in getUserList: $e');
      throw Exception('An error occurred: $e');
    }
  }
}
