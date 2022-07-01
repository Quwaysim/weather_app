import 'package:intl/intl.dart';

class WeatherData {
  num? temp;
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
        temp: json['main']['temp'],
        weatherId: json['weather'][0]['id'],
        weatherStatus: json['weather'][0]['main'],
        weatherDescription: json['weather'][0]['description'],
        //convert to 24hr format
        weatherDate: DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['dt_txt']),
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
