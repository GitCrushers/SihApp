import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Weather")),
      body: Center(
        child: Text(
          "Weather details will be shown here",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
