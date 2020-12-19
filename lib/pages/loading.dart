import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/services/world_time.dart';



class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async{
    WorldTime instance = WorldTime(location: 'Pakistan', flag: 'pakistan.png', url: 'Asia/Karachi');
    await instance.getData();
    Navigator.pushReplacementNamed(context, '/home', arguments: {
       'location' : instance.location,
        'URL': instance.url,
       'flag' : instance.flag,
       'time' : instance.time,
       'day'  : instance.day,
       'date' : instance.date,
       'isDaytime' : instance.isDaytime
    });
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
          child: SpinKitHourGlass(
            color: Colors.white,
            size: 80.0,
          ),
        ),
      );
  }
}
