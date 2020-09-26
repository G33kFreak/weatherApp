import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/main_page.dart';
import 'package:weather_app/store/cities_store.dart';
import 'package:weather_app/store/location_store.dart';
import 'package:weather_app/store/settings_store.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_app/styles.dart';

void main() async {
  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
      translationLoader: FileTranslationLoader(
          useCountryCode: false,
          fallbackFile: 'en',
          basePath: 'assets/flutter_i18n',
          forcedLocale: Locale('en')));
  WidgetsFlutterBinding.ensureInitialized();
  await flutterI18nDelegate.load(null);
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingsStore>.value(value: SettingsStore()),
        ChangeNotifierProvider<CitiesStore>.value(value: CitiesStore()),
        ChangeNotifierProvider<LocationStore>.value(value: LocationStore())
      ],
      child: MaterialApp(
        localizationsDelegates: [
          flutterI18nDelegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        builder: FlutterI18n.rootAppBuilder(),
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          accentColor: primaryColor,
        ),
        home: MyApp(flutterI18nDelegate),
      )));
}

class MyApp extends StatelessWidget {
  final FlutterI18nDelegate flutterI18nDelegate;
  MyApp(this.flutterI18nDelegate);
  @override
  Widget build(BuildContext context) {
    final SettingsStore _settingsStore = Provider.of<SettingsStore>(context);
    _settingsStore.getUnitFromPref();
    _settingsStore.getLanguageFromPref();
    FlutterI18n.refresh(context, _settingsStore.languageLoc);
    return MainPage();
  }
}
