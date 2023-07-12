import 'package:flutter/material.dart';
import 'package:weather_app/references/refer.dart';
import 'package:weather_app/services/data_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _cityTextController = TextEditingController();
  final DataService _dataService = DataService();
  WeatherResponse? _response;
  bool _showTemperature = false;
  String _errorMessage = '';
  bool _iconbool = false;
  IconData _iconlight = Icons.wb_sunny;
  IconData _icondark = Icons.nightlight_sharp;
  final ThemeData _lighttheme = ThemeData.light(useMaterial3: true);
  final ThemeData _darktheme = ThemeData.dark(useMaterial3: true);

  @override
  void dispose() {
    _cityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _iconbool ? _darktheme : _lighttheme,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //button that toggles between light or dark theme
              IconButton(
                  padding: const EdgeInsets.all(5),
                  onPressed: () {
                    setState(() {
                      _iconbool = !_iconbool;
                    });
                  },
                  icon: Icon(_iconbool ? _icondark : _iconlight)), //
              if (_response != null)
                Column(
                  children: [
                    Text(
                      _response != null
                          ? _response!.localtime.getFormattedDate()
                          : '',
                      style: TextStyle(fontSize: 16),
                    ),
                    // Text('${_response?.locname} / ${_response?.region_name}'),
                    Text('${_response?.locname}',
                        style: TextStyle(fontSize: 20)), //location name
                    Image.network(_response!.weatherInfo.icon), //weather icon
                    Text(
                      _showTemperature
                          ? '${_response!.temperatureInfo.temp}°C'
                          : '',
                      style: const TextStyle(
                        fontSize: 100,
                      ),
                    ), //temperature in celsius
                    Text(
                      _showTemperature
                          ? _response!.weatherInfo.description
                          : '',
                      style: const TextStyle(fontSize: 20),
                    ), //temperature description
                  ],
                ),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: SizedBox(
                  width: 150,
                  child: TextField(
                    controller: _cityTextController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      labelText: 'City',
                      hintText: 'Enter city',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _search,
                child: const Text('SEARCH'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _search() async {
    final city = _cityTextController.text;
    if (city.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a city name';
        _response = null;
        _showTemperature = false;
      });
      return;
    }

    try {
      final response = await _dataService.getWeather(city);
      setState(() {
        _response = response;
        _showTemperature = true;
        _errorMessage = '';
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Failed to fetch weather data';
        _response = null;
        _showTemperature = false;
      });
    }
  }
}
