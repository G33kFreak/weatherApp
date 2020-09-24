import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../store/SettingsStore.dart';

class SettingsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SettingsStore _settingsStore = Provider.of<SettingsStore>(context);

    _settingsStore.getUnitFromPref();
    _settingsStore.getLanguageFromPref(context);

    return Scaffold(
        backgroundColor: Color(0xffEA6E4B),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: SafeArea(
            child: Text(
              'Settings',
              style: TextStyle(
                  fontSize: 34,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, -3))
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Temperature unit: ',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff48484A)),
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
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Text(
                  'Language: ',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff48484A)),
                ),
                DropdownButton<String>(
                  onChanged: (String value) {
                    _settingsStore.changeLanguage(value, context);
                  },
                  value: _settingsStore.language,
                  items: _settingsStore.listOfLanguages.map((String language) {
                    return DropdownMenuItem<String>(
                      value: language,
                      child: Text(language.toString()),
                    );
                  }).toList(),
                )
              ])
            ],
          ),
        ));
  }
}
