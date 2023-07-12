// {"location":{"name":"Mumbai","region":"Maharashtra","country":"India","tz_id":"Asia/Kolkata","localtime":"2023-06-23 21:43"},"current":{"last_updated_epoch":1687536000,"last_updated":"2023-06-23 21:30","temp_c":31.0,"temp_f":87.8,"is_day":0,"condition":{"text":"Mist","icon":"//cdn.weatherapi.com/weather/64x64/night/143.png","code":1030},
//
import 'package:intl/intl.dart';

class Locandtimeinfo {
  final String city_name;
  final String region_name;
  final String localtime;

  Locandtimeinfo({
    required this.city_name,
    required this.region_name,
    required this.localtime,
  });

  factory Locandtimeinfo.fromJson(Map<String, dynamic> json) {
    final city_name = json['name'];
    final region_name = json['region'];
    final localtimeString = json['localtime'];

    return Locandtimeinfo(
      city_name: city_name,
      region_name: region_name,
      localtime: localtimeString,
    );
  }

  String getFormattedDate() {
    final localtimeDate = DateTime.parse(localtime);
    final formatter = DateFormat("d MMMM yyyy");
    final formattedDate = formatter.format(localtimeDate);
    return formattedDate;
  }
}

class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({required this.description, required this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final desc = json['text'];
    final icon = json['icon'];

    return WeatherInfo(description: desc, icon: icon);
  }
}

class TemperatureInfo {
  final double temp;

  TemperatureInfo({required this.temp});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final tempc = json['temp_c'];

    return TemperatureInfo(temp: tempc);
  }
}

class WeatherResponse {
  final String cityName;
  final TemperatureInfo temperatureInfo;
  final WeatherInfo weatherInfo;
  final String locname;
  final String region_name;
  final Locandtimeinfo localtime;

  WeatherResponse({
    required this.cityName,
    required this.temperatureInfo,
    required this.weatherInfo,
    required this.locname,
    required this.region_name,
    required this.localtime,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['location']['name'].toString();
    final temperatureInfoJson = json['current'];
    final temperatureInfo = TemperatureInfo.fromJson(temperatureInfoJson);
    final weatherInfoJson = json['current']['condition'];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);
    final locname = json['location']['name'].toString();
    final region_name = json['location']['region'].toString();
    final locandtimeinfoJson = json['location'];
    final locandtimeinfo = Locandtimeinfo.fromJson(locandtimeinfoJson);

    return WeatherResponse(
      cityName: cityName,
      temperatureInfo: temperatureInfo,
      weatherInfo: weatherInfo,
      locname: locname,
      region_name: region_name,
      localtime: locandtimeinfo,
    );
  }
}
