import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension ScreenSizeManager on WidgetTester {

  Future<void> setScreenSize({double width = 540, double height = 960, double pixelDensity = 1}) async {
    final size = Size(width, height);
    await this.binding.setSurfaceSize(size);
    this.binding.window.physicalSizeTestValue = size;
    this.binding.window.devicePixelRatioTestValue = pixelDensity;
  }

  // works for Iphone 11 max
  Future<void> setIphone11Max() => this.setScreenSize(width: 414, height: 896, pixelDensity: 3);

  // works for iphones size : 6+, 6s, 7+, 8+
  Future<void> setIphone8Plus() => this.setScreenSize(width: 414, height: 736, pixelDensity: 3);


}