import 'package:flutter/material.dart';
import '../../../theme/mentor.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Statsdis extends StatelessWidget {
  final String taskname, profile;
  double advPercent, begPercent;

  Statsdis(this.taskname, double beg, double adv, this.profile) {
    this.advPercent = adv / 100;
    this.begPercent = beg / 100;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
         Text('${this.profile}',
            style: TextStyle(
                fontSize: 25,
                fontFamily: config.fontFamily,
                color: config.head)),
        SizedBox(
          height: 10,
        ),     
        Text('${this.taskname}',
            style: TextStyle(
                fontSize: 22,
                fontFamily: config.fontFamily,
                color: config.fontColor)),
        SizedBox(
          height: 10,
        ),
        Text('Adv Task Percentage',
            style: TextStyle(
                fontSize: 20,
                fontFamily: config.fontFamily,
                color: config.fontColor)),
        CircularPercentIndicator(
            radius: 100.0,
            center: Text('${this.advPercent * 100}%',
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: config.fontFamily,
                    color: config.fontColor)),
            lineWidth: 10.0,
            percent: (this.advPercent),
            progressColor: Colors.red,
            animation: true),
        SizedBox(
          height: 10,
        ),
        Text('Basic Task Percentage',
            style: TextStyle(
                fontSize: 20,
                fontFamily: config.fontFamily,
                color: config.fontColor)),
        CircularPercentIndicator(
            radius: 100.0,
            lineWidth: 10.0,
            center: Text('${this.begPercent * 100}%',
                style: TextStyle(
                    fontSize: 10,
                    fontFamily: config.fontFamily,
                    color: config.fontColor)),
            percent: (this.begPercent),
            progressColor: Colors.green,
            animation: true),
        SizedBox(
          height: 10,
        ),
        Divider(
          color: config.fontColor,
        )
      ],
    );
  }
}
