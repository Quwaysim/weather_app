import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_app/app/app.locator.dart';

class MoreViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  navigateBack() {
    _navigationService.back();
  }
}
