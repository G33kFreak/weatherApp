import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Services/api_service.dart';
import 'package:weather_app/widgets/weather_widget.dart';

class SearchCityDialog extends StatelessWidget {
  String _cityName;
  SearchCityDialog(this._cityName);
  ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          height: 200,
          child: WeatherWidget(_cityName, null, false, null)),
    );
  }
}
