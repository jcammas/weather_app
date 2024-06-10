// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hourly_forecast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyForecast _$HourlyForecastFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'HourlyForecast',
      json,
      ($checkedConvert) {
        final val = HourlyForecast(
          time: $checkedConvert('time', (v) => DateTime.parse(v as String)),
          temperature:
              $checkedConvert('temperature', (v) => (v as num).toDouble()),
          precipitation:
              $checkedConvert('precipitation', (v) => (v as num).toDouble()),
          windDirection:
              $checkedConvert('wind_direction', (v) => (v as num).toInt()),
          windSpeed:
              $checkedConvert('wind_speed', (v) => (v as num).toDouble()),
        );
        return val;
      },
      fieldKeyMap: const {
        'windDirection': 'wind_direction',
        'windSpeed': 'wind_speed'
      },
    );

Map<String, dynamic> _$HourlyForecastToJson(HourlyForecast instance) =>
    <String, dynamic>{
      'time': instance.time.toIso8601String(),
      'temperature': instance.temperature,
      'precipitation': instance.precipitation,
      'wind_direction': instance.windDirection,
      'wind_speed': instance.windSpeed,
    };
