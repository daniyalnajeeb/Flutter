import 'package:http/http.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

class WorldTime{

  Map days = {'0': 'Sunday', '1': 'Monday', '2': 'Tuesday', '3' : 'Wednesday', '4': 'Thursday', '5' : 'Friday', '6' : 'Saturday'};
  String location;
  String date;
  String day;
  String time;
  String flag;
  String url;
  bool isDaytime;

  WorldTime({this.location, this.flag, this.url});

  Future<void> getData() async {
    try {
      Response response = await get('https://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      String today = data['day_of_week'].toString();

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset.substring(0, 3))));

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;

      time = DateFormat.jm().format(now);
      date = DateFormat.yMMMd().format(now);
      day = days[today];

    }catch(e){
      print('An exception occured : $e');
      time = 'Can not get date and time';
    }

  }
}