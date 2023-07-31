import 'dart:io';
import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:todo_app/widgets/drawer.dart';
import 'package:todo_app/widgets/todoContainer.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/ToDo.dart';

TextEditingController titleTextEditingController = TextEditingController();
TextEditingController descTextEditingController = TextEditingController();
// late String changeableTitle;
// late String changeableDesc;
// late bool changeableToggle;
const Color lightcolor=Color(0xffF2D3D1);
const Color deepcolor=Color(0xffBE7878);
 bool isloading= false;
 int done= 0;
 int incomplete=0;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

List<ToDo> myToDo= [];
Future<void> fetchData()async{
  try {
    http.Response response= await http.get(Uri.parse(api));
    var data= response.body.toString();
    var finaldata =await json.decode(data);
    print(finaldata.runtimeType);
   
    finaldata.forEach((Element){
      print(Element);
      ToDo t=ToDo(
       id: Element['id'],
       title: Element['title'].toString(),
       desc: Element['desc'],
       isDone: Element['isDone'],
       date: Element['date'],
       );
       if (Element['isDone']){
        done +=1;
       }
       print(t);
       myToDo.add(t);
    });
   setState(() {
     isloading= false;
   });
  } catch (e) {
    print('Error is $e');
  }
  print(myToDo);
}

Future<Map<String, dynamic>> addPost(Map jsonMap)async{
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(api));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print(reply);
     httpClient.close();
     Map<String, dynamic>map = json.decode(reply);
     return map;
    // http.Response response= await http.post(
    //   Uri.parse(api),
    //   headers: <String, String>{
    //     'Content-Type':'application/json; charset= UTF-8',
    //   },
    //   body: jsonEncode(<String, dynamic>{
    //     'title': title,
    //     'desc': desc,
    //     'isDone': false,
    //   })
    //  );
    //  if (response.statusCode == '201'){
    //   setState(() {
    //     myToDo.clear();
    //     fetchData();
    //   });
    //  } else{
    //   print('something went wrong');
    //  }
     
 
}

  void delete_ToDo(String id)async{
    try {
      print(id);
       http.Response response= await http.delete(Uri.parse(api + "/" +id));
       myToDo.clear();
      fetchData();
       setState(() {
        
       });
     print("done");
    } catch (e) {
      print("problem is $e");
    }
  }

  @override
  void initState() {
    
   fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: deepcolor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: lightcolor,),
        onPressed: () {
          showModalBottomSheet(context: context,
           builder: (BuildContext context){
            return Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              color: deepcolor,
              child:  Padding(
                padding: EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom:10.0),
                      child: Text('make a new ToDo',
                       style: TextStyle(color: Colors.white, fontSize: 26),),
                    ),
                     Text('add title:',
                     style: TextStyle(color: Colors.white, fontSize: 22),),
                     TextField(
                      controller: titleTextEditingController,
                      onChanged: (value) {
                        // changeableTitle= value;
                      },
                       decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle: TextStyle(color: Colors.white54),
                        enabledBorder:  UnderlineInputBorder(
                        borderSide:  BorderSide(color: Colors.white)),
                      ),     
                     ),
                     SizedBox(height: 10,),
                        Text('add describtion:',
                     style: TextStyle(color: Colors.white, fontSize: 22),),
                     TextField(
                      controller: descTextEditingController,
                      onChanged: (value) {
                        // changeableDesc= value;
                      },
                       decoration: InputDecoration(
                        hintText: 'Describtion',
                        hintStyle: TextStyle(color: Colors.white54),
                        enabledBorder:  UnderlineInputBorder(
                        borderSide:  BorderSide(color: Colors.white)),
                      ),     
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(vertical: 20),
                       child: ToggleSwitch(
                        minWidth: 100.0,
                        initialLabelIndex: 1,
                        cornerRadius: 20.0,
                        activeFgColor: Colors.black,
                        inactiveBgColor: Colors.white,
                        inactiveFgColor: Colors.black26,
                        totalSwitches: 2,
                        labels: ['complete', 'incomplete'],
                        activeBgColors: [[deepcolor], [deepcolor]],
                        onToggle: (index) {
                          // if (index == '0') {
                          //   changeableToggle= true;
                          // }else if(index == '1'){
                          //   changeableToggle= false;
                          // }
                          
                          print('switched to: $index');
                       },
                                         ),
                     ),
                     Padding(
                       padding: const EdgeInsets.symmetric(vertical: 10),
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                           ElevatedButton(
                            style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(20),
                            backgroundColor: lightcolor,
                            foregroundColor: deepcolor
                            ),
                              onPressed: (){
                            
                                final Map<String, dynamic> postMap={
                                  "title": titleTextEditingController.text,
                                  "desc": descTextEditingController.text,
                                  "isone": false,
                                };
                                // print(changeableTitle);
                                // print(changeableDesc);
                                // print(changeableToggle);
                                addPost(postMap);               
                            }, 
                            child: 
                            Icon(Icons.done)),
                          
                        ],
                       ),
                     )
                  ],
                ),
              ),
            );
           }
           );
        },),
      drawerScrimColor: const Color.fromARGB(61, 242, 211, 209),
      drawer: NavigationDrawer(
        backgroundColor:  lightcolor,
        children: [
         
          const Padding(
            padding: EdgeInsets.only(left:22, top: 38),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: deepcolor,
                ),
              ],
            ),
          ),
            const Padding(
            padding: EdgeInsets.only(left:22, top: 18),
            child: Row(
              children: [
               Text("Name",style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
           
              ],
            ),
          ),
           const Padding(
             padding: EdgeInsets.only(left:22, top: 58),
             child: Text("Your Progress:",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
           ),
           Padding(
             padding: const EdgeInsets.only(top:20.0,left: 22,),
             child: PieChart(
              chartType: ChartType.ring,
              chartRadius: MediaQuery.of(context).size.width / 3.2,
              dataMap: {
                "Done": done.toDouble(),
                "incomplete": (myToDo.length - done).toDouble(),
              },
              ringStrokeWidth: 15,
              animationDuration: const Duration(milliseconds: 800),
              colorList: [
                deepcolor,
                Colors.white
              ],
              ),
           )
        ],
        
      ),
      backgroundColor: lightcolor,
      appBar: AppBar(
        title: const Text('ToDo', style: TextStyle(color: Colors.white),),
        backgroundColor: deepcolor,
      ),
      body: isloading?
      Center(
        child: Container(
          height: 80,
          width: 80,
          child: const CircularProgressIndicator(
            color: deepcolor,
          )),
      ): 
      ListView(
        children:  myToDo.map((e) {
            return todoContainer(
              id: e.id, 
              title: e.title,
               desc: e.desc,
                date: e.date, 
                isDone: e.isDone,
                onPress :() => delete_ToDo(e.id.toString()),
                );
          }).toList()
        
      ),
    );
  }
}