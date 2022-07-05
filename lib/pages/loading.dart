import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatefulWidget {

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async{
    WorldTime instance=WorldTime(location: 'Kolkata', flag: 'india.png', url:'/Asia/Kolkata');
    await instance.getTime();
    Future.delayed(const Duration(seconds: 1),(){
      Navigator.pushReplacementNamed(context, '/home',arguments: {
        'location':instance.location,
        'flag':instance.flag,
        'time':instance.time,
        'isDaytime':instance.isDaytime
      });
    });
  }
  @override
  void initState(){
    super.initState();
    setupWorldTime();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blue,
      body:Center(
          child: SpinKitFadingCube(
            color: Colors.white,
            size: 80.0,
          ),
      ),
    );
  }
}
