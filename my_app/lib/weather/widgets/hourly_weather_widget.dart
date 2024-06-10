import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/weather/cubit/hourly_weather_cubit.dart';
import 'package:my_app/weather/models/hourly_forecast.dart';
import 'package:my_app/weather/models/models.dart';
import 'package:weather_repository/weather_repository.dart' as repo;

class HourlyWeatherWidget extends StatelessWidget {
  final Weather weather;

  const HourlyWeatherWidget({
    super.key,
    required this.weather,
  });

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: hourlyForecasts.map((forecast) {
              return HourlyWeatherCard(
                forecast: forecast,
                weather: weather,
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class HourlyWeatherCard extends StatelessWidget {
  final HourlyForecast forecast;
  final Weather weather;

  const HourlyWeatherCard({
    super.key,
    required this.forecast,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${forecast.time.hour}:00',
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            '${forecast.temperature}°',
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _WeatherIcon(condition: weather.condition),
          const SizedBox(height: 8),
          Text(
            '💧${forecast.precipitation}%',
            style: const TextStyle(color: Colors.black, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.air, color: Colors.black, size: 14),
              Text(
                ' ${forecast.windSpeed} km/h',
                style: const TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon({required this.condition});

  static const _iconSize = 75.0;

  final repo.WeatherCondition condition;

  @override
  Widget build(BuildContext context) {
    return Text(
      condition.toEmoji,
      style: const TextStyle(fontSize: _iconSize),
    );
  }
}

extension on repo.WeatherCondition {
  String get toEmoji {
    switch (this) {
      case repo.WeatherCondition.clear:
        return '☀️';
      case repo.WeatherCondition.rainy:
        return '🌧️';
      case repo.WeatherCondition.cloudy:
        return '☁️';
      case repo.WeatherCondition.snowy:
        return '🌨️';
      case repo.WeatherCondition.unknown:
        return '❓';
    }
  }
}
