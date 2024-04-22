import 'package:flutter/material.dart';
import 'package:flutter_weather_app/weather/pages/pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage()
    );
  }
}
