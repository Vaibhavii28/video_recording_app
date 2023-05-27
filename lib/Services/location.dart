import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'networking.dart';

class Location {
  double ?latitude;
  double ?longitude;
  static const apiKey = '8237fadb4980e5c236bb7ceafe85b1a6';
  static const openWeatherMapURL = 'http://api.openweathermap.org/geo/1.0/reverse';

  Future<dynamic> getLocation() async {
    try{

      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        print('Permission denied');
      }
      Position position = await Geolocator.getCurrentPosition(
        forceAndroidLocationManager: true,
        desiredAccuracy: LocationAccuracy.low
      );
      latitude = position.latitude;
      longitude = position.longitude;
      return CityLocation(latitude: latitude!, longitude: longitude!);
    }
    catch(e)
    {
      print(e);
    }
  }

  Future<String> getLocationCity() async {
    CityLocation citylocation= await getLocation();
    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?lat=${citylocation.latitude}&lon=${citylocation.longitude}&limit=1&appid=$apiKey');
    var city = await networkHelper.getData();
    print(city);
    return city[0]['name'];
    //

  }
}

class CityLocation{
  double latitude;
  double longitude;

  CityLocation({required this.latitude, required this.longitude});

}
