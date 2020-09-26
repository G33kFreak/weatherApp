import 'package:flutter/cupertino.dart';
import 'package:weather_app/services/db_service.dart';

class CitiesStore extends ChangeNotifier {
  List<int> _listOfCitiesIds = [];

  List<int> get citiesIds => _listOfCitiesIds;

  set citiesIds(List<int> listOfCities) {
    _listOfCitiesIds = listOfCities;
  }

  loadCitiesIds(List<int> ids) {
    citiesIds = ids;
  }

  addCity(int id) async {
    await DbService.db.newCity(id);
    notifyListeners();
  }

  removeCity(int id) async {
    await DbService.db.deleteCity(id);
    notifyListeners();
  }
}
