  import 'package:flutter/material.dart';
  import 'package:geolocator/geolocator.dart';

  class Location{
    double? latitude;
    double? longitude;

    // Location(this.latitude, this.longitude); /*not needed*/
    Location();

    Future<void> getCurrentLocation() async{
      getPermission();
      Position place = await Geolocator.getCurrentPosition();
      latitude = place.latitude;
      longitude = place.longitude;
    }

    void getPermission() async{
      LocationPermission permission;
      permission = await Geolocator.checkPermission();
      if(permission == LocationPermission.denied){
        permission = await Geolocator.requestPermission();
      }
    }
  }