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
import 'package:weather_app/utils/constants.dart';

class HomeViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _navigationService = locator<NavigationService>();
  final log = getLogger('HomeViewModel');
  final todaysDate = DateFormat('EEEE, MMMM d').format(DateTime.now());
  String city = '----';
  String country = '----';

  List<WeatherData> weatherDataList = [];

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
    _navigationService.navigateTo(Routes.moreView);
  }

  getWeatherIcon(String? weatherStatus) {
    switch (weatherStatus) {
      case 'Rain':
        return rainy;
      case 'Clouds':
        return cloudy;
      case 'Snow':
        return snowy;
      case 'Mist':
        return cloudy;
      default:
        return sunny;
    }
  }
}
