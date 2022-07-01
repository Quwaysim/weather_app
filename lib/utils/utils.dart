import 'package:flutter/material.dart';
import 'package:weather_app/utils/constants.dart';

getWeatherIcon({String? weatherStatus, bool big = false, Color? color}) {
  if (big) {
    switch (weatherStatus) {
      case 'Rain':
        return rainy60;
      case 'Clouds':
        return cloudy60;
      case 'Snow':
        return snowy60;
      case 'Mist':
        return cloudy60;
      default:
        return sunny60;
    }
  }
  switch (weatherStatus) {
    case 'Rain':
      return rainy(color: color);
    case 'Clouds':
      return cloudy(color: color);
    case 'Snow':
      return snowy(color: color);
    case 'Mist':
      return cloudy(color: color);
    default:
      return sunny;
  }
}
