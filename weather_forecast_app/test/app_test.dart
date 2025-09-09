import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:weather_forecast_app/app/app.dart';
import 'package:weather_forecast_app/app/di.dart';
import 'package:weather_forecast_app/features/weather/domain/entities/current_weather.dart';
import 'package:weather_forecast_app/features/weather/domain/entities/location.dart';
import 'package:weather_forecast_app/features/weather/domain/repositories/weather_repository.dart';

class FakeWeatherRepository implements WeatherRepository {
  @override
  Future<CurrentWeather> getCurrentWeather(Location location) async {
    return const CurrentWeather(temperature: 0);
  }
}

void main() {
  testWidgets('App builds', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          weatherRepositoryProvider.overrideWithValue(FakeWeatherRepository()),
        ],
        child: const App(),
      ),
    );
    expect(find.text('Weather'), findsOneWidget);
  });
}
