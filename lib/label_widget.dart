import 'package:flutter/cupertino.dart';
import 'spiderchart.dart';
import 'label_painter.dart';

class LabelWidget extends StatelessWidget {
  final int index;
  final int nbSides;
  final Color lineColor;
  final bool drawCicle;
  final SpiderChartStatModel statModel;

  LabelWidget({
    this.index,
    this.nbSides,
    this.lineColor,
    this.drawCicle = false,
    this.statModel,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SpiderChartLabelDrawer(
        roundSize: statModel.roundSize + statModel.roundSize,
        lineColor: this.lineColor,
        sideIndex: index,
        label: statModel.label,
        nbSides: nbSides,
        drawCircle: drawCicle,
      ),
    );
  }
}
