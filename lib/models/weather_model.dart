import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherModel {
  DateTime date;
  double temp;
  double maxTemp;
  double minTemp;
  String weatherStateName;
  double windSpeed;
  int humidity;
  double precipitation;

  WeatherModel({
    required this.date,
    required this.temp,
    required this.maxTemp,
    required this.minTemp,
    required this.weatherStateName,
    required this.windSpeed,
    required this.humidity,
    required this.precipitation,
  });

  factory WeatherModel.fromJson(dynamic data) {
    var jsonData = data['forecast']['forecastday'][0]['day'];

    return WeatherModel(
      date: DateTime.parse(data['current']['last_updated']),
      temp: jsonData['avgtemp_c'].toDouble(),
      maxTemp: jsonData['maxtemp_c'].toDouble(),
      minTemp: jsonData['mintemp_c'].toDouble(),
      weatherStateName: jsonData['condition']['text'],
      windSpeed: jsonData['maxwind_kph'].toDouble(),
      humidity: jsonData['avghumidity'].toInt(),
      precipitation: jsonData['totalprecip_mm'].toDouble(),
    );
  }

  IconData getIcon() {
    bool isDayTime = date.hour >= 6 && date.hour < 18; // Assuming day time is between 6 AM and 6 PM

    if (weatherStateName == 'Sunny' || weatherStateName == 'Clear') {
      return isDayTime ? WeatherIcons.day_sunny : WeatherIcons.night_clear;
    } else if (weatherStateName.contains('cloud')) {
      return isDayTime ? WeatherIcons.day_cloudy : WeatherIcons.night_alt_cloudy;
    } else if (weatherStateName.contains('rain')) {
      return isDayTime ? WeatherIcons.day_rain : WeatherIcons.night_alt_rain;
    } else if (weatherStateName.contains('snow')) {
      return isDayTime ? WeatherIcons.day_snow : WeatherIcons.night_alt_snow;
    } else if (weatherStateName.contains('thunder')) {
      return isDayTime ? WeatherIcons.day_thunderstorm : WeatherIcons.night_alt_thunderstorm;
    } else {
      return isDayTime ? WeatherIcons.day_sunny : WeatherIcons.night_clear;
    }
  }

  MaterialColor getThemeColor() {
    // if (weatherStateName == 'Sunny' || weatherStateName == 'Clear') {
    //   return Colors.orange;
    // } 
    
     if (weatherStateName.contains('cloud')) {
      return Colors.blueGrey;
    } else if (weatherStateName.contains('rain')) {
      return Colors.blue;
    } else if (weatherStateName.contains('snow')) {
      return Colors.lightBlue;
    } else if (weatherStateName.contains('thunder')) {
      return Colors.deepPurple;
    } else {
      return Colors.blueGrey;
    }
  }
}
