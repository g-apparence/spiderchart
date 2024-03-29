import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:awesome_spiderchart/chart_painter.dart';
import 'package:awesome_spiderchart/spiderchart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spider radar chart demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  AnimationController _controller, _labelTouchController, _bottomBarController;
  Animation<double> _scaleAnim;
  Animation<double> _scaleChart;
  Animation<double> _scaleLabelAnim;
  Animation<double> _scaleBottomBar;
  int _activeIndex = -1;

  final Gradient bgGradient = new LinearGradient(
    colors: <Color>[
      Colors.blueGrey[500],
      Colors.blueGrey[800],
    ],
    begin: Alignment(1.0, -1.0),
    end: Alignment(-1.0, 1.0),
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: new Duration(milliseconds: 3000));
    _labelTouchController = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    _bottomBarController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    _scaleLabelAnim = new CurvedAnimation(parent: _labelTouchController, curve: Curves.ease);
    _scaleBottomBar = new CurvedAnimation(parent: _bottomBarController, curve: Curves.ease);
    _scaleAnim = new CurvedAnimation(parent: _controller, curve: Interval(0, .8, curve: Curves.elasticOut));
    _scaleChart = new CurvedAnimation(parent: _controller, curve: Interval(.7, 1, curve: Curves.easeInOutExpo));
    //_scaleLabelAnim.addListener(() => this.setState(() {}));

    Future.delayed(Duration(seconds: 1), () => _controller.forward());
  }

  @override
  Widget build(BuildContext context) {
    final Gradient gradient = new LinearGradient(
      colors: <Color>[
        Colors.lightGreenAccent[100].withOpacity(0.7),
        Colors.lightGreenAccent[700].withOpacity(0.7),
      ],
      begin: Alignment(1.0, -1.0),
      end: Alignment(-1.0, 1.0),
    );
    //---------------------------------------------------
    return Scaffold(
      appBar: AppBar(
        title: Text("Apparence.io - spider chart"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: bgGradient
//            color: Colors.blueGrey[800]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: AnimatedBuilder(
                animation: _scaleAnim,
                builder: (context, child) =>
                  Transform.rotate(
                    angle: -2 * pi * _scaleAnim.value,
                    child: Transform.scale(
                      scale: _scaleAnim.value,
                      child: _buildSpiderChartWidget(gradient),
                    ),
                  ),
                child: _buildSpiderChartWidget(gradient),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 64.0),
                child: Text(""),
              ),
            )
          ],
        ),
      ),
      bottomSheet: _buildDetailsExpandableCard(context),
    );
  }

  _buildSpiderChartWidget(Gradient gradient) {
    return SpiderChartWidget(
      lineColor: Colors.blueGrey[500],
      activeLabelColor: Colors.white,
      nbSides: 5,
      labels: [
        SpiderChartStatModel(roundSize: 4, label: "test 1"),
        SpiderChartStatModel(roundSize: 4, label: "test 2"),
        SpiderChartStatModel(roundSize: 4, label: "test 3"),
        SpiderChartStatModel(roundSize: 4, label: "test 4"),
        SpiderChartStatModel(roundSize: 4, label: "test 5"),
      ],
      activeLabel: _activeIndex,
      onTap: (index) {
        setState(() {
          _activeIndex = index;
        });
        _bottomBarController.reverse()
          .then((_) => _bottomBarController.forward());
      },
      valuesList: new List()
        ..add(new SpiderChartValue(
          [
            .5 * _scaleChart.value,
            .8 * _scaleChart.value,
            .9 * _scaleChart.value,
            .8 * _scaleChart.value,
            .9 * _scaleChart.value,
            .4 * _scaleChart.value,
            .4 * _scaleChart.value,
            .6 * _scaleChart.value,
          ],
          gradient: gradient,
          strokeColor: Colors.lightGreenAccent[200])
        ),
    );
  }

  _buildDetailsExpandableCard(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleBottomBar,
      builder: (context, child) => Container(
        height: _scaleBottomBar.value * 220,
        decoration: BoxDecoration(
//          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          color: Colors.blueGrey[200]
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Text("Lorem ipsum lorem ipsum",
                  style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 21
                  ),
                ),
              ),
              Flexible(
                child: Text("Lorem ipsum lorem ipsum lorem ipsum lorem ipsum " +
                  "lorem ipsum lorem ipsum lorem ipsum lorem ipsum " +
                  "lorem ipsum lorem ipsum lorem ipsum lorem ipsum",
                  style: TextStyle(
                    color: Colors.blueGrey[800],
                    fontWeight: FontWeight.normal,
                    fontSize: 16
                  )
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Colors.white, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(32))
                    ),
                    child: FlatButton(
                      onPressed: () => _bottomBarController.reverse(),
                      child: Text("Close", style: TextStyle(color: Colors.white),)
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


}
