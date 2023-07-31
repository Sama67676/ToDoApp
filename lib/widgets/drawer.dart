import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
 class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 50,
      
      child: Column(
        children: [
           LinearPercentIndicator(
                width: 140.0,
                lineHeight: 14.0,
                percent: 0.5,
                backgroundColor: Colors.grey,
                progressColor: Colors.blue,
              ),
        ],
      ),
    );
  }
}