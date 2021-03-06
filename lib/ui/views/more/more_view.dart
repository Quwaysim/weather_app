import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_app/models/weather_data.dart';
import 'package:weather_app/ui/views/more/more_viewmodel.dart';
import 'package:weather_app/utils/constants.dart';
import 'package:weather_app/utils/utils.dart';

class MoreView extends StatelessWidget {
  final List<WeatherData> weatherData;
  const MoreView({Key? key, required this.weatherData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoreViewModel>.nonReactive(
      viewModelBuilder: () => MoreViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: model.navigateBack,
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.grey,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Next 5 Days',
                  style: TextStyle(
                    fontSize: 24,
                    color: deepBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                for (var day in weatherData)
                  Padding(
                    padding: const EdgeInsets.only(top: 48.0, right: 40.0),
                    child: Row(
                      children: [
                        Text(
                          model.getDayString(day.weatherDate!.weekday),
                          style: TextStyle(
                            fontSize: 16,
                            color: deepBlue,
                          ),
                        ),
                        const Spacer(),
                        getWeatherIcon(
                          weatherStatus: day.weatherStatus,
                          color: deepBlue,
                        ),
                        const SizedBox(width: 40),
                        Text(
                          '${day.temp!.ceil()}??',
                          style: TextStyle(
                            fontSize: 16,
                            color: deepBlue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
