class HourlyForecast {
  final DateTime time;
  final double temperature;

  const HourlyForecast({required this.time, required this.temperature});
}

class DailyForecast {
  final DateTime date;
  final double minTemperature;
  final double maxTemperature;

  const DailyForecast({
    required this.date,
    required this.minTemperature,
    required this.maxTemperature,
  });
}

class CurrentWeather {
  final double temperature;
  final List<HourlyForecast> hourly;
  final List<DailyForecast> daily;

  const CurrentWeather({
    required this.temperature,
    required this.hourly,
    required this.daily,
  });
}
