import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../application/get_current_weather_usecase.dart';
import '../../domain/entities/current_weather.dart';
import '../../domain/entities/location.dart';
import '../../../../app/di.dart';

class HomeViewModel extends StateNotifier<AsyncValue<CurrentWeather>> {
  HomeViewModel(this._useCase) : super(const AsyncValue.loading());

  final GetCurrentWeatherUseCase _useCase;

  Future<void> fetch(Location location) async {
    try {
      final weather = await _useCase.execute(location);
      state = AsyncValue.data(weather);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, AsyncValue<CurrentWeather>>((ref) {
      final useCase = ref.watch(getCurrentWeatherUseCaseProvider);
      return HomeViewModel(useCase);
    });
