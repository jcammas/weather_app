import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/weather/cubit/hourly_weather_cubit.dart';
import 'package:my_app/weather/models/hourly_forecast.dart';

class HourlyWeatherWidget extends StatelessWidget {
  const HourlyWeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HourlyWeatherCubit, List<HourlyForecast>>(
      builder: (context, hourlyForecasts) {
        if (hourlyForecasts.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: hourlyForecasts.map((forecast) {
              return HourlyWeatherCard(forecast: forecast);
            }).toList(),
          ),
        );
      },
    );
  }
}

class HourlyWeatherCard extends StatelessWidget {
  final HourlyForecast forecast;

  const HourlyWeatherCard({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.blueAccent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${forecast.time.hour}:00',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            '${forecast.temperature}°C',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 8),
          Text(
            '${forecast.precipitation} mm',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Wind: ${forecast.windSpeed} km/h',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Dir: ${forecast.windDirection}°',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
