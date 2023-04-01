// ignore_for_file: file_names

import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';

class AuthService {
  final SharedPreferences prefs;

  String _token = '';

  get token => _token;

  AuthService({
    required this.prefs,
  }) {
    _token = prefs.getString('token') ?? '';
  }

  Future<String> loginUser({
    required String login,
    required String password,
  }) async {
    dynamic token = await APIService.postRequest(
      request: 'api/auth/login',
      data: {
        "login": "Admin",
        "password": "12345",
      },
    );
    try {
      if (token != '' && token['accessToken'] != '') {
        _token = token['accessToken'];

        await prefs.setString('token', _token);

        dynamic data = await APIService.postRequest(
          request: 'api/users/login',
          headers: {HttpHeaders.authorizationHeader: 'Bearer $_token'},
          data: {
            'login': login,
            'password': password,
          },
        );

        if (data != '') {
          return 'Token: $_token';
        }
      }
    } catch (e) {
      return 'Такого пользователя не существует или введен неправильный пароль.';
    }

    return 'Такого пользователя не существует или введен неправильный пароль.';
  }

  Future<String> regUser({
    required String login,
    required String password,
    required String name,
  }) async {
    dynamic token = await APIService.postRequest(
      request: 'api/auth/login',
      data: {
        "login": "Admin",
        "password": "12345",
      },
    );
    try {
      if (token != '' && token['accessToken'] != '') {
        _token = token['accessToken'];

        await prefs.setString('token', _token);

        dynamic data = await APIService.postRequest(
          request: 'api/users',
          headers: {HttpHeaders.authorizationHeader: 'Bearer $_token'},
          data: {
            'login': login,
            'password': password,
            "name": name,
          },
        );

        if (data != '') {
          return 'Token: $_token';
        }
      }
    } catch (e) {
      print(e);
      return 'Вероятно, такой пользователь существует. Попробуйте войти в аккаунт.';
    }

    return 'Вероятно, такой пользователь существует. Попробуйте войти в аккаунт.';
  }

  signOut() async {
    _token = '';
    await prefs.setString('token', _token);
  }
}
