import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Services/ApiService.dart';
import 'package:weather_app/widgets/WeatherWidget.dart';

class SearchCityWidget extends StatelessWidget {
  String _cityName;
  SearchCityWidget(this._cityName);
  ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          height: 200,
          child: WeatherWidget(_cityName, null, false)),
    );
  }
}
