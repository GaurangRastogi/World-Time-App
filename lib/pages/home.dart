import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data={};
  String bgImage="";
  @override
  Widget build(BuildContext context) {
    if(data.isEmpty) {
      try {
        data = ModalRoute
            .of(context)!
            .settings
            .arguments as Map;
        bgImage = (data['isDaytime'] == 0) ? 'day.png' : 'night.png';
      }
      catch (e) {
        data = {
          'location': 'Loading',
          'flag': 'Flag',
          'time': 'Loading',
          'isDaytime': 0
        };
        bgImage = 'day.png';
      }
    }
    Color? bgColor=(data['isDaytime']==0)?Colors.blue:Colors.indigo[700];
    return  Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child:Container(
            decoration:BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bgImage),
                fit:BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0,120,0,0),
              child: Column(
                children:[
                  TextButton.icon(
                      onPressed:() async{
                        dynamic result=await Navigator.pushNamed(context,'/location');
                        setState((){
                            data={
                              'time':result['time'],
                              'location':result['location'],
                              'isDaytime':result['isDaytime'],
                              'flag':result['flag'],
                            };
                            bgImage = (data['isDaytime'] == 0) ? 'day.png' : 'night.png';
                        });
                      },
                      icon:Icon(
                          Icons.edit_location,
                          color: Colors.grey[300],
                      ),
                      label:Text(
                          'Edit Locations',
                          style: TextStyle(
                            color:Colors.grey[300],
                          ),
                      ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['location'],
                        style:const TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    data['time'],
                    style:const TextStyle(
                      fontSize: 66.0,
                      color:Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
