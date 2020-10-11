import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data; // Json response is placed here
  bool pressed = false; // Show data

  MainAxisAlignment alignMain (String s){
    switch(s){
      case 'left':return MainAxisAlignment.start;
      case 'right':return MainAxisAlignment.end;
      default : return MainAxisAlignment.spaceEvenly;
    }
  }

  CrossAxisAlignment alignCross (String s){
    switch(s){
      case 'left':return CrossAxisAlignment.start;
      case 'right':return CrossAxisAlignment.end;
      default : return CrossAxisAlignment.stretch;
    }
  }

  // Display list of Icons
  Widget GetIcon(List<dynamic> strings, String color){
    String colored = color.replaceAll('#', '0xff'); // Hex code of colour
    List<Widget> list = List<Widget>();

    for(var i = 0; i < strings.length; i++){
      list.add(Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        child:Icon(
          FontAwesomeIcons.icons,
        ),
      ),
      );
    }
    return Container(
      color: Color(int.parse(colored)),
      child:Column(
        children:<Widget>[
          Row(
            mainAxisAlignment: alignMain(data['pos']),
            children:list ,
          ),
        ],
      ),
    );
  }

  // Display list of Titles or Texts
  Widget GetText(List<dynamic> strings, String color){
    String colored = color.replaceAll('#', '0xff'); // Hex code for colour
    List<Widget> list = List<Widget>();
    for(var i = 0; i < strings.length; i++){
      list.add(Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
          child:Text(
              strings[i]
          ),
        ),
      );
    }
    return Container(
      color: Color(int.parse(colored)),
      child:Column(
        children:<Widget>[
        Row(
          mainAxisAlignment: alignMain(data['pos']),
          children:list ,
        ),
      ],
    ),
    );
  }

  // Get Json Response

  Future<String> getData() async{
  var response = await http.get(
    Uri.encodeFull('http://10.0.2.2:8000/header/api/headers/1/'),
    headers: {
      "key":"^843@9fn#nk3tr#ril53u_3fv+3s(vptmmj(d7x40y^ins((gl",
      "Accept":"application/json",
    }
  );
  var get_data = json.decode(response.body);
  data = get_data;
  return "";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Hello"),
        ),
        body:Column(
            children:<Widget>[
              data != null && pressed ?
                  Column(
                    crossAxisAlignment: alignCross(data['pos']),
                    children: [
                    GetText(data['title'], data['colour']),
                    GetText(data['text'],data['colour']),
                    GetIcon(data['icon'],data['colour']),
                    Text("Colour = "  + data["colour"]),
                    Text("Menu Direction = " + data["pos"]),
                  ],
                  )
               : new Center(child: new CircularProgressIndicator()),
                  Container(
                      child: RaisedButton(
                        child: Text("Get Data"),
                        onPressed: getData,
                      )
                  ),
              Container(
                  child: RaisedButton(
                    child: Text("Show data"),
                    onPressed: (){
                      setState(() {
                        pressed = !pressed;
                      });
                    },
                  )
              ),
                ],
              ),
            ),
    );
  }
}
