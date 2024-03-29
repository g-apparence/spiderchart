import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'offset_extension.dart';

typedef PositionListener(Offset offset);

class SpiderChartLabelDrawer extends CustomPainter {

  final int nbSides, sideIndex;
  final double roundSize;
  final String label;
  final Color lineColor, activeLabelColor;
  final PositionListener positionListener;
  Offset labelCenter;


  SpiderChartLabelDrawer({
    this.label,
    @required this.nbSides,
    @required this.sideIndex,
    @required this.roundSize,
    @required this.lineColor,
    @required this.activeLabelColor,
    this.positionListener
  });

  @override
  void paint(Canvas canvas, Size size) {
    var linePainter = Paint()
      ..style = PaintingStyle.stroke
      ..color = this.lineColor
      ..strokeWidth = 2
      ..isAntiAlias = true;
    var paneSize = size.width / 2 - 32;
    var center = Offset(size.width / 2, size.height / 2);
    labelCenter = center.rotate(paneSize, nbSides, sideIndex);
    canvas.drawCircle(labelCenter, roundSize, linePainter);
    if(this.positionListener != null) {
      this.positionListener(labelCenter);
    }
    if(label != null) {
      var labelPainterCenter = center.rotate(paneSize + 4, nbSides, sideIndex);
      var textStyle = TextStyle(color: this.activeLabelColor);
      var textSpan = TextSpan(text: label, style: textStyle,);
      var textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr, textAlign: TextAlign.center);
      textPainter.layout();
      if(sin(sideIndex * 2 * pi / nbSides) > 0 ) {
        textPainter.paint(canvas, Offset(labelPainterCenter.dx - textPainter.width / 2, labelPainterCenter.dy + 16));
      } else {
        textPainter.paint(canvas, Offset(labelPainterCenter.dx - textPainter.width / 2, labelPainterCenter.dy - 32));
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  @override
  bool hitTest(Offset position) {
    if(labelCenter == null)
      return false;
    var distance = (position - labelCenter).distanceSquared;
    if(distance <= 256) {
      return true;
    }
    return false;
  }

}