import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = const MethodChannel('samples.flutter.dev/battery');

  String _batteryLevel = 'Unknown battery level';
  double _indicatorWidth=0;

  Future<void> _getBatteryLevel() async {
    String batteryLevel;

    int percentageBattery=0;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = ' $result % ';
      percentageBattery=result;

    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
      _indicatorWidth=(percentageBattery)*1.9;


    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation:5 , centerTitle: true, backgroundColor: Colors.black54,
        title: Text("My Battery", style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white, letterSpacing: 2),),
      ),
      backgroundColor: Color(0xff22264C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 200,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [

                    Container(
                      decoration: BoxDecoration(
                        border:Border.all(width: 5, color: Colors.white) ,
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xff22264C).withOpacity(0.2),
                      ),

                      height: 100,
                      width: 200,
                    ),
                    Positioned(
                      top: 5,
                      left: 5,

                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.green.withOpacity(0.8),
                        ),

                        height: 90,
                        width: _indicatorWidth,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                    color: Colors.white,
                  ),

                  height: 30,
                  width: 10,
                ),
              ],
            ),
            SizedBox(height: 20,),
            Text(_batteryLevel, style: TextStyle(fontSize: 28, color: Colors.lime),),
            SizedBox(height: 160,),
            SizedBox(
              height: 50,
              width: 130,
              child: RaisedButton(
                child: Text('Refresh', style: TextStyle(color: Colors.white, fontSize:18,letterSpacing: 1),),
                onPressed: _getBatteryLevel,
                color: Colors.teal,
              ),
            ),
            Expanded(child: Container()),
            Text("Made with ❤ by Auro ", style: TextStyle(color:Colors.white,fontSize: 18),),
            SizedBox(height: 20,)

          ],
        ),
      ),

    );
  }
}
