import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationStore extends ChangeNotifier {
  Future<Position> getCurrentLocation() async {
    var location = await Geolocator().getCurrentPosition();
    return location;
  }
}
