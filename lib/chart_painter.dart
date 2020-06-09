import 'dart:math';
import 'package:flutter/material.dart';

class SpiderChartValue {
  /// [O..1] percentage of line
  List<double> values;
  Color bgColor, strokeColor;
  final Gradient gradient;
  SpiderChartValue(
    this.values, {
    this.bgColor,
    this.strokeColor,
    this.gradient,
  });
}

class SpiderChartDrawer extends CustomPainter {
  final Color lineColor;
  final Color activeBgColor = Colors.lightGreenAccent[200];
  final int nbSides;
  final List<SpiderChartValue> valuesList;
  final bool drawSteps;
  final PaintingStyle borderPaintingStyle;
  final double borderStrokeWidth;
  final Color borderOrFillColor;

  SpiderChartDrawer({
    this.lineColor,
    this.nbSides = 8,
    this.valuesList,
    this.drawSteps = true,
    this.borderPaintingStyle = PaintingStyle.stroke,
    this.borderStrokeWidth,
    this.borderOrFillColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var linePainter = Paint()
      ..style = PaintingStyle.stroke
      ..color = this.lineColor
      ..strokeWidth = 2
      ..isAntiAlias = true;

    var borderPainter = Paint()
      ..style = borderPaintingStyle
      ..color = Color(0xfff1ece2)
      ..strokeWidth = 2
      ..isAntiAlias = true;
    // draw spider
    var center = Offset(size.width / 2, size.height / 2);
    var paneSize = size.width / 2 - 44;
    canvas.drawCircle(center, 2, linePainter);
    var points = _drawPentagon(center, paneSize, canvas, borderPainter);
    var step = paneSize / 6;
    if (drawSteps) {
      for (int i = 1; i < 6; i++) {
        _drawPentagon(center, i * step, canvas, linePainter);
      }
    }
    //_drawLabels(center, paneSize, canvas, linePainter);
    canvas.drawCircle(center, 2, linePainter);
    points.forEach((point) => canvas.drawLine(point, center, linePainter));

    // draw values
    valuesList.forEach((el) => _drawValues(center, size, paneSize, el, canvas));
  }

  _drawValues(
    Offset center,
    Size size,
    double paneSize,
    SpiderChartValue model,
    Canvas canvas,
  ) {
    int i = 0;
    var previousPoint;
    canvas.save();
    List<Offset> points = List();
    var activeStrokePainter = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..color = model?.strokeColor ?? activeBgColor
      ..isAntiAlias = true;
    var path = Path();
    do {
      assert(
        model.values[i] <= 1.0 && model.values[i] >= 0,
        "value must between 0 and 1",
      );
      var value = model.values[i] * paneSize;
      var dx = center.dx + value * cos(i * 2 * pi / nbSides);
      var dy = center.dy + value * sin(i * 2 * pi / nbSides);
      if (previousPoint != null) {
        path.lineTo(dx, dy);
      } else {
        path.moveTo(dx, dy);
      }
      points.add(Offset(dx, dy));
      previousPoint = Offset(dx, dy);
      i++;
    } while (i < nbSides);
    path.lineTo(points[0].dx, points[0].dy);
    var activePainter;
    if (model.gradient != null) {
      activePainter = Paint()
        ..style = PaintingStyle.fill
        ..isAntiAlias = true
        ..shader = model.gradient.createShader(
          Rect.fromLTWH(0, 0, size.width, size.height),
        );
    } else {
      activePainter = Paint()
        ..style = PaintingStyle.fill
        ..color = model?.bgColor?.withOpacity(.75) ??
            activeBgColor.withOpacity(
              .75,
            )
        ..isAntiAlias = true;
    }
    canvas.drawPath(path, activePainter);
    canvas.drawPath(path, activeStrokePainter);
    canvas.restore();
  }

  List<Offset> _drawPentagon(
    Offset center,
    double paneSize,
    Canvas canvas,
    Paint bgPainter,
  ) {
    int i = 0;
    var previousPoint;
    canvas.save();
    List<Offset> points = List();
    var path = Path();
    do {
      var dx = center.dx + paneSize * cos(i * 2 * pi / nbSides);
      var dy = center.dy + paneSize * sin(i * 2 * pi / nbSides);
      if (previousPoint != null) {
        path.lineTo(dx, dy);
      } else {
        path.moveTo(dx, dy);
      }
      points.add(Offset(dx, dy));
      previousPoint = Offset(dx, dy);
      i++;
    } while (i <= nbSides);
    canvas.drawPath(path, bgPainter);
    canvas.restore();
    return points;
  }

  @override
  bool shouldRepaint(SpiderChartDrawer oldDelegate) {
    return false;
  }

  @override
  bool hitTest(Offset position) {
    return false;
  }
}
