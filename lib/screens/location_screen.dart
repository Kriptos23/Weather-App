import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();

  final WeatherData;

  LocationScreen({this.WeatherData});
}

// void printData() async{
//   print(widget.WeatherData)
// }

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  String? weatherIcon;
  String? weatherMessage;
  int? temperature;
  late int condition;
  late String cityName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Inside of the second screen ${widget.WeatherData['main']['temp']}');
    updateUI(widget.WeatherData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if(weatherData == null){
        temperature = 0;
        condition = 0;
        cityName = 'couldn\'t find a city';
        return;
      }
      double temp =  weatherData['main']['temp'];
      temperature =  temp.toInt();
      condition =  weatherData['weather'][0]['id'];
      cityName =  weatherData['name'];
      weatherIcon =  (weather.getWeatherIcon(condition!));
      weatherMessage =  weather.getMessage(temperature!);

      print("checkin: $weatherIcon");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: ()async {
                      var weatherData = await(weather.getWeatherData());
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder:
                      (context)=>CityScreen()));
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '${temperature ?? 'default'}',
                      style: kkTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kkConditionTextStyle.copyWith(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $cityName",
                  textAlign: TextAlign.right,
                  style: kkMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

