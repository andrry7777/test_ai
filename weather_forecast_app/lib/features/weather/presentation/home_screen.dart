import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'view_model/home_view_model.dart';
import '../domain/entities/location.dart';
import '../domain/entities/current_weather.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeViewModelProvider);

    return Scaffold(
      body: state.when(
        data: (weather) {
          final now = DateTime.now();
          final day = DateFormat.EEEE().format(now);
          final time = DateFormat.Hm().format(now);
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFDDE9F6), Colors.white],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'WEATHER',
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tokyo',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('$day $time'),
                    const SizedBox(height: 24),
                    const Icon(
                      Icons.wb_sunny_outlined,
                      size: 80,
                      color: Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${weather.temperature}°',
                      style: const TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('Sunny', style: TextStyle(fontSize: 20)),
                    const SizedBox(height: 32),
                    _HourlyForecastCard(weather.hourly),
                    const SizedBox(height: 24),
                    _DailyForecastCard(weather.daily),
                  ],
                ),
              ),
            ),
          );
        },
        loading: () {
          ref
              .read(homeViewModelProvider.notifier)
              .fetch(const Location(lat: 0, lon: 0));
          return const Center(child: CircularProgressIndicator());
        },
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class _HourlyForecastCard extends StatelessWidget {
  final List<HourlyForecast> forecasts;

  const _HourlyForecastCard(this.forecasts);

  @override
  Widget build(BuildContext context) {
    Widget buildItem(HourlyForecast forecast) {
      final time = DateFormat.Hm().format(forecast.time);
      final icon = (forecast.time.hour >= 18 || forecast.time.hour < 6)
          ? Icons.nightlight_round
          : Icons.wb_sunny;
      final temp = '${forecast.temperature.round()}°';
      return Column(
        children: [
          Text(time),
          const SizedBox(height: 8),
          Icon(icon, color: Colors.orange),
          const SizedBox(height: 8),
          Text(temp),
        ],
      );
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('HOURLY FORECAST'),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: forecasts.map(buildItem).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _DailyForecastCard extends StatelessWidget {
  final List<DailyForecast> forecasts;

  const _DailyForecastCard(this.forecasts);

  @override
  Widget build(BuildContext context) {
    Widget buildRow(DailyForecast forecast) {
      final day = DateFormat.E().format(forecast.date);
      final range =
          '${forecast.maxTemperature.round()}/${forecast.minTemperature.round()}°';
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(day),
            const Icon(Icons.wb_sunny, color: Colors.orange),
            Text(range),
          ],
        ),
      );
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('DAILY FORECAST'),
            const SizedBox(height: 8),
            ...forecasts.map(buildRow),
          ],
        ),
      ),
    );
  }
}
