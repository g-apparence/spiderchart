import 'package:flutter_test/flutter_test.dart';
import 'package:spiderchart/chart_painter.dart';

import 'package:spiderchart/spiderchart.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'screen_size_extension.dart';

void main() {
  group('spiderchart with 5 labels with gradient', () {

    final Gradient gradient = new LinearGradient(
      colors: <Color>[
        Colors.lightGreenAccent[100].withOpacity(0.7),
        Colors.lightGreenAccent[700].withOpacity(0.7),
      ],
      begin: Alignment(1.0, -1.0),
      end: Alignment(-1.0, 1.0),
    );


    SpiderChartWidget component = SpiderChartWidget(
      lineColor: Colors.blueGrey[500],
      activeLabelColor: Colors.blueGrey[50],
      nbSides: 5,
      labels: [
        SpiderChartStatModel(roundSize: 4, label: "test 1"),
        SpiderChartStatModel(roundSize: 4, label: "test 2"),
        SpiderChartStatModel(roundSize: 4, label: "test 3"),
        SpiderChartStatModel(roundSize: 4, label: "test 4"),
        SpiderChartStatModel(roundSize: 4, label: "test 5"),
      ],
      valuesList: new List()
        ..add(
          new SpiderChartValue(
            [ .5, .8, .9, .8, .9 ],
            gradient: gradient,
            strokeColor: Colors.lightGreenAccent[200]
          )
        ),
    );

    testWidgets('widgets exists', (WidgetTester tester) async {
      var app = new MediaQuery(data: MediaQueryData(), child: MaterialApp(
        home: Scaffold(
          body: component,
        )
      ));
      await tester.pumpWidget(app);
      expect(find.byType(component.runtimeType), findsOneWidget);
    });

    testWidgets('[IPHONE 11] widgets must have this exact design', (WidgetTester tester) async {
      await tester.setIphone11Max();
      // create widget
      var app = MaterialApp(home: Scaffold(body: component));
      await tester.pumpWidget(app);
      // create golden file
      await expectLater(find.byType(component.runtimeType), matchesGoldenFile("goldens/iphone11_5_labels_chart.png"));
    });

    testWidgets('[IPHONE 8 plus] widgets must have this exact design', (WidgetTester tester) async {
      await tester.setIphone8Plus();
      // create widget
      var app = MaterialApp(home: Scaffold(body: component));
      await tester.pumpWidget(app);
      // create golden file
      await expectLater(find.byType(component.runtimeType), matchesGoldenFile("goldens/iphone8Plus_5_labels_chart.png"));
    });

  });


  group('spiderchart with 7 labels with gradient', () {
    final Gradient gradient = new LinearGradient(
      colors: <Color>[
        Colors.lightGreenAccent[100].withOpacity(0.7),
        Colors.lightGreenAccent[700].withOpacity(0.7),
      ],
      begin: Alignment(1.0, -1.0),
      end: Alignment(-1.0, 1.0),
    );


    SpiderChartWidget component = SpiderChartWidget(
      lineColor: Colors.blueGrey[500],
      activeLabelColor: Colors.blueGrey[50],
      nbSides: 7,
      labels: [
        SpiderChartStatModel(roundSize: 4, label: "test 1"),
        SpiderChartStatModel(roundSize: 4, label: "test 2"),
        SpiderChartStatModel(roundSize: 4, label: "test 3"),
        SpiderChartStatModel(roundSize: 4, label: "test 4"),
        SpiderChartStatModel(roundSize: 4, label: "test 5"),
        SpiderChartStatModel(roundSize: 4, label: "test 6"),
        SpiderChartStatModel(roundSize: 4, label: "test 7"),
      ],
      valuesList: new List()
        ..add(
          new SpiderChartValue(
            [ .5, .8, .9, .8, .9, .1, .2 ],
            gradient: gradient,
            strokeColor: Colors.lightGreenAccent[200]
          )
        ),
    );

    testWidgets('widgets exists', (WidgetTester tester) async {
      var app = new MediaQuery(data: MediaQueryData(), child: MaterialApp(
        home: Scaffold(
          body: component,
        )
      ));
      await tester.pumpWidget(app);
      expect(find.byType(component.runtimeType), findsOneWidget);
    });

    testWidgets('[IPHONE 11] widgets must have this exact design', (WidgetTester tester) async {
      await tester.setIphone11Max();
      // create widget
      var app = MaterialApp(home: Scaffold(body: component));
      await tester.pumpWidget(app);
      // create golden file
      await expectLater(find.byType(component.runtimeType), matchesGoldenFile("goldens/iphone11_7_labels_chart.png"));
    });

    testWidgets('[IPHONE 8 plus] widgets must have this exact design', (WidgetTester tester) async {
      await tester.setIphone8Plus();
      // create widget
      var app = MaterialApp(home: Scaffold(body: component));
      await tester.pumpWidget(app);
      // create golden file
      await expectLater(find.byType(component.runtimeType), matchesGoldenFile("goldens/iphone8Plus_7_labels_chart.png"));
    });

  });


  group('check bad configurations', () {

    testWidgets('creating a widget with less label than sides throws', (WidgetTester tester) async {
      final Gradient gradient = new LinearGradient(
        colors: <Color>[
          Colors.lightGreenAccent[100].withOpacity(0.7),
          Colors.lightGreenAccent[700].withOpacity(0.7),
        ],
      );
      var exception;
      try {
        SpiderChartWidget component = SpiderChartWidget(
          lineColor: Colors.blueGrey[500],
          activeLabelColor: Colors.blueGrey[50],
          nbSides: 12,
          labels: [
            SpiderChartStatModel(roundSize: 4, label: "test 1"),
            SpiderChartStatModel(roundSize: 4, label: "test 2"),
            SpiderChartStatModel(roundSize: 4, label: "test 3"),
            SpiderChartStatModel(roundSize: 4, label: "test 4"),
            SpiderChartStatModel(roundSize: 4, label: "test 5"),
            SpiderChartStatModel(roundSize: 4, label: "test 6"),
            SpiderChartStatModel(roundSize: 4, label: "test 7"),
          ],
          valuesList: new List()
            ..add(
              new SpiderChartValue(
                [ .5, .8, .9, .8, .9, .1, .2 ],
                gradient: gradient,
                strokeColor: Colors.lightGreenAccent[200]
              )
            ),
        );
        var app = MaterialApp(home: Scaffold(body: component));
        await tester.pumpWidget(app);
      } catch (e) {
        exception = e;
      }
      expect(exception , isNotNull);
    });

  });
}

