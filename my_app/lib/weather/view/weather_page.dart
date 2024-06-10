import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/weather/cubit/weather_cubit.dart';
import 'package:my_app/weather/cubit/hourly_weather_cubit.dart';
import 'package:my_app/weather/view/weather_home.dart';
import 'package:weather_repository/weather_repository.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => WeatherCubit(context.read<WeatherRepository>()),
        ),
        BlocProvider(
          create: (context) => HourlyWeatherCubit(),
        ),
      ],
      child: const WeatherHome(),
    );
  }
}
