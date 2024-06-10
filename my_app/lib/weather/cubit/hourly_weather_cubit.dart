import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_app/weather/models/hourly_forecast.dart';

class HourlyWeatherCubit extends Cubit<List<HourlyForecast>> {
  HourlyWeatherCubit() : super([]);

  Future<void> fetchHourlyWeather() async {
    final response = await http.get(
      Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=48.8566&longitude=2.3522&hourly=temperature_2m,precipitation,winddirection_10m,windspeed_10m'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data == null || data['hourly'] == null) {
        emit([]);
        return;
      }

      final currentTime = DateTime.now().toUtc();
      final endTime = currentTime.add(const Duration(hours: 24));

      final List<HourlyForecast> forecasts =
          (data['hourly']['time'] as List).asMap().entries.map((entry) {
        int i = entry.key;
        return HourlyForecast(
          time: DateTime.parse(entry.value),
          temperature: (data['hourly']['temperature_2m'][i] as num).toDouble(),
          precipitation: (data['hourly']['precipitation'][i] as num).toDouble(),
          windDirection:
              (data['hourly']['winddirection_10m'][i] as num).toInt(),
          windSpeed: (data['hourly']['windspeed_10m'][i] as num).toDouble(),
        );
      }).where((forecast) {
        return forecast.time.isAfter(currentTime) &&
            forecast.time.isBefore(endTime);
      }).toList();

      emit(forecasts);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
