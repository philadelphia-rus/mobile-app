import 'dart:io';

import 'package:mobile_app/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/unit.dart';


class UnitService {
  // final SharedPreferences prefs;

  String _token =
      'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJBZG1pbiIsImV4cCI6MTY4MTAxNTEwMSwicm9sZXMiOlsiQURNSU4iXSwibG9naW4iOiJBZG1pbiJ9.bu03RqKuAqFkqK37LqaTvGT01K8djf526FONNv7IoCIeg940RWFAZow8NhuFqcB1KtcENh_-Z3s4ec5Ev3bn3A';

  get token => _token;

  UnitService(
      // required this.prefs,
      ) {
    // _token = prefs.getString('token') ?? '';
  }

  Future<List<Unit>> getFullUnits() async {
    dynamic data = await APIService.postRequest(
      request: 'api/units',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${_token}',
      },
    );
    print(data);
    if (data != null) {
      return data;
    }
    return [];
  }
}
