import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/references/refer.dart';

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    final queryParameters = {
      'q': city,
      'key': 'd43c57aaf07842779f3131033231207',
      'aqi': 'no'
    };

    final uri =
        Uri.https('api.weatherapi.com', '/v1/current.json', queryParameters);

    final response = await http.get(uri);
    print(response.body);
    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }
}
