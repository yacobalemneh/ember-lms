import 'package:ember/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample2 extends StatefulWidget {
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    kThemeOrangeFinal,
    kThemeBackGroundColor,
  ];


  //10, 12, 23, 23, 16, 23, 21, 16
  //stdD:4.8989794855664

//        Count, N:	8
//        Sum, Σx:	144
//    Mean, μ:	18
//    Variance, σ2: 	24
   List<double> x = [10, 12, 23, 23, 16, 23, 21, 16];
//  List<double> y = [0, 10, 15, 30, 35, 15, 10, 0];
  List<double> y = [0.09620261086480422, 0.09227653008789323, 0.07337792667810196, 0.07337792667810196, 0.08489850610874086, 0.07337792667810196, 0.0764999303675133, 0.08489850610874086];

//  List<double> x = [-1.1228070175438596, -0.5087719298245612, 2.298245614035088, -0.9473684210526314, -0.4210526315789472, 1.4210526315789478, -1.2105263157894737, 0.4561403508771933, 0.9824561403508776, -0.2456140350877191, -1.1228070175438596, -0.15789473684210503, 0.36842105263157926, 2.035087719298246, -0.33333333333333315, -0.07017543859649099, 0.5438596491228074, -0.5964912280701753, -0.9473684210526314, -0.4210526315789472];
////List<double> x = [ 3.33, 8.22, 13.11, 18, 22.89, 27.78, 32.67];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          
          AspectRatio(
            aspectRatio: 1.70,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                  color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
                child: LineChart(
                  mainData(),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
//      gridData: FlGridData(
//        //show: true,
//        //drawVerticalLine: true,
//        getDrawingHorizontalLine: (value) {
//          return FlLine(
//            color: const Color(0xff37434d),
//            strokeWidth: 1,
//          );
//        },
//        getDrawingVerticalLine: (value) {
//          return FlLine(
//            color: const Color(0xff37434d),
//            strokeWidth: 1,
//          );
//        },
//      ),

      borderData:
      FlBorderData(show: false, border: Border.all(color: kThemeOrangeFinal, width: 1),),
      minX: 10,
      maxX: 23,
      minY: 0,
      maxY: 0.1,


      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(x[0], y[0]),
            FlSpot(x[1], y[1]),
            FlSpot(x[2], y[2]),
            FlSpot(x[3], y[3]),
            FlSpot(x[4], y[4]),
            FlSpot(x[5], y[5]),
            FlSpot(x[6], y[6]),

          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

}