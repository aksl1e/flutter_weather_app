import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String latLon) async {
    final response = await http.get(Uri.parse('$BASE_URL?$latLon&appid=$apiKey&units=metric'));

    if(response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data!');
    }
  }

  Future<String> getCurrentLatLon() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high
    );

    return "lat=${position.latitude}&lon=${position.longitude}";
  }
}