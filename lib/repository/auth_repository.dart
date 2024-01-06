import 'package:dio/dio.dart';
// import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:pert6/model/user_model.dart';
import 'package:pert6/utils/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UnauthenticatedExeption{
  final String message;

  UnauthenticatedExeption(this.message);

  @override
  String toString(){
    return 'UnauthenticatedExeption:$message';
  }
}


class AuthRepository {
  final Dio _dio = DioUtils.dio;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  

  Future<UserModel> register({
    required String username,
    required String password,
    required String name,
  }) async {
    try {
      final response = await _dio.post(
          'https://auth-exercise-api.wilyanto.com/api/auth/register',
          data: {
            'username': username,
            'password': password,
            'name': name,
          });
      if (response.statusCode == 200) {
        String token = response.data['token'];

        await _secureStorage.write(key: 'access_token', value: token);
        final user = UserModel.fromJson(response.data['user']);
        return user;
      } else {
        throw Exception(('Failed to register'));
      }
    } catch (e) {
      throw Exception('Failed to load comments: $e');
    }
  }

  // Future<String> login({
  //   required String username,
  //   required String password,
  // }) async {
  //   try {
  //     final response = await _dio.post(
  //       'https://auth-exercise-api.wilyanto.com/api/auth/login',
  //       data: {
  //         'username': username,
  //         'password': password,
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       String token = response.data['token'];
  //       await _secureStorage.write(key: 'access_token', value: token);
  //       print(token);

  //       return token;
  //     } else {
  //       throw Exception('Failed to register');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load comments $e');
  //   }
  // }

  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'https://auth-exercise-api.wilyanto.com/api/auth/login',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        String token = response.data['token'];
        await _secureStorage.write(key: 'access_token', value: token);

        final user = UserModel.fromJson(response.data['user']);

        return user;
      } else if (response.statusCode == 401) {
        throw UnauthenticatedExeption("Unauthorized access");
      } else {
        throw Exception("Filed to login");
      }
        
      
    } catch (error) {
      if (error is DioError && error.response?.statusCode == 401){
        throw UnauthenticatedExeption("");
      } else {
        throw Exception('Filed to load comments: $error');
      }
    }
  }

  Future<void> logout() async {
    try {
      final response = await _dio
          .post('https://auth-exercise-api.wilyanto.com/api/auth/logout');

      if (response.statusCode == 204) {
        await _secureStorage.delete(key: 'access_token');
      } else {
        throw Exception('Failed to Logout');
      }
    } catch (e) {
      throw Exception('Filed to logout:$e');
    }
  }

  Future<UserModel> reAuth() async {
    try {
      final response= await _dio.get(
        'https://auth-exercise-api.wilyanto.com/api/auth'
      );

      if (response.statusCode == 200) {
        final user = UserModel.fromJson(response.data);
        return user;
      } else {
        await _secureStorage.delete(key: 'access_token');
        throw Exception('Filed to reAuth');
      }
    } catch (e) {
      await _secureStorage.delete(key: 'access_token');
      throw Exception('Filed to reAuth');
      
    }
  }
}
