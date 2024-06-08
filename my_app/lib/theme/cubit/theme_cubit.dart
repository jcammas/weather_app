import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_app/weather/models/models.dart';
import 'package:weather_repository/weather_repository.dart' as repo;

class ThemeCubit extends HydratedCubit<Color> {
  ThemeCubit() : super(defaultColor);

  static const defaultColor = Color(0xFF2196F3);

  void updateTheme(Weather weather) {
    emit(weather.toColor);
  }

  @override
  Color fromJson(Map<String, dynamic> json) {
    return Color(int.parse(json['color'] as String));
  }

  @override
  Map<String, dynamic> toJson(Color state) {
    return <String, String>{'color': '${state.value}'};
  }
}

extension on Weather {
  Color get toColor {
    switch (condition) {
      case repo.WeatherCondition.clear:
        return Colors.yellow;
      case repo.WeatherCondition.snowy:
        return Colors.lightBlueAccent;
      case repo.WeatherCondition.cloudy:
        return Colors.blueGrey;
      case repo.WeatherCondition.rainy:
        return Colors.indigoAccent;
      case repo.WeatherCondition.unknown:
        return ThemeCubit.defaultColor;
    }
  }
}
