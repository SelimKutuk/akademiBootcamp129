import 'dart:ui';
import 'package:flutter/src/material/colors.dart';
import 'package:flutter/material.dart';
import 'final_vars.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';


class UsefulStuff {

  static Color getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');

    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }

    return Color(int.parse(hexColor, radix: 16));
  }

  static MaterialColor getMaterialColorFromHex(String hexColor) {

    Map<int, Color> color =
    {
      50:const Color.fromRGBO(136,14,79, .1),
      100:const Color.fromRGBO(136,14,79, .2),
      200:const Color.fromRGBO(136,14,79, .3),
      300:const Color.fromRGBO(136,14,79, .4),
      400:const Color.fromRGBO(136,14,79, .5),
      500:const Color.fromRGBO(136,14,79, .6),
      600:const Color.fromRGBO(136,14,79, .7),
      700:const Color.fromRGBO(136,14,79, .8),
      800:const Color.fromRGBO(136,14,79, .9),
      900:const Color.fromRGBO(136,14,79, 1),
    };

    hexColor = hexColor.toUpperCase().replaceAll('#', '');

    return MaterialColor(int.parse('0xFF' + hexColor), color);
  }


}

class CurvedBackgroundWithText extends StatelessWidget {
  final String text3;

  final String text2;

  final String text1;

  final double width;

  const CurvedBackgroundWithText({
    Key? key, required this.text3, required this.text2, required this.text1, required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ProsteThirdOrderBezierCurve(
          position: ClipPosition.bottom,
          list: [
            ThirdOrderBezierCurveSection(
              p1: Offset(0, (width/2)),
              p2: Offset(0, width),
              p3: Offset(MediaQuery.of(context).size.width, width/2),
              p4: Offset(MediaQuery.of(context).size.width, width),
            )
          ]
      ),
      child: Container(
        height: width,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                UsefulStuff.getColorFromHex("#3CD2CD"),
                UsefulStuff.getColorFromHex("#0F49AC"),
                UsefulStuff.getColorFromHex("#5012A1"),
              ]
          ),
        ),
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 60.0, left: (MediaQuery.of(context).size.width / 7)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text1, style: TextStyle(fontSize: 44, color: darkCultured),),
                Text(text2, style: TextStyle(fontSize: 44, color: darkCultured),),
                Text(text3, style: TextStyle(fontSize: 44, color: darkCultured))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
