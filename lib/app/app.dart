import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_app/ui/views/home/home_view.dart';
import 'package:weather_app/ui/views/more/more_view.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView, initial: true),
    MaterialRoute(page: MoreView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
  ],
)
class App {}
