import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:weather_app/models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  var weatherData = Rxn<WeatherModel>();
  var cityName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadWeatherFromPrefs();
  }

  Future<void> fetchWeather(String city) async {
    String baseUrl = 'http://api.weatherapi.com/v1';
    String apiKey = '3677bed892474b30b7a122242220806';
    Uri url = Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$city&days=1');
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      try {
        weatherData.value = WeatherModel.fromJson(data);
        cityName.value = city;
        saveWeatherToPrefs(data, city);
      } catch (e) {
        print("Error parsing weather data: $e");
        Get.snackbar('Error', 'Failed to parse weather data');
      }
    } else {
      Get.snackbar('Error', 'Failed to fetch weather data');
    }
  }

  void saveWeatherToPrefs(dynamic data, String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('weatherData', jsonEncode(data));
    prefs.setString('cityName', city);
  }

  void loadWeatherFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? weatherJson = prefs.getString('weatherData');
    String? city = prefs.getString('cityName');

    if (weatherJson != null && city != null) {
      var data = jsonDecode(weatherJson);
      try {
        weatherData.value = WeatherModel.fromJson(data);
        cityName.value = city;
      } catch (e) {
        print("Error loading weather data from prefs: $e");
      }
    }
  }
}
