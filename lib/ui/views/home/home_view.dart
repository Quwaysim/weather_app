import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/ui/views/home/home_viewmodel.dart';
import 'package:weather_app/utils/utils.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.blue.shade600,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade900, Colors.blue.shade500],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Icon(Icons.menu, color: Colors.white),
                        ],
                      ),
                      Text(
                        '${model.city},',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        model.country,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        model.todaysDate,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'Today',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          model.weatherDataList.isEmpty
                              ? const SizedBox()
                              : getWeatherIcon(
                                  weatherStatus:
                                      model.weatherDataList[0].weatherStatus,
                                  big: true,
                                ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            model.weatherDataList.isEmpty
                                ? '-'
                                : '${model.weatherDataList[0].temp!.ceil()}°',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 60,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        model.weatherDataList.isEmpty
                            ? '-'
                            : '${model.weatherDataList[0].weatherDescription}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () => model.isToday(true),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Today',
                                style: TextStyle(
                                    color: model.today
                                        ? Colors.white
                                        : Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () => model.isToday(false),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Tomorrow',
                                style: TextStyle(
                                    color: model.today
                                        ? Colors.grey
                                        : Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: model.navigateToMore,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Next 5 Days',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DaysForecastContainer(
                        weatherDataList: model.today
                            ? model.weatherDataListForToday
                            : model.weatherDataListForTomorrow,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DaysForecastContainer extends StatelessWidget {
  final List<WeatherData> weatherDataList;
  const DaysForecastContainer({
    Key? key,
    required this.weatherDataList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(30),
        ),
        color: Colors.white24,
      ),
      //weather data in horizontal list
      child: SizedBox(
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: weatherDataList.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 10.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.blue,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18.0,
                  horizontal: 12.0,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      convertTo12HourFormat(weatherDataList[index].weatherDate),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const Spacer(),
                    getWeatherIcon(
                      weatherStatus: weatherDataList[index].weatherStatus,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    Text(
                      '${weatherDataList[index].temp!.ceil()}°',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
