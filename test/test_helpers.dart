@GenerateMocks([], customMocks: [
  // If we don't supply returnNullOnMissingStub then we'll get an exception when
  // a non-stubbed method is called.
  MockSpec<ApiService>(returnNullOnMissingStub: true),
  MockSpec<NavigationService>(returnNullOnMissingStub: true),
])

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:weather_app/app/app.locator.dart';
import 'package:weather_app/services/api_service.dart';

import 'test_helpers.mocks.dart';

NavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

ApiService getAndRegisterApiService() {
  _removeRegistrationIfExists<ApiService>();
  final service = MockApiService();
  when(service.getWeatherData(2.5, 150))
      .thenReturn(Future<dynamic>.value(isNotNull));
  locator.registerSingleton<ApiService>(service);
  return service;
}

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}

void registerServices() {
  getAndRegisterApiService();
  getAndRegisterNavigationService();
}

void unregisterService() {
  locator.unregister<ApiService>();
  locator.unregister<NavigationService>();
}
