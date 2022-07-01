import 'package:intl/intl.dart';

class WeatherData {
  double? temp;
  int? weatherId;
  String? weatherStatus;
  String? weatherDescription;
  DateTime? weatherDate;

  WeatherData({
    this.temp,
    this.weatherId,
    this.weatherStatus,
    this.weatherDescription,
    this.weatherDate,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        temp: json['main']['temp'] as double,
        weatherId: json['weather'][0]['id'] as int,
        weatherStatus: json['weather'][0]['main'] as String,
        weatherDescription: json['weather'][0]['description'] as String,
        //convert to 24hr format
        weatherDate: DateFormat('HH').parse(json['dt_txt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'weatherId': weatherId,
        'weatherStatus': weatherStatus,
        'weatherDescription': weatherDescription,
        'weatherDate':
            weatherDate != null ? weatherDate!.toIso8601String() : null,
      };
}
