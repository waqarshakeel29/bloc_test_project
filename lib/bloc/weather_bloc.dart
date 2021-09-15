import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_test_project/data/model/weather.dart';
import 'package:bloc_test_project/data/weather_repository.dart';
import 'package:equatable/equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository):super(WeatherInitial());



  @override
  WeatherState get initialState => WeatherInitial();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield const WeatherLoading();
    if (event is GetWeather) {
      try {
        final weather = await weatherRepository.fetchWeather(event.cityName);
        yield WeatherLoaded(weather);
      } on NetworkError {
        yield const WeatherError(
            "Couldn't fetch weather. Is the device online?");
      }
    } else if (event is GetDetailedWeather) {
      try {
        final weather =
            await weatherRepository.fetchDetailedWeather(event.cityName);
        yield WeatherLoaded(weather);
      } on NetworkError {
        yield const WeatherError(
            "Couldn't fetch weather. Is the device online?");
      }
    }
  }
}
