import 'package:dio/dio.dart';
import 'package:weather_forecast_app/shared/exceptions.dart';

import '../domain/entities/current_weather.dart';
import '../domain/entities/location.dart';
import '../domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  @override
  Future<CurrentWeather> getCurrentWeather(Location location) async {
    final response = await _dio.get(
      'https://api.open-meteo.com/v1/forecast',
      queryParameters: {
        'latitude': location.lat,
        'longitude': location.lon,
        'current_weather': true,
        'hourly': 'temperature_2m',
        'daily': 'temperature_2m_max,temperature_2m_min',
        'timezone': 'auto',
      },
    );
    final data = response.data;
    final current = data['current_weather'];
    if (current == null) {
      throw NetworkException('No current weather data');
    }
    final temperature = (current['temperature'] as num).toDouble();

    final hourlyData = data['hourly'] as Map<String, dynamic>?;
    final dailyData = data['daily'] as Map<String, dynamic>?;

    final List<HourlyForecast> hourly = [];
    if (hourlyData != null) {
      final times = (hourlyData['time'] as List).cast<String>();
      final temps = (hourlyData['temperature_2m'] as List).cast<num>();
      for (var i = 0; i < 4 && i < times.length; i++) {
        hourly.add(
          HourlyForecast(
            time: DateTime.parse(times[i]),
            temperature: temps[i].toDouble(),
          ),
        );
      }
    }

    final List<DailyForecast> daily = [];
    if (dailyData != null) {
      final times = (dailyData['time'] as List).cast<String>();
      final maxTemps = (dailyData['temperature_2m_max'] as List).cast<num>();
      final minTemps = (dailyData['temperature_2m_min'] as List).cast<num>();
      for (var i = 0; i < 3 && i < times.length; i++) {
        daily.add(
          DailyForecast(
            date: DateTime.parse(times[i]),
            maxTemperature: maxTemps[i].toDouble(),
            minTemperature: minTemps[i].toDouble(),
          ),
        );
      }
    }

    return CurrentWeather(
      temperature: temperature,
      hourly: hourly,
      daily: daily,
    );
  }
}
