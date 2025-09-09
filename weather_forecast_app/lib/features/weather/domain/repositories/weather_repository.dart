import '../entities/current_weather.dart';
import '../entities/location.dart';

abstract class WeatherRepository {
  Future<CurrentWeather> getCurrentWeather(Location location);
}
