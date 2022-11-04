import 'package:dio/dio.dart';
import 'package:moruassignment/constants/urlconstants.dart';

import '../models/weather_api_model.dart';

Future<weatherModel> getWeather(String name) async {
  try {
    var url = urlConstants.baseurl + name;
    print(url);
    final response = await Dio().get(url);
    final unformatedata = response.data;
    final formateddata = weatherModel.fromJson(unformatedata);
    return formateddata;
  } catch (e) {
    rethrow;
  }
}
