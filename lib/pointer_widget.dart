import 'package:flutter/material.dart';
import 'offset_extension.dart';

class PointerWidget extends StatelessWidget {

  final int nbSides, sideIndex;
  final double radius;
  final Color color;
  final Gradient gradient;


  PointerWidget({
    this.nbSides, this.sideIndex, this.radius,
    this.color,
    this.gradient
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PointerDrawer(
        sideIndex: sideIndex,
        nbSides: nbSides,
        radius: radius,
        color: color,
        gradient: gradient
      ),
    );
  }

}



class PointerDrawer extends CustomPainter {

  final int nbSides, sideIndex;
  double radius;
  Color color;
  Gradient gradient;

  PointerDrawer({
    @required this.radius,
    @required this.color,
    this.gradient,
    this.nbSides,
    this.sideIndex
  });

  @override
  void paint(Canvas canvas, Size size) {
    var linePainter = Paint()
      ..style = PaintingStyle.stroke
      ..color = this.color
      ..strokeWidth = 2
      ..isAntiAlias = true;

    var paneSize = size.width / 2 - 32;
    var center = Offset(size.width / 2, size.height / 2);
    var labelCenter = center.rotate(paneSize, nbSides, sideIndex);
    canvas.translate(labelCenter.dx, labelCenter.dy);
    var gradientPainter = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..shader = gradient.createShader(Rect.fromCircle(center: Offset(0,0), radius: radius));
    canvas.drawCircle(Offset(0,0), radius, gradientPainter);
    canvas.drawCircle(Offset(0,0), radius, linePainter);
  }

  @override
  bool shouldRepaint(PointerDrawer oldDelegate) {
    return oldDelegate.radius != radius;
  }

  @override
  bool hitTest(Offset position) {
    return false;
  }

}