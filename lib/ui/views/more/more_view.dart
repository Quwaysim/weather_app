import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:weather_app/ui/views/more/more_viewmodel.dart';

class MoreView extends StatelessWidget {
  const MoreView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MoreViewModel>.reactive(
      viewModelBuilder: () => MoreViewModel(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Container(),
        ),
      ),
    );
  }
}
