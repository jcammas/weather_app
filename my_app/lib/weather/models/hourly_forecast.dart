import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hourly_forecast.g.dart';

@JsonSerializable()
class HourlyForecast extends Equatable {
  const HourlyForecast({
    required this.time,
    required this.temperature,
    required this.precipitation,
    required this.windDirection,
    required this.windSpeed,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) =>
      _$HourlyForecastFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyForecastToJson(this);

  final DateTime time;
  final double temperature;
  final double precipitation;
  final int windDirection;
  final double windSpeed;

  @override
  List<Object?> get props =>
      [time, temperature, precipitation, windDirection, windSpeed];
}
