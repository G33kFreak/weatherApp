import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/store/cities_store.dart';
import 'package:weather_app/widgets/weather_widget.dart';

class ListOfCities extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CitiesStore>(
      builder: (context, cities, child) {
        return ListView.builder(
            //shrinkWrap: true,
            padding: EdgeInsets.only(left: 5, right: 5),
            itemCount: cities.citiesIds.length,
            itemBuilder: (context, index) {
              return new WeatherWidget(
                  null, null, true, cities.citiesIds[index]);
            });
      },
    );
  }
}
