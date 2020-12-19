import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  List<WorldTime> location = [
    WorldTime(location: 'Pakistan', flag: 'pakistan.png', url: 'Asia/Karachi'),
    WorldTime(location: 'Germany', flag: 'pakistan.png', url: 'Europe/Berlin'),
    WorldTime(location: 'England', flag: 'pakistan.png', url: 'Europe/London'),
    WorldTime(location: 'Canada', flag: 'pakistan.png', url: 'America/Vancouver'),
    WorldTime(location: 'Chicago', flag: 'pakistan.png', url: 'America/Chicago'),
    WorldTime(location: 'United Arab Emirates', flag: 'pakistan.png', url: 'Asia/Dubai'),
  ];

  void updateTime(index) async {
    WorldTime instance = location[index];
    await instance.getData();
    Navigator.pop(context, {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Edit Location'),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: ListView.builder(
          itemCount: location.length,
          itemBuilder: (context, index){
            return Padding(
              padding: EdgeInsets.symmetric(horizontal : 1.0, vertical : 4.0),
              child: Card(
                child: ListTile(
                  onTap: (){
                    updateTime(index);
                  },
                  title: Text(location[index].location),
                ),
              ),
            );
          }
      ),
    );
  }
}
