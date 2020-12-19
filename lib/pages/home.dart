import 'dart:async';

import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  Timer timer;

 void updateTimer() async {
   WorldTime instance = WorldTime(location: data['location'], flag: data['flag'], url: data['URL']);
   print(instance.url);
   await instance.getData();
   setState(() {
     data = {
        'location' : instance.location,
        'URL': instance.url,
        'flag' : instance.flag,
        'time' : instance.time,
        'day'  : instance.day,
        'date' : instance.date,
        'isDaytime' : instance.isDaytime
     };
   });
 }

  @override
  Widget build(BuildContext context) {
    timer = Timer.periodic(Duration(seconds: 30), (Timer t) => updateTimer());
    print(data);
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;




    Color bgImage = data['isDaytime'] ? Colors.yellow[200] : Colors.indigo[900];
    Color txtColor = data['isDaytime'] ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: bgImage,
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
            child: Column(
              children: [
                FlatButton.icon(
                  onPressed: () async{
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'location' : result['location'],
                        'flag' : result['flag'],
                        'time' : result['time'],
                        'day'  : result['day'],
                        'date' : result['date'],
                        'isDaytime' : result['isDaytime'],
                        'URL': result['URL'],
                      };
                    });
                  },
                  icon: Icon(
                      Icons.edit_location,
                      color: txtColor,
                  ),
                  label: Text(
                      'Edit Location',
                      style: TextStyle(
                        color: txtColor,
                        letterSpacing: 2.0
                      ),
                  ),
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        data['location'],
                        style: TextStyle(
                          color: txtColor,
                          fontSize: 20.0,
                          letterSpacing: 2.0
                        )
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Text(
                    data['time'],
                    style: TextStyle(
                      color: txtColor,
                        fontSize: 60.0,
                        letterSpacing: 2.0
                    )
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        data['date'],
                        style: TextStyle(
                            color: txtColor,
                            fontSize: 20.0,
                            letterSpacing: 2.0
                        )
                    ),
                    SizedBox(width: 20.0,),
                    Text(
                        data['day'],
                        style: TextStyle(
                            color: txtColor,
                            fontSize: 20.0,
                            letterSpacing: 2.0
                        )
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
