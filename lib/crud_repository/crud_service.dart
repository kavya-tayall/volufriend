import 'package:dio/dio.dart';

import 'crud_repository.dart';

class CrudService {
  Future<NewUser> addNewUser(String name, String job) async {
    try {
      final response = await DioClient.instance.post(
        Paths.usersUrl,
        data: {
          'name': name,
          'job': job,
        },
      );
      return NewUser.fromJson(response);
    } on DioException catch (e) {
      var error = DioErrors(e);
      throw error.errorMessage;
    }
  }

  Future<User> getUser() async {
    try {
      final response = await DioClient.instance.get(Paths.users);
      final user = User.fromJson(response["data"]);
      return user;
    } on DioException catch (e) {
      var error = DioErrors(e);
      throw error.errorMessage;
    }
  }

  Future<List<User>> getUserList() async {
    try {
      print('Attempting to fetch users from API...'); // Debug print

      final response = await DioClient.instance.get(Paths.usersUrl);
      print('API response received: $response'); // Debug print

      final List<dynamic> data = response["data"];
      print('Data extracted from response: $data'); // Debug print

      final List<User> users = data.map((json) => User.fromJson(json)).toList();
      print('Users list created: $users'); // Debug print

      return users;
    } on DioException catch (e) {
      var error = DioErrors(e);
      print('Error occurred: ${error.errorMessage}'); // Debug print

      throw error.errorMessage;
    }
  }

  Future<NewUser> updateUser(String id, String name, String job) async {
    try {
      final response = await DioClient.instance.put(
        '${Paths.users}/$id',
        data: {
          'id': id,
          'name': name,
          'job': job,
        },
      );
      return NewUser.fromJson(response);
    } on DioException catch (e) {
      var error = DioErrors(e);
      throw error.errorMessage;
    }
  }

  Future<void> deleteUser(String id) async {
    try {
      await DioClient.instance.delete('${Paths.users}/$id');
    } on DioException catch (e) {
      var error = DioErrors(e);
      throw error.errorMessage;
    }
  }
}
