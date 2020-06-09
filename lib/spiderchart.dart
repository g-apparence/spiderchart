library spiderchart;

import 'package:flutter/material.dart';
import 'chart_painter.dart';
import 'dart:ui' as ui;
import 'label_widget.dart';
import 'pointer_widget.dart';

class SpiderChartStatModel {
  ui.Image image;
  double roundSize;
  Text label;

  SpiderChartStatModel({this.image, this.roundSize, this.label});
}

typedef OnTapLabel(int index);

class SpiderChartWidget extends StatefulWidget {
  final Color lineColor, activeLabelColor;
  final List<SpiderChartStatModel> labels;
  final List<SpiderChartValue> valuesList;
  final int nbSides;
  final OnTapLabel onTap;
  final int activeLabel;
  final PaintingStyle borderPaintingStyle;
  final double borderStrokeWidth;
  final Color borderOrFillColor;
  final bool drawSteps;

  SpiderChartWidget({
    Key key,
    this.lineColor,
    this.labels,
    this.valuesList,
    this.nbSides,
    this.onTap,
    this.activeLabel = -1,
    this.activeLabelColor,
    this.borderPaintingStyle = PaintingStyle.fill,
    this.borderStrokeWidth = 2,
    this.borderOrFillColor = const Color(0xfff1ece2),
    this.drawSteps = true,
  }) : super(key: key) {
    assert(
      nbSides <= labels.length,
      "a label for each side must be provided ($nbSides, ${labels.length})",
    );
  }

  @override
  _SpiderChartWidgetState createState() => _SpiderChartWidgetState();
}

class _SpiderChartWidgetState extends State<SpiderChartWidget> with SingleTickerProviderStateMixin {
  AnimationController _labelController;
  Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _labelController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _scaleAnim = CurvedAnimation(
      parent: _labelController,
      curve: Curves.easeInOut,
    );
    _labelController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var width = constraints.maxWidth;
        var height = constraints.maxHeight;
        return ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: width,
            minHeight: height,
            maxWidth: width,
            maxHeight: height,
          ),
          child: Stack(
            children: new List()
              ..add(buildChart())
              ..addAll(
                List.generate(
                  widget.nbSides,
                  (final int index) => _createLabel(index),
                ),
              ),
          ),
        );
      },
    );
  }

  Widget _createLabel(final int i) {
    return Positioned.fill(
      child: GestureDetector(
        key: ValueKey("tap$i"),
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap(i);
          }
        },
        child: AnimatedBuilder(
          animation: _scaleAnim,
          builder: (context, child) {
            if (widget.activeLabel == i)
              return PointerWidget(
                sideIndex: widget.activeLabel,
                nbSides: widget.nbSides,
                color: Colors.white,
                gradient: RadialGradient(
                  radius: .5,
                  colors: <Color>[
                    Colors.lightGreenAccent.withOpacity(0),
                    widget.activeLabelColor,
                  ],
                ),
                radius: widget.labels[i].roundSize * 4 + (widget.labels[i].roundSize * 2 * _scaleAnim.value),
              );
            else
              return child;
          },
          child: LabelWidget(
            index: i,
            lineColor: widget.lineColor,
            nbSides: widget.nbSides,
            statModel: widget.labels[i],
          ),
        ),
      ),
    );
  }

  Widget buildChart() {
    return Positioned.fill(
      child: CustomPaint(
        painter: SpiderChartDrawer(
          lineColor: widget.lineColor,
          valuesList: widget.valuesList,
          nbSides: widget.nbSides,
          borderPaintingStyle: widget.borderPaintingStyle,
          borderStrokeWidth: widget.borderStrokeWidth,
          borderOrFillColor: widget.borderOrFillColor,
          drawSteps: widget.drawSteps,
        ),
      ),
    );
  }
}
