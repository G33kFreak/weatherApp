import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/store/cities_store.dart';
import 'package:weather_app/store/settings_store.dart';
import 'package:weather_app/styles.dart';

class WeatherWidget extends StatelessWidget {
  String _name;
  Position _position;
  bool _isLiked;
  int _id;
  WeatherWidget(this._name, this._position, this._isLiked, this._id);

  @override
  Widget build(BuildContext context) {
    final SettingsStore _settingsStore = Provider.of<SettingsStore>(context);
    final CitiesStore _citiesStore = Provider.of<CitiesStore>(context);

    return FutureBuilder(
      future: _position == null
          ? _name == null
              ? ApiService().fetchWeatherById(_id, _settingsStore.language)
              : ApiService().fetchWeatherByName(_name, _settingsStore.language)
          : ApiService().fetchWeatherByLonLat(
              _position.longitude, _position.latitude, _settingsStore.language),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WeatherModel _weatherModel = snapshot.data;
          Text _tempDataText = Text(_weatherModel.tempCel.toString());

          switch (_settingsStore.unitNow) {
            case 'Celsius':
              {
                _tempDataText = Text(
                  _weatherModel.tempCel.toString() + '°C',
                  style: tempTextStyle,
                );
              }
              break;
            case 'Kelvin':
              {
                _tempDataText = Text(
                  _weatherModel.tempKel.toString() + '°K',
                  style: tempTextStyle,
                );
              }
              break;
            case 'Fahrenheit':
              {
                _tempDataText = Text(
                  _weatherModel.tempFahr.toString() + '°F',
                  style: tempTextStyle,
                );
              }
              break;
          }
          return Container(
              margin: const EdgeInsets.only(bottom: 15),
              width: MediaQuery.of(context).size.width * 0.95,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _weatherModel.name,
                        style: cityNameTextStyle,
                      ),
                      IconButton(
                        icon: this._position != null
                            ? Icon(Icons.location_on)
                            : this._isLiked == true
                                ? Image.asset('assets/favIconFill.png')
                                : Image.asset('assets/favIconOut.png'),
                        onPressed: () {
                          if (this._position == null) {
                            if (this._isLiked) {
                              _citiesStore.removeCity(_weatherModel.id);
                            } else {
                              _citiesStore.addCity(_weatherModel.id);
                              Navigator.pop(context);
                            }
                          }
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          child: Column(
                        children: [
                          Row(
                            children: [
                              Image.network(_weatherModel.icon),
                              _tempDataText
                            ],
                          ),
                          Text(
                            _weatherModel.description,
                            style: weatherDescTextStyle,
                            textAlign: TextAlign.center,
                          )
                        ],
                      )),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.send,
                                  size: 12,
                                  color: greyColor,
                                ),
                                Text(
                                    _weatherModel.windSpeed.toString() + ' m/s',
                                    style: weatherTextStyle),
                              ],
                            ),
                            Text(
                                FlutterI18n.translate(
                                        context, "weather_widget.visibility") +
                                    (_weatherModel.visibility / 1000)
                                        .toString() +
                                    'km',
                                style: weatherTextStyle),
                            Text(
                                FlutterI18n.translate(
                                        context, "weather_widget.humidity") +
                                    _weatherModel.humibity.toString() +
                                    '%',
                                style: weatherTextStyle)
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ));
        } else {
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [const CircularProgressIndicator()]);
        }
      },
    );
  }
}
