// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pert6/model/user_model.dart';
import 'package:pert6/repository/auth_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();

  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  UserModel? _loggedInUser;
  UserModel? get loggedInUser => _loggedInUser;

  Future<void> login(String username, String password) async {
    try {
      final user = await _authRepository.login(
        username: username,
        password: password,
      );

      _loggedInUser = user;
      print(_loggedInUser);
    } catch (error) {
       if (error is UnauthenticatedExeption){
        Fluttertoast.showToast(msg: "Unauthorized access");
       } else {
        Fluttertoast.showToast(msg: "An error occurred");
       }
    } finally {
      notifyListeners();
    }
  }

  Future<void> register(String name, String username, String password) async {
    try {
      final user = await _authRepository.register(
        name: name,
        username: username,
        password: password,
      );
      _loggedInUser = user;
      print(_loggedInUser);
    } catch (error) {
      print('Error: $error');
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _authRepository.logout();
      _loggedInUser = null;
    } catch (error) {
      print('Error: $error');
    } finally {
      notifyListeners();
    }
  }

  Future<void> checkAccessToken() async {
    try {
      String? accessToken = await _secureStorage.read(key: 'access_token');

      if (accessToken != null) {
        final user = await _authRepository.reAuth();
        _loggedInUser = user;
      } else {
        _loggedInUser = null;
      }
    } catch (error) {
      print('Error :$error');
    }
  }
}
