import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/store/settings_store.dart';
import 'package:weather_app/styles.dart';

class UnitSelectorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SettingsStore _settingsStore = Provider.of<SettingsStore>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          FlutterI18n.translate(context, "settings.units_selector"),
          style: settingsTextStyle,
        ),
        DropdownButton<String>(
          onChanged: (String value) {
            _settingsStore.changeUnit(value);
          },
          value: _settingsStore.unitNow,
          items: _settingsStore.tempUnits.map((String unit) {
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
