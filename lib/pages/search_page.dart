import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/weather_contoller.dart';

class SearchPage extends StatelessWidget {
  final WeatherController weatherController = Get.find();
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search City'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                weatherController.fetchWeather(cityController.text);
                Get.back();
              },
              child: const Text('Get Weather'),
            ),
          ],
        ),
      ),
    );
  }
}
