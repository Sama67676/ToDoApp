import 'package:flutter/material.dart';
import 'package:todo_app/HomePage.dart';


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
        child: Row(
          children: [
          
            Padding(
              padding: const EdgeInsets.only(left:20.0,),
              child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: lightcolor,
                 borderRadius: BorderRadius.circular(10),),
                 child: isDone?IconButton(
                  icon: const Icon(Icons.done, 
                  size: 15,
                  color: deepcolor  ,
                  ),
                  onPressed: () {
                   
                 },)
                 :IconButton(
                  icon: const Icon(Icons.close, 
                  size: 15,
                  color: deepcolor  ,
                  ),
                  onPressed: () {
                   
                 },),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:16, left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isDone?Text(title, style: const TextStyle(
                          color: Colors.white,
                         fontSize: 26,
                          decoration: TextDecoration.lineThrough,
                           decorationColor: lightcolor,
                           decorationStyle: TextDecorationStyle.solid,
                        ),
                        ):
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
                      
                        isDone?Text(desc, style: TextStyle(
                          color: Colors.white,
                        fontSize: 20,
                        decoration: TextDecoration.lineThrough,
                           decorationColor: lightcolor,
                           decorationStyle: TextDecorationStyle.solid,
                        ),
                        ):
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
          ],
        ),
      ),
    );
  }
}