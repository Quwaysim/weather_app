import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_app/app/app.locator.dart';
import 'package:weather_app/app/app.logger.dart';
import 'package:weather_app/app/app.router.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/services/api_service.dart';
import 'package:weather_app/utils/api_response_util.dart';

class HomeViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _navigationService = locator<NavigationService>();
  final log = getLogger('HomeViewModel');
  final todaysDate = DateFormat('EEEE, MMMM d').format(DateTime.now());
  final List<WeatherData> weatherDataList = [];
  final List<WeatherData> weatherDataListForToday = [];
  final List<WeatherData> weatherDataListForTomorrow = [];
  bool today = true;
  String city = '----';
  String country = '----';

  Future<void> init() async {
    log.i('init');
    LocationData? locationData = await getCurrentLocationData();

    if (locationData != null) {
      final response = await _apiService.getWeatherData(
          locationData.latitude!, locationData.longitude!);
      if (response is ApiResponse) {
        log.i('response: ${response.toString()}');
        if (response.statusCode == 200) {
          final weatherData = response.data;
          city = weatherData['city']['name'];
          country = weatherData['city']['country'];
          weatherData['list'].forEach(
            (element) {
              weatherDataList.add(WeatherData.fromJson(element));
            },
          );
          notifyListeners();
          getWeatherDataFor2Days();
        } else {
          log.wtf('response: ${response.toString()}');
        }
      } else {
        log.wtf('response is ${response.toString()}');
      }
    }
  }

  Future<LocationData?> getCurrentLocationData() async {
    final Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }
    log.d('serviceEnabled: $_serviceEnabled');

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    log.d('permissionGranted: $_permissionGranted');

    _locationData = await location.getLocation();
    log.d('locationData: ${_locationData.toString()}');
    return _locationData;
  }

  void navigateToMore() {
    _navigationService.navigateTo(
      Routes.moreView,
      arguments: MoreViewArguments(
        weatherData: getWeatherDataForEachDay(),
      ),
    );
  }

  List<WeatherData> getWeatherDataForEachDay() {
    List<WeatherData> weatherDataListForEachDay = [];
    if (weatherDataList.isNotEmpty) {
      //choose all weatherData that contains 09:00:00 and add to list
      for (var element in weatherDataList) {
        if (element.weatherDate.toString().contains('15:00:00')) {
          weatherDataListForEachDay.add(element);
        }
      }
    }
    log.d('weatherDataListForEachDay: $weatherDataListForEachDay');
    return weatherDataListForEachDay;
  }

  void getWeatherDataFor2Days() {
    if (weatherDataList.isNotEmpty) {
      DateTime today =
          DateFormat('yyyy-MM-dd').parse(DateTime.now().toString());
      for (var element in weatherDataList) {
        if (element.weatherDate!.day.compareTo(today.day) == 0) {
          weatherDataListForToday.add(element);
        } else if (element.weatherDate!.day.compareTo(today.day + 1) == 0) {
          weatherDataListForTomorrow.add(element);
        }
      }
      notifyListeners();
    }
  }

  void isToday(bool day) {
    today = day;
    notifyListeners();
  }
}
