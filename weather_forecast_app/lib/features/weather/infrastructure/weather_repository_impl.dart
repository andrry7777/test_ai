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
      },
    );
    final data = response.data;
    final current = data['current_weather'];
    if (current == null) {
      throw NetworkException('No current weather data');
    }
    final temperature = (current['temperature'] as num).toDouble();
    return CurrentWeather(temperature: temperature);
  }
}
