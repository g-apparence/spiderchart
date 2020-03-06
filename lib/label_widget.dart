import 'package:flutter/cupertino.dart';
import 'package:spiderchart/label_painter.dart';
import 'package:spiderchart/spiderchart.dart';

class LabelWidget extends StatelessWidget {

  int index;
  int nbSides;
  Color lineColor;
  SpiderChartStatModel statModel;

  LabelWidget({this.index, this.nbSides, this.lineColor, this.statModel});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SpiderChartLabelDrawer(
        roundSize: statModel.roundSize + statModel.roundSize,
        lineColor: this.lineColor,
        sideIndex: index,
        label: statModel.label,
        nbSides: nbSides,
      ),
    );
  }

}