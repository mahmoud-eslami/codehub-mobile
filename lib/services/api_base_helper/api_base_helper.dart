import 'dart:convert';
import 'dart:io';
import 'package:codehub/src/core/constant/api_path/api_path.dart';
import 'package:http/http.dart' as http;

class ApiBaseHelper {
  static Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(baseUrlPath + url));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  static Future<dynamic> post(String url, {Map? body}) async {
    var responseJson;
    try {
      final response =
          await http.post(Uri.parse(baseUrlPath + url), body: body ?? {});
      responseJson = _returnResponse(response);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }

  static dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        String body = utf8.decode(response.bodyBytes);
        var responseJson = json.decode(body);
        return responseJson;
      case 201:
        String body = utf8.decode(response.bodyBytes);
        var responseJson = json.decode(body);
        return responseJson;
      case 400:
        throw Exception(response.body.toString());
      case 401:
      case 403:
        throw Exception(response.body.toString());
      case 405:
        throw Exception(response.body.toString());
      case 500:
      default:
        throw Exception(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
