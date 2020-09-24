import 'package:flutter/cupertino.dart';
import 'package:weather_app/Services/DbService.dart';
import 'package:weather_app/widgets/WeatherWidget.dart';

class CitiesStore extends ChangeNotifier {
  List<String> _listOfCitiesNames = [];
  List<Widget> _listOfWidgets = [];

  List<String> get citiesNames => _listOfCitiesNames;
  List<Widget> get weathersWidgets => _listOfWidgets;

  set citiesNames(List<String> listOfCities) {
    _listOfCitiesNames = listOfCities;
    notifyListeners();
  }

  set weathersWidgets(List<Widget> listOfWidgets) {
    _listOfWidgets = listOfWidgets;
    notifyListeners();
  }

  loadWidgets(List<String> newList) {
    citiesNames = newList;
    weathersWidgets = widgets();
  }

  addCity(String name, context) {
    DbService.db.newCity(name);
    _listOfCitiesNames.add(name);
    notifyListeners();
    Navigator.pop(context);
  }

  removeCity(String name) {
    DbService.db.deleteCity(name);
    _listOfCitiesNames.remove(name);
    notifyListeners();
  }

  List<Widget> widgets() {
    List<Widget> widgets = [];
    _listOfCitiesNames.forEach((element) {
      widgets.add(WeatherWidget(element, null, true));
    });
    return widgets;
  }
}
