// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/app/app.router.dart';
import 'package:weather_app/ui/views/home/home_viewmodel.dart';
import 'test_helpers.dart';

void main() {
  group('', () {
    setUp(() => registerServices());
    tearDown(() => unregisterService());

    group('', () {
      test('', () async {
        final navigationService = getAndRegisterNavigationService();
        var model = HomeViewModel();
        model.navigateToMore();
        verify(navigationService.navigateTo(Routes.moreView));
      });
    });
  });
}
