import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/search/view/search_page.dart';
import 'package:my_app/settings/view/settings_page.dart';
import 'package:my_app/theme/cubit/theme_cubit.dart';
import 'package:my_app/weather/cubit/weather_cubit.dart';
import 'package:my_app/weather/cubit/hourly_weather_cubit.dart';
import 'package:my_app/weather/widgets/hourly_weather_widget.dart';
import 'package:my_app/weather/widgets/weather_card.dart';
import 'package:my_app/weather/widgets/widgets.dart';

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  @override
  void initState() {
    super.initState();
    final weatherCubit = context.read<WeatherCubit>();
    weatherCubit.fetchWeather('Paris');
    context.read<HourlyWeatherCubit>().fetchHourlyWeather();
  }

  Future<void> _refreshWeather() async {
    await context.read<WeatherCubit>().refreshWeather();
    await context.read<HourlyWeatherCubit>().fetchHourlyWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Under the Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push<void>(
                SettingsPage.route(context.read<WeatherCubit>()),
              );
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshWeather,
        child: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {
            if (state.status.isSuccess) {
              context.read<ThemeCubit>().updateTheme(state.weather);
            }
          },
          builder: (context, state) {
            switch (state.status) {
              case WeatherStatus.initial:
                return const WeatherLoading();
              case WeatherStatus.loading:
                return const WeatherLoading();
              case WeatherStatus.success:
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: WeatherCard(
                        weather: state.weather,
                        units: state.temperatureUnits,
                        onRefresh: _refreshWeather,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: HourlyWeatherWidget(),
                    ),
                    const Text("Widget heure par heure"),
                    const Text("Widget prévision de la semaine"),
                  ],
                );
              case WeatherStatus.failure:
                return const WeatherError();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search, semanticLabel: 'Search'),
        onPressed: () async {
          final city = await Navigator.of(context).push(SearchPage.route());
          if (!context.mounted) return;
          await context.read<WeatherCubit>().fetchWeather(city);
          await context.read<HourlyWeatherCubit>().fetchHourlyWeather();
        },
      ),
    );
  }
}
