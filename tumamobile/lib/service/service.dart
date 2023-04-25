
import 'dart:convert';
import 'dart:io';

import 'package:tumamobile/service/base_service.dart';
import 'package:tumamobile/utils/app_exception.dart';

import 'package:http/http.dart' as http;

class Service extends BaseService {

  @override
  Future getResponse(String query) async {
    dynamic responseJson;

    try {
      final response = await http.get(Uri.parse(mediaBaseUrl + query));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }

    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch(response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException("Error occurred while communication");
    }
  }
}