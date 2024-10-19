import 'package:dio/dio.dart';
import 'dart:convert'; // Import the dart:convert package for json.decode

class Paths {
  static const String baseUrl = 'http://10.0.2.2:3000';
  // 'https://us-central1-volufriend.cloudfunctions.net/api';
  static const String usersUrl = '$baseUrl/users';
  static const String orgUrl = '$baseUrl/organizations';
  static const String userhomeorgUrl = '$baseUrl/userhomeorg';
  static const String setuserhomeorgUrl = '$baseUrl/setuserhomeorg';
  static const String causesUrl = '$baseUrl/causes';
  static const String eventsurl = '$baseUrl/events';
  static const String canceleventsurl = '$baseUrl/events/cancel';
  static const String eventswithshiftsurl =
      '$baseUrl/events/events-with-shifts';
  static const String userinterestevents = '$baseUrl/userinterestevents';
  static const String myupcomingevents = '$baseUrl/myupcomingevents';
  static const String eventsignupUrl = '$baseUrl/eventsignup';
  static const String eventattendanceUrl = '$baseUrl/uservolunteeringreport';
  static const String storeTokenUrl = '$baseUrl/storeToken';
  static const String messageUrl = '$baseUrl/eventmessages';
  static const String messagedeleteUrl = '$baseUrl/eventmessages/deleteall';
  static const String orgupcomingeventsUrl = '$baseUrl/orgupcomingevents';
  static const String geteventandshiftforapprovalUrl =
      '$baseUrl/geteventandshiftforapproval';
  static const String approveattendanceUrl = '$baseUrl/attendance/approve';
  static const String geteventattendanceUrl = '$baseUrl/attendance/';
  static const String eventshiftcheckin = '$baseUrl/attendance/checkin';
}

/// Create a singleton class to contain all Dio methods and helper functions
class VoluFriendDioClient {
  VoluFriendDioClient._();

  static final instance = VoluFriendDioClient._();

  factory VoluFriendDioClient() {
    return instance;
  }

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Paths.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.json,
    ),
  );

  Future<Map<String, dynamic>> get(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        // print('Response Type: ${response.runtimeType.toString()}');
        //print(response.data);
        return response.data;
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  /// Post Method
  Future<Map<String, dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map<String, dynamic>) {
          return response.data as Map<String, dynamic>;
        } else {
          throw Exception("Unexpected response format");
        }
      } else {
        throw Exception("Failed with status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      // Handle specific Dio errors
      print('DioException occurred: ${e.message}');
      print('Response status: ${e.response?.statusCode}');
      print('Response data: ${e.response?.data}');
      rethrow;
    } catch (e) {
      // Handle general errors
      print('Error occurred in DioClientPost: $e');
      rethrow;
    }
  }

  /// Put Method
  Future<Map<String, dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      }
      throw Exception("Something went wrong");
    } catch (e) {
      rethrow;
    }
  }

  /// Delete Method
  Future<void> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      print('Response status code: ${response.statusCode}');
      if (response.statusCode != 204) {
        throw Exception("Something went wrong");
      }
    } catch (e) {
      rethrow;
    }
  }
}
