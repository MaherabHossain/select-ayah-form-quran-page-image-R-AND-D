

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:sqflite/sqflite.dart';
import 'package:yourtodo/quran_db.dart';
import 'package:flutter/painting.dart';


class TestPaint extends CustomPainter {
  late int numberOfLine;
  late var valueOfXandY;
  late int max_x;
  late int max_y;
  late int min_x;
  TestPaint(int numberOfLine, var valueOfXandY){
    this.numberOfLine = numberOfLine;
    this.valueOfXandY = valueOfXandY;

    log("Checking type");

    // this.max_x = valueOfXandY['max_x'];
    // this.max_y =valueOfXandY['max_y'];
    // this.min_x = valueOfXandY['min_x'];
    log("from constructor");
    log(numberOfLine.toString());
    log(this.valueOfXandY.toString());
  }
  @override
  void paint(Canvas canvas, Size size) {
    // Draw on the canvas here
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 30
      ..strokeCap = StrokeCap.round;





    //canvas.drawLine(Offset(max_x, max_y), Offset(min_x, max_y), paint);
    //    canvas.drawLine(const Offset(137.46031746031747, 577.3333333333334), Offset(20.952380952380953, 577.3333333333334), paint);
    // canvas.drawLine(const Offset(382.53968253968253, 621.0), Offset(20.317460317460316, 621.0), paint);
    // canvas.drawLine(const Offset(382.53968253968253, 666.6666666666666), Offset(19.365079365079367, 666.6666666666666), paint);





  }

  @override
  bool shouldRepaint(TestPaint oldDelegate) => false;
}
class MyCustomPainter extends CustomPainter {
  late int numberOfLine;
  late var valueOfXandY;
  late int max_x;
  late int max_y;
  late int min_x;
  MyCustomPainter(int numberOfLine, var valueOfXandY){
    this.numberOfLine = numberOfLine;
    this.valueOfXandY = valueOfXandY;

    log("Checking type");

    // this.max_x = valueOfXandY['max_x'];
    // this.max_y =valueOfXandY['max_y'];
    // this.min_x = valueOfXandY['min_x'];
    log("from constructor");
    log(numberOfLine.toString());
    log(this.valueOfXandY.toString());
  }

  @override
  void paint(Canvas canvas, Size size) {
// draw the image first

    // Draw on the canvas here
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 38
      ..strokeCap = StrokeCap.round;

    // canvas.drawLine(const Offset(100, 108), Offset(10, 0), paint);
    double max_x = 360;
    double min_x = 30;
    double max_y = 25;
    //canvas.drawLine(const Offset(382.53968253968253, 666.6666666666666), Offset(19.365079365079367, 666.6666666666666), paint);

    // canvas.drawLine(Offset(360, 25), Offset(200, 25), paint);
    // canvas.drawLine(Offset(max_x, max_y), Offset(min_x, max_y), paint);
    // canvas.drawLine(Offset(max_x,  max_y+35), Offset(min_x, max_y= max_y+30),paint);
    for (int i = 0; i < valueOfXandY.length; ++i) {
      //log(":::::::::::::::${i}::::::::::::::");
      // canvas.drawLine(Offset(max_x,  max_y+40), Offset(min_x, max_y= max_y+40),paint);
      double y = 4;
      double x = 4;
      double min_x = 3.60;
      canvas.drawLine( Offset(valueOfXandY[i]['max_x']/x, valueOfXandY[i]['max_y']/y), Offset(valueOfXandY[i]['min_x']/min_x, valueOfXandY[i]['max_y']/y), paint);

    //  print("${this.valueOfXandY[i]['max_x']/3.15} ${this.valueOfXandY[i]['max_y']/3} ${this.valueOfXandY[i]['min_x']/3.15} ${this.valueOfXandY[i]['max_y']/3} ");
        // canvas.drawLine(Offset(this.valueOfXandY[i]['max_x']/3.15, this.valueOfXandY[i]['max_y']/3 ), Offset(this.valueOfXandY[i]['min_x']/3.15, this.valueOfXandY[i]['max_y']/3),paint);
      // canvas.drawLine(Offset(max_x,  max_y+35), Offset(min_x, max_y= max_y+35), paint);
      //canvas.drawLine(const Offset(382.53968253968253, 666.6666666666666), Offset(19.365079365079367, 666.6666666666666), paint);

    }
  }
  // canvas.drawLine(const Offset(600, 108), Offset(10, 0), paint);

    // canvas.drawLine( Offset(365, 151), Offset(30, 151), paint);



    // canvas.drawLine(const Offset(600, 108), Offset(10, 0), paint);




  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) => false;
}

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
   CustomPainter? _customPainter;
   bool isCall = false;
   var xyValue = [];
   @override
  void initState() {
    // TODO: implement initState
     temp();
     _getData();
    super.initState();
  }

  void temp()async{
    var ayahInfo = await DbQuran.findLineOfAyah(8, 56);
    log("hii");
    xyValue = [];
    for(int i=ayahInfo['start_ayah'];i<=ayahInfo['end_ayah'];++i){
      log("not hii");
      var temp = await DbQuran.findXandYvalueOfAyah(8,56 ,i);
      xyValue.add(temp);
    }
    log(xyValue.toString());

    setState(() {
      isCall = !isCall;
    });
  }
   void _getData() async {
     try {
       await DbQuran.printTableData();
       // DbQuran.getPageData(8,49);
     } catch (e) {}
   }
  var xx,yy;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          xx += details.delta.dx;
          yy += details.delta.dy;
          print("x: $xx, y: $yy");
        });
      },
      onTapDown: (TapDownDetails details) async{
        // details.globalPosition;
        // Get the X and Y axis values of the tap
        double x = details.localPosition.dx;
        double y = details.localPosition.dy;
         var ayah = await DbQuran.findAyah(x*3, y*3);
         log("this is ayah");
         log("Ayah Number: ${ayah['ayah_number']}");
         var ayahInfo = await DbQuran.findLineOfAyah(8, ayah['ayah_number']);
         log("hii");
          xyValue = [];
         for(int i=ayahInfo['start_ayah'];i<=ayahInfo['end_ayah'];++i){
           log("not hii");
           var temp = await DbQuran.findXandYvalueOfAyah(8,ayah['ayah_number'] ,i);
           xyValue.add(temp);
         }
        log(xyValue.toString());

          setState(() {
             isCall = !isCall;
          });
      },
      child: CustomPaint(
        painter: isCall?MyCustomPainter(8,xyValue):TestPaint(8,xyValue),
        size: Size(400,1200),
        child: Image.asset('assets/page8.png',height: 700,width: 360,),
      ),

    );
  }

}
