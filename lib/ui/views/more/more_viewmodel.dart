import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_app/app/app.locator.dart';
import 'package:weather_app/app/app.logger.dart';

class MoreViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final log = getLogger('MoreViewModel');

  navigateBack() {
    _navigationService.back();
  }

  String getDayString(int day) {
    switch (day) {
      case 1:
        return 'Sunday';
      case 2:
        return 'Monday';
      case 3:
        return 'Tuesday';
      case 4:
        return 'Wednesday';
      case 5:
        return 'Thursday';
      case 6:
        return 'Friday';
      case 7:
        return 'Saturday';
      default:
        return 'Sunday';
    }
  }
}
