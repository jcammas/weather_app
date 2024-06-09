import 'package:flutter/material.dart';
import 'package:my_app/weather/models/models.dart';
import 'package:weather_repository/weather_repository.dart' as repo;

class WeatherCard extends StatelessWidget {
  const WeatherCard({
    required this.weather,
    required this.units,
    required this.onRefresh,
    super.key,
  });

  final Weather weather;
  final TemperatureUnits units;
  final ValueGetter<Future<void>> onRefresh;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Card(
        elevation: 4.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _WeatherIcon(condition: weather.condition),
              const SizedBox(height: 16),
              Text(
                weather.location,
                style: theme.textTheme.headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                weather.formattedTemperature(units),
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Last Updated at ${TimeOfDay.fromDateTime(weather.lastUpdated).format(context)}',
              ),
            ],
          ),
        ),
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

extension on Weather {
  String formattedTemperature(TemperatureUnits units) {
    return '''${temperature.value.toStringAsPrecision(2)}°${units.isCelsius ? 'C' : 'F'}''';
  }
}
