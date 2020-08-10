import 'package:the_climate_app_flutter/services/location.dart';
import 'package:the_climate_app_flutter/services/networking.dart';
import 'package:the_climate_app_flutter/utilities/constants.dart';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    var url = '$kOpenWeatherDomain?q=$cityName&appid=$kApiKey&units=metric';
    Networking networkingService = Networking(url: url);
    var weatherData = await networkingService.getData();
    return weatherData;
  }

  Future<dynamic> getWeatherData() async {
    Location locationService = Location();
    await locationService.getLocation();
    Networking networkingService = Networking(
        url:
            '$kOpenWeatherDomain?lat=${locationService.latitude}&lon=${locationService.longitude}&appid=$kApiKey&units=metric');
    var weatherData = await networkingService.getData();
    return weatherData;
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
