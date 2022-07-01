import 'package:flutter/material.dart';

const apiUrl = 'https://api.openweathermap.org/data/2.5/forecast';

Color deepBlue = const Color.fromARGB(255, 4, 42, 100);

//Icons
sunny() => const Icon(
      Icons.wb_sunny_outlined,
      color: Colors.yellow,
    );

cloudy({Color? color = Colors.white}) => Icon(
      Icons.wb_cloudy_outlined,
      color: color,
    );

rainy({Color? color = Colors.white}) => Icon(
      Icons.water_drop_outlined,
      color: color,
    );

snowy({Color? color = Colors.white}) => Icon(
      Icons.snowing,
      color: color,
    );

const sunny60 = Icon(
  Icons.wb_sunny_outlined,
  color: Colors.yellow,
  size: 60,
);

const cloudy60 = Icon(
  Icons.wb_cloudy_outlined,
  color: Colors.white,
  size: 60,
);

const rainy60 = Icon(
  Icons.water_drop_outlined,
  color: Colors.white,
  size: 60,
);

const snowy60 = Icon(
  Icons.snowing,
  color: Colors.white,
  size: 60,
);
