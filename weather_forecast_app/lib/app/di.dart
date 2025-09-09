import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/weather/application/get_current_weather_usecase.dart';
import '../features/weather/domain/repositories/weather_repository.dart';
import '../features/weather/infrastructure/weather_repository_impl.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  return WeatherRepositoryImpl();
});

final getCurrentWeatherUseCaseProvider = Provider<GetCurrentWeatherUseCase>((
  ref,
) {
  return GetCurrentWeatherUseCase(ref.watch(weatherRepositoryProvider));
});
