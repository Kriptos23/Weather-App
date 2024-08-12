import 'package:clima/services/networking.dart';
import 'package:clima/services/location.dart';

const String apiKey = '329629c163d76b404a7868da791eb85c';
const String url = 'https://api.openweathermap.org/data/2'
    '.5/weather?';

class WeatherModel {
  double? latitude;
  double? longitude;

  Future<dynamic> getWeatherData() async{
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude!;
    longitude = location.longitude!;
    print("latitude: ${location.latitude}, longitude: ${location.longitude}");

    Networking networking = Networking
      ('${url}lat=$latitude&lon=$longitude&appid'
        '=$apiKey&units=metric');

    var weatherData = networking.getData();
    return(await weatherData);
  }

  Future<dynamic> getWeatherCity(String cityName) async{
    Networking networking = Networking
      ('${url}q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networking.getData();
    return(weatherData);
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
