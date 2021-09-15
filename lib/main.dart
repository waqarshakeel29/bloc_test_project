import 'package:bloc_test_project/pages/weather_search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/weather_bloc.dart';
import 'data/weather_repository.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      home: BlocProvider(
        create: (_) => WeatherBloc(FakeWeatherRepository()),
        child: const WeatherSearchPage(),
      ),
    );
  }
}
