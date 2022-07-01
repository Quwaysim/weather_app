// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../models/weather_data.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/more/more_view.dart';

class Routes {
  static const String homeView = '/';
  static const String moreView = '/more-view';
  static const all = <String>{
    homeView,
    moreView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.moreView, page: MoreView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    MoreView: (data) {
      var args = data.getArgs<MoreViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => MoreView(
          key: args.key,
          weatherData: args.weatherData,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// MoreView arguments holder class
class MoreViewArguments {
  final Key? key;
  final List<WeatherData> weatherData;
  MoreViewArguments({this.key, required this.weatherData});
}
