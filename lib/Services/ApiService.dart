import 'package:dio/dio.dart' as dioHttp;
import '../models/WeatherModel.dart';
import 'dart:async';

class ApiService {
  final String _apiKey = '00ede6869c4420c48f6cc04a109701b8';
  dioHttp.Dio dio = dioHttp.Dio();

  Future<WeatherModel> fetchWeatherByName(String name) async {
    final String path = 'http://api.openweathermap.org/data/2.5/weather?q=' +
        name +
        '&appid=' +
        _apiKey;

    final _response = await dio.get(path);
    if (_response.statusCode == 200)
      return WeatherModel.fromJson(_response.data);
    else
      throw Exception('Error with connection');
  }

  Future<WeatherModel> fetchWeatherByLonLat(double lon, double lat) async {
    final String path = 'http://api.openweathermap.org/data/2.5/weather?lat=' +
        lat.toString() +
        '&lon=' +
        lon.toString() +
        '&appid=' +
        _apiKey;

    final _response = await dio.get(path);
    if (_response.statusCode == 200)
      return WeatherModel.fromJson(_response.data);
    else
      throw Exception('Error with connection');
  }

  Future<List<WeatherModel>> fetchWeathersByList(List<String> names) async {
    List<WeatherModel> _listOfWeathers = [];
    names.forEach((name) async {
      final String path = 'http://api.openweathermap.org/data/2.5/weather?q=' +
          name +
          '&appid=' +
          _apiKey;

      final _response = await dio.get(path);
      _listOfWeathers.add(WeatherModel.fromJson(_response.data));
    });
    return _listOfWeathers;
  }
}
