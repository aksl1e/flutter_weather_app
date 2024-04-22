import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/weather/services/weather_service.dart';
import 'package:lottie/lottie.dart';

import '../models/models.dart';


class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('790bccce523fa1baa12608405b6eff60');
  Weather? _weather;
  final TextStyle textStyle = const TextStyle(
    fontSize: 35.0,
    color: Colors.white,
    fontFamily: "Jersey"
  );

  String getWeatherAnimation(String? mainCondition) {
    if(mainCondition == null) return 'assets/sunny.json';

    switch(mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/partly_shower.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'snow':
        return 'assets/snow_sunny.json';
      case 'clear':
      default:
        return 'assets/sunny.json';


    }
  }

  _fetchWeather() async {
    String latLon = await _weatherService.getCurrentLatLon();
    try {
      final weather = await _weatherService.getWeather(latLon);
      setState(() {
        _weather = weather;
      });
    }
    catch(e) {
      print(e);
    }
  }


  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  _weather?.cityName ?? "Loading City...",
                  textStyle: textStyle,
                    speed: const Duration(milliseconds: 70),
                ),
              ],
              pause: const Duration(seconds: 6),
              repeatForever: true,
            ),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  '${_weather?.temperature.round()}°C',
                  textStyle: textStyle,
                  speed: const Duration(milliseconds: 70),
                ),
              ],
              pause: const Duration(seconds: 6),
              repeatForever: true,
            ),
          ],
        ),
      ),
    );
  }
}
