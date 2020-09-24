import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/Services/DbService.dart';
import 'package:weather_app/store/CitiesStore.dart';
import 'package:weather_app/store/LocationStore.dart';
import 'package:weather_app/store/SettingsStore.dart';
import 'package:weather_app/widgets/WeatherWidget.dart';
import 'package:weather_app/widgets/searchCityWidget.dart';
import './widgets/MyAppBar.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  final FlutterI18nDelegate flutterI18nDelegate = FlutterI18nDelegate(
    translationLoader: FileTranslationLoader(
      useCountryCode: false,
      fallbackFile: 'en',
      basePath: 'assets/flutter_i18n',
      //forcedLocale: Locale('es')
    ),
  );
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
            accentColor: Color(0xffEA6E4B)),
        home: MyApp(flutterI18nDelegate),
      )));
}

class MyApp extends StatelessWidget {
  final FlutterI18nDelegate flutterI18nDelegate;

  MyApp(this.flutterI18nDelegate);

  final _textInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CitiesStore _citiesStore = Provider.of<CitiesStore>(context);
    final LocationStore _locationStore = Provider.of<LocationStore>(context);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: MyAppBar(),
        ),
        body: SingleChildScrollView(
            child: FutureBuilder(
          future: _locationStore.getCurrentLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 110),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Your location',
                          style: TextStyle(
                              color: Color(0xff48484A),
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Divider(color: Color(0xff48484A)),
                        WeatherWidget(null, snapshot.data, true),
                        SizedBox(height: 15),
                        Text(
                          'Favorite locations',
                          style: TextStyle(
                              color: Color(0xff48484A),
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Divider(color: Color(0xff48484A)),
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: TextField(
                                controller: _textInputController,
                                style: TextStyle(color: Color(0xffEA6E4B)),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xffEA6E4B),
                                            width: 1.5),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    hintText: 'Search location...',
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        FocusScopeNode currentFocus =
                                            FocusScope.of(context);
                                        if (!currentFocus.hasPrimaryFocus) {
                                          currentFocus.unfocus();
                                        }
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SearchCityWidget(
                                                  _textInputController.text);
                                            });
                                      },
                                      icon: Icon(Icons.search,
                                          color: Color(0xffEA6E4B), size: 24),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white))),
                        FutureBuilder(
                            future: DbService.db.getCities(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                _citiesStore.loadWidgets(snapshot.data);
                                return Column(
                                  children: _citiesStore.widgets(),
                                );
                              } else {
                                return Column();
                              }
                            })
                      ]));
            } else {
              return CircularProgressIndicator();
            }
          },
        )));
  }
}
