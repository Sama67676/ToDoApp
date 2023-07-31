import 'package:flutter/material.dart';


class todoContainer extends StatelessWidget {
  final int id;
  final String title;
  final String desc;
  final bool isDone;
  final String date;
  final Function onPress;
  const todoContainer({super.key,
  required this.id,
  required this.title,
  required this.desc,
  required this.date,
  required this.isDone,
  required this.onPress,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color:  Color(0xffBE7878),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:16, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: TextStyle(
                    color: Colors.white,
                  fontSize: 26,
                  ),
                  ),
                  IconButton(onPressed: ()=> onPress(),
                   icon: Icon(Icons.delete_outline,
                  color: Colors.white,))
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.symmetric(horizontal:16, vertical: 5),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: 
                  Text(desc, style: TextStyle(
                    color: Colors.white,
                  fontSize: 20,
                  ),
                  ),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}