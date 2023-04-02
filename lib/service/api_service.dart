import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class APIService {
  static const List<String> url = [
    'http://neroun.duckdns.org:8080',
    'http://aleph-one.duckdns.org:8069'
  ];

  static Future<dynamic> postRequest(
      {required String request,
      Map<String, String> queryParameters = const {},
      Map<String, String> data = const {},
      Map<String, String> headers = const {},
      int index = 0}) async {
    try {
      var response = await Dio().post(
        '${url[index]}/$request',
        queryParameters: queryParameters,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
      print('${url[index]}/$request');
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
    return '';
  }

  static Future<dynamic> getRequest(
      {required String request,
      Map<String, String> queryParameters = const {}}) async {
    try {
      var response =
          await Dio().get('$url/$request', queryParameters: queryParameters);
      debugPrint(response.toString());
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      debugPrint(e.toString());
      return '';
    }
    return '';
  }

  static Future<dynamic> putRequest(
      {required String request,
      Map<String, String> queryParameters = const {},
      Map<String, String> data = const {}}) async {
    try {
      var response = await Dio()
          .put('$url/$request', queryParameters: queryParameters, data: data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print(e);
      return '';
    }
    return '';
  }
}
