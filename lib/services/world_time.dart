import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class WorldTime{
  String location=""; //location name for the ui
  String time=""; //The time in that location
  String flag=""; //url to an asset flag icon
  String url="";  //url for an api end-point
  int isDaytime=0;
  WorldTime({required this.location,required this.flag,required this.url});
  Future<void> getTime() async{
    try {
      //make the request
      var urlid = Uri.parse("http://worldtimeapi.org/api/timezone/$url");
      var response = await http.get(urlid);
      Map data = jsonDecode(response.body);

      //print(data);

      //Get Properties From Data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      //print(datetime);
      //print(offset);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      //isDaytime=condtion? if_true:if_false ;
      isDaytime=now.hour >6 && now.hour<20 ? 0 :1;

      //Set the time property
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('Caught error: $e');
      time='Could not get time data';
    }
  }

}