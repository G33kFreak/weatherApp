import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/Services/ApiService.dart';
import 'package:weather_app/models/WeatherModel.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/store/CitiesStore.dart';
import 'package:weather_app/store/SettingsStore.dart';

class WeatherWidget extends StatelessWidget {
  String _name;
  Position _position;
  bool _isLiked;
  WeatherWidget(this._name, this._position, this._isLiked);

  @override
  Widget build(BuildContext context) {
    final SettingsStore _settingsStore = Provider.of<SettingsStore>(context);
    final CitiesStore _citiesStore = Provider.of<CitiesStore>(context);

    return FutureBuilder(
      future: _position == null
          ? ApiService().fetchWeatherByName(_name)
          : ApiService()
              .fetchWeatherByLonLat(_position.longitude, _position.latitude),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WeatherModel _weatherModel = snapshot.data;
          Text _tempDataText = Text(_weatherModel.tempCel.toString());

          switch (_settingsStore.unitNow) {
            case 'Celsius':
              {
                _tempDataText = Text(
                  _weatherModel.tempCel.toString() + '°C',
                  style: TextStyle(
                      color: Color(0xff48484A),
                      fontSize: 36,
                      fontWeight: FontWeight.w600),
                );
              }
              break;
            case 'Kelvin':
              {
                _tempDataText = Text(
                  _weatherModel.tempKel.toString() + '°K',
                  style: TextStyle(
                      color: Color(0xff48484A),
                      fontSize: 36,
                      fontWeight: FontWeight.w600),
                );
              }
              break;
            case 'Fahrenheit':
              {
                _tempDataText = Text(
                  _weatherModel.tempFahr.toString() + '°F',
                  style: TextStyle(
                      color: Color(0xff48484A),
                      fontSize: 36,
                      fontWeight: FontWeight.w600),
                );
              }
              break;
          }
          return Container(
              margin: EdgeInsets.only(bottom: 25),
              width: MediaQuery.of(context).size.width * 0.95,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _weatherModel.name,
                        style: TextStyle(
                            color: Color(0xff48484A),
                            fontSize: 24,
                            fontWeight: FontWeight.w600),
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
                              _citiesStore.removeCity(_weatherModel.name);
                            } else {
                              _citiesStore.addCity(_weatherModel.name, context);
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
                            style: TextStyle(
                                color: Color(0xff48484A),
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
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
                                Icon(
                                  Icons.send,
                                  size: 12,
                                  color: Color(0xff48484A),
                                ),
                                Text(
                                    _weatherModel.windSpeed.toString() + ' m/s',
                                    style: TextStyle(fontSize: 18)),
                              ],
                            ),
                            Text(
                                'Visibility: ' +
                                    (_weatherModel.visibility / 1000)
                                        .toString() +
                                    'km',
                                style: TextStyle(fontSize: 18)),
                            Text(
                                'Humidity: ' +
                                    _weatherModel.humibity.toString() +
                                    '%',
                                style: TextStyle(fontSize: 18))
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ));
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
