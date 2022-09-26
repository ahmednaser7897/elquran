// ignore_for_file: avoid_print

import 'package:geolocator/geolocator.dart';
import 'package:quran_app/shard/services/location.dart';

class CurantPosition{
  Position ?position;
  
  getMyPosition() async {
    try {
      MyPosition p = MyPosition();
      position = await p.determinePosition();
      print(position!.latitude);
      print(position!.longitude);
    } catch (e) {
      print("erorr from getMyPosition is " + e.toString());
    }
  }
}