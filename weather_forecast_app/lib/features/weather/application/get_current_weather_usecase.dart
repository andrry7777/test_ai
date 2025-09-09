import '../domain/entities/current_weather.dart';
import '../domain/entities/location.dart';
import '../domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  GetCurrentWeatherUseCase(this._repository);

  final WeatherRepository _repository;

  Future<CurrentWeather> execute(Location location) {
    return _repository.getCurrentWeather(location);
  }
}
