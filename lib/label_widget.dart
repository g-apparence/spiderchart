import 'package:flutter/cupertino.dart';
import 'spiderchart.dart';
import 'label_painter.dart';

class LabelWidget extends StatelessWidget {

  int index;
  int nbSides;
  Color lineColor, activeLabelColor;
  SpiderChartStatModel statModel;

  LabelWidget({this.index, this.nbSides, this.lineColor, this.activeLabelColor, this.statModel});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SpiderChartLabelDrawer(
        roundSize: statModel.roundSize + statModel.roundSize,
        lineColor: this.lineColor,
        activeLabelColor: this.activeLabelColor,
        sideIndex: index,
        label: statModel.label,
        nbSides: nbSides,
      ),
    );
  }

}