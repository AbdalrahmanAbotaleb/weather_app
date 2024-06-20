import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/pages/search_page.dart';
import 'package:weather_app/weather_contoller.dart';
import 'package:weather_icons/weather_icons.dart';

class HomePage extends StatelessWidget {
  final WeatherController weatherController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => SearchPage());
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: const Text('Weather App'),
      ),
      body: Obx(() {
        if (weatherController.weatherData.value == null) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'there is no weather 😔 start',
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
                Text(
                  'searching now 🔍',
                  style: TextStyle(
                    fontSize: 26,
                  ),
                )
              ],
            ),
          );
        } else {
          WeatherModel weatherData = weatherController.weatherData.value!;
          return Container(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  weatherData.getThemeColor(),
                  weatherData.getThemeColor()[300]!,
                  weatherData.getThemeColor()[100]!,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20), // Added to create space
                    Text(
                      weatherController.cityName.value!,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'updated at : ${weatherData.date.hour.toString().padLeft(2, '0')}:${weatherData.date.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 20), // Added to create space
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BoxedIcon(weatherData.getIcon(), size: 50),
                        // Text(
                        //   weatherData.temp.toInt().toString(),
                        //   style: const TextStyle(
                        //     fontSize: 32,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        Column(
                          children: [
                            Text('maxTemp: ${weatherData.maxTemp.toInt()}°C'),
                            Text('minTemp: ${weatherData.minTemp.toInt()}°C'),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20), // Added to create space
                    // Text(
                    //   weatherData.weatherStateName,
                    //   style: const TextStyle(
                    //     fontSize: 32,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    Text(
                     "  Temperature ${weatherData.temp.toInt().toString()}",
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    buildWeatherDetail(
                        'Wind Speed', '${weatherData.windSpeed} kph'),
                    buildWeatherDetail('Humidity', '${weatherData.humidity}%'),
                    buildWeatherDetail(
                        'Precipitation', '${weatherData.precipitation} mm'),
                    const SizedBox(height: 20), // Added to create space
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  Widget buildWeatherDetail(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
