import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/pages/home_page.dart';

import 'weather_contoller.dart';

void main() {
  Get.put(WeatherController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      home: HomePage(),
    );
  }
}
