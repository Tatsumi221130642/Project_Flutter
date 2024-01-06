import 'dart:convert';
import 'package:pert6/model/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:pert6/model/weather_data_current.dart';
import 'package:pert6/model/weather_data_daily.dart';
import 'package:pert6/model/weather_data_hourly.dart';
import 'package:pert6/utils/api_url.dart';

class FetchWeatherAPI {
  WeatherData? weatherData;

  //processing the data from response -> to json

  Future<WeatherData> processData(lat, lon) async {
    var response = await http.get(Uri.parse(apiURL(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(
        WeatherDataCurrent.fromjason(jsonString),
        WeatherDataHourly.fromjason(jsonString),
        WeatherDataDaily.fromjason((jsonString)));

    return weatherData!;
  }
}
