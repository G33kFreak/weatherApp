import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/Services/api_service.dart';
import 'package:weather_app/widgets/weather_widget.dart';

class SearchCityDialog extends StatelessWidget {
  String _cityName;
  SearchCityDialog(this._cityName);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 0),
      elevation: 0,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          height: 160,
          width: MediaQuery.of(context).size.width * 0.95,
          child: WeatherWidget(
            name: _cityName,
            isLiked: false,
          )),
    );
  }
}
