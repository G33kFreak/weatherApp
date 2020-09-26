import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

import 'dart:async';

class ApiService {
  Dio dio = Dio(BaseOptions(
      baseUrl: 'http://api.openweathermap.org/data/2.5/weather',
      queryParameters: {"appid": '00ede6869c4420c48f6cc04a109701b8'}));

  Future<WeatherModel> fetchWeatherByName(String name, String language) async {
    final _response =
        await dio.get('', queryParameters: {"q": name, "lang": language});

    if (_response.statusCode == 200) {
      return WeatherModel.fromJson(_response.data);
    } else {
      throw Exception('Error with connection');
    }
  }

  Future<WeatherModel> fetchWeatherByLonLat(
      double lon, double lat, String language) async {
    final _response = await dio.get('', queryParameters: {
      "lon": lon.toString(),
      "lat": lat.toString(),
      "lang": language
    });

    if (_response.statusCode == 200) {
      return WeatherModel.fromJson(_response.data);
    } else {
      throw Exception('Error with connection');
    }
  }

  Future<WeatherModel> fetchWeatherById(int id, String language) async {
    final _response = await dio
        .get('', queryParameters: {"id": id.toString(), "lang": language});

    if (_response.statusCode == 200) {
      return WeatherModel.fromJson(_response.data);
    } else {
      throw Exception('Error with connection');
    }
  }
}
