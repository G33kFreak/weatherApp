import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LocationStore extends ChangeNotifier {
  Future<Position> getCurrentLocation() async {
    var answer = await Geolocator().getCurrentPosition();
    return answer;
  }
}
