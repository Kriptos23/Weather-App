import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';

double? latitude;
double? longitude;

double? kkTemp;
int? kkId;
String? kkName;

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SpinKitWaveSpinner(color: Colors.green, trackColor: Colors
                .greenAccent, waveColor: Colors.greenAccent, size: 500,
                duration: Duration(milliseconds: 4000)),
          ],
        ),
      ),
    );
  }

  void getLocation() async{
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude!;
    longitude = location.longitude!;
    print("latitude: ${location.latitude}, longitude: ${location.longitude}");
    final locDataObj = await getLocationData();

    Navigator.push(context, MaterialPageRoute(builder: (context)
    =>LocationScreen(WeatherData: locDataObj,)));
  }
  
  Future getLocationData() async{
    Networking networking = Networking('https://api.openweathermap.org/data/2'
        '.5/weather?lat=$latitude&lon=$longitude&appid=329629c163d76b404a7868da791eb85c');

    var getData = await networking.getData();
    return getData;
    kkTemp = await getData['main']['temp'];
    print(kkTemp);
    // kkId = await getData['weather'][0]['id'];
    // kkName = await getData['name'];
    //
    // print("temp: $kkTemp, id: $kkId, name: $kkName");
  }
  //id: 329629c163d76b404a7868da791eb85c
//alt id: b6907d289e10d714a6e88b30761fae22
}
