import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getWeatherData();
    // print('here I am ${weatherData['main']}');

    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context)
    =>LocationScreen(WeatherData: weatherData,)));
  }
  //id: 329629c163d76b404a7868da791eb85c
//alt id: b6907d289e10d714a6e88b30761fae22
}
