import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/store/settings_store.dart';
import 'package:weather_app/styles.dart';
import 'package:weather_app/widgets/settings_selector_widget.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SettingsStore _settingsStore = Provider.of<SettingsStore>(context);

    _settingsStore.getUnitFromPref();
    _settingsStore.getLanguageFromPref();

    return Scaffold(
        backgroundColor: primaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: SafeArea(
            child: Text(
              FlutterI18n.translate(context, "app_bar.settings"),
              style: appBarTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          decoration: const BoxDecoration(
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12, blurRadius: 5, offset: Offset(0, -3))
              ],
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 0 for temperature units, 1 for languages
              SettingsSelectorWidget(0),
              SettingsSelectorWidget(1)
            ],
          ),
        ));
  }
}
