import 'package:flutter/material.dart';
class WeatherView extends StatelessWidget {
   WeatherView({super.key,
   required this.condition,
   required this.temp,
   required this.location
   });
   String condition;
   String temp;
   String location;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      // width: 100,
            padding: EdgeInsets.all(10),
            child: Container(
              color: Color.fromARGB(255, 225, 216, 213),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      ),
                    height: 150,
                    width: 150,
                    child:Image.network(location,fit: BoxFit.cover),
                    
                  ),
                  SizedBox(width: 50),
                  Column(
                    children: [
                      Text(condition,style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,             
                         ),),
                        const SizedBox(height: 30),
                         Text("$temp°C",style:const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                        ),),
                    ],
                   
                  ),
                ],
              ),
            ),
          );
  }
}