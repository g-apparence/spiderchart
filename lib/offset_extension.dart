import 'dart:math';

import 'package:flutter/material.dart';

extension Rotations on Offset {

  Offset rotate(double radius, int nbSteps, int step) {
    return Offset(this.dx + radius * cos(step * 2 * pi / nbSteps), this.dy + radius * sin(step * 2 * pi / nbSteps));
  }

}