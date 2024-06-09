import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/search/view/search_page.dart';
import 'package:my_app/settings/view/settings_page.dart';
import 'package:my_app/theme/cubit/theme_cubit.dart';
import 'package:my_app/weather/cubit/weather_cubit.dart';
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
    context.read<WeatherCubit>().fetchWeather('Paris');
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
      body: Column(
        children: [
          Center(
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
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: WeatherCard(
                            weather: state.weather,
                            units: state.temperatureUnits,
                            onRefresh: () {
                              return context
                                  .read<WeatherCubit>()
                                  .refreshWeather();
                            },
                          ),
                        ),
                        Text("widget heure par heure"),
                        Text("Widget prévision de la semaine")
                      ],
                    );
                  case WeatherStatus.failure:
                    return const WeatherError();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search, semanticLabel: 'Search'),
        onPressed: () async {
          final city = await Navigator.of(context).push(SearchPage.route());
          if (!context.mounted) return;
          await context.read<WeatherCubit>().fetchWeather(city);
        },
      ),
    );
  }
}
