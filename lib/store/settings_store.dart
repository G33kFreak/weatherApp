import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsStore extends ChangeNotifier {
  //Temp units settings
  List<String> _tempUnits = ['Celsius', 'Kelvin', 'Fahrenheit'];
  String _unitPrefKey = 'tempUnit';

  String _unitNow = 'Celsius';

  getUnitFromPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String unitFromPrefs = prefs.getString(_unitPrefKey);
    if (unitFromPrefs == null) {
      _writeUnitToPrefs('Celsius');
    } else {
      _unitNow = unitFromPrefs;
    }
  }

  _writeUnitToPrefs(String unit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_unitPrefKey, unit);
  }

  List<String> get tempUnits => _tempUnits;

  String get unitNow => _unitNow;

  set unitNow(String val) {
    _writeUnitToPrefs(val);
    _unitNow = val;
    notifyListeners();
  }

  changeUnit(String val) {
    unitNow = val;
  }

  //Language settings
  List<String> _languagesList = ['EN', 'RU', 'PL'];

  String _languagePrefKey = 'language';

  String _lanChosen = 'EN';

  Locale _languageLoc = Locale('en');

  //Locale _languageLoc;

  getLanguageFromPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String lanFromPrefs = prefs.getString(_languagePrefKey);
    if (lanFromPrefs == null) {
      _writeLanguageToPrefs('EN');
    } else {
      _lanChosen = lanFromPrefs;
      _languageLoc = Locale(lanFromPrefs.toLowerCase());
    }
  }

  _writeLanguageToPrefs(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_languagePrefKey, language);
  }

  List<String> get listOfLanguages => _languagesList;

  String get language => _lanChosen;

  Locale get languageLoc => _languageLoc;

  set languageLoc(Locale val) {
    _languageLoc = val;
    notifyListeners();
  }

  set language(String val) {
    _writeLanguageToPrefs(val);
    _lanChosen = val;
    notifyListeners();
  }

  changeLanguage(String val) async {
    language = val;
    languageLoc = Locale(val.toLowerCase());
    notifyListeners();
  }
}
