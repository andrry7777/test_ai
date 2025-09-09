import '../domain/entities/current_weather.dart';
import '../domain/entities/location.dart';
import '../domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  @override
  Future<CurrentWeather> getCurrentWeather(Location location) async {
    // TODO: implement actual API call
    return const CurrentWeather(temperature: 0);
  }
}
