# Spiderchart

An awesome radar charts to make your app just awesome

![Radar chart flutter example](https://github.com/g-apparence/spiderchart/blob/master/example/assets/spiderchart.gif)

## Getting Started
Creating a SpiderChart is that easy
you can choose the color of the lines, radius of point. 
A SpiderChartValue is all the stats for the group you want to compare with your spider or radar graph. 

```dart
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
```

Enjoy
