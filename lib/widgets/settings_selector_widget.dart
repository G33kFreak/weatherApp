import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/store/settings_store.dart';
import 'package:weather_app/styles.dart';

class SettingsSelectorWidget extends StatelessWidget {
  int _option;
  SettingsSelectorWidget(this._option);
  @override
  Widget build(BuildContext context) {
    final SettingsStore _settingsStore = Provider.of<SettingsStore>(context);

    // 0 for temperature units, 1 for languages
    String _textDescription = this._option == 0
        ? FlutterI18n.translate(context, "settings.units_selector")
        : FlutterI18n.translate(context, "settings.languages_selector");

    _changeFuction(String value) {
      this._option == 0
          ? _settingsStore.changeUnit(value)
          : _settingsStore.changeLanguage(value);
    }

    String _value =
        this._option == 0 ? _settingsStore.unitNow : _settingsStore.language;

    List<String> _items = this._option == 0
        ? _settingsStore.tempUnits
        : _settingsStore.listOfLanguages;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          _textDescription,
          style: settingsTextStyle,
        ),
        DropdownButton<String>(
          onChanged: (String value) {
            _changeFuction(value);
          },
          value: _value,
          items: _items.map((String unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: Text(unit.toString()),
            );
          }).toList(),
        )
      ],
    );
  }
}
