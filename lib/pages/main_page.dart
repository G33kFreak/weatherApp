import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/db_service.dart';
import 'package:weather_app/store/cities_store.dart';
import 'package:weather_app/store/location_store.dart';
import 'package:weather_app/widgets/list_of_cities.dart';
import 'package:weather_app/widgets/location_widget.dart';
import 'package:weather_app/widgets/my_app_bar.dart';
import 'package:weather_app/widgets/search_widget.dart';

class MainPage extends StatelessWidget {
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
        body: FutureBuilder(
          future: _locationStore.getCurrentLocation(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  margin: EdgeInsets.only(top: 110, left: 5, right: 5),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LocationWidget(snapshot),
                        const SizedBox(height: 15),
                        SearchWidget(),
                        FutureBuilder(
                            future: DbService.db.getCities(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                _citiesStore.loadCitiesIds(snapshot.data);
                                return Flexible(
                                    child: NotificationListener<
                                            OverscrollIndicatorNotification>(
                                        onNotification: (overscroll) {
                                          overscroll.disallowGlow();
                                        },
                                        child: new ListOfCities()));
                              } else {
                                return Column();
                              }
                            })
                      ]));
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }
}
