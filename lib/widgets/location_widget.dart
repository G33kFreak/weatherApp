import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:weather_app/styles.dart';
import 'package:weather_app/widgets/weather_widget.dart';

class LocationWidget extends StatelessWidget {
  var _snapshot;
  LocationWidget(this._snapshot);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          FlutterI18n.translate(context, "main_page.location_now"),
          style: bodyLabelTextStyle,
        ),
        const Divider(color: greyColor),
        WeatherWidget(null, _snapshot.data, true, null),
      ],
    );
  }
}
