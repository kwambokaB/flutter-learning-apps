import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime{
  String location;
  String time = "";
  String flag;
  String url;
  bool isDaytime = true;

  WorldTime({required this.flag, required this.location, required this.url});
  
  Future<void> getTime() async {
    try {
      Response res = await get(
          Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(res.body);

      String datetime = data['datetime'];
      String offset1 = data['utc_offset'].substring(1, 3);
      String offset2 = data['utc_offset'].substring(4, 6);


      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset1)));

      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('call error: $e');
      time = "could not get time data";
    }
  }

}

