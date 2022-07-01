import 'package:flutter/material.dart';

const apiUrl = 'https://api.openweathermap.org/data/2.5/forecast';
const String apiKey = '0f4828a754b8c9139a92634edb93bc12';

Color deepBlue = const Color.fromARGB(255, 4, 42, 100);

//Icons

const sunny = Icon(
  Icons.wb_sunny_outlined,
  color: Colors.yellow,
  size: 60,
);

const cloudy = Icon(
  Icons.wb_cloudy_outlined,
  color: Colors.white,
  size: 60,
);

const rainy = Icon(
  Icons.water_drop_outlined,
  color: Colors.white,
  size: 60,
);

const snowy = Icon(
  Icons.snowing,
  color: Colors.white,
  size: 60,
);
