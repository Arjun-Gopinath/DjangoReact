import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



void main() {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data;

  Widget GetArray(List<dynamic> strings){
    List<Widget> list = List<Widget>();
    for(var i = 0; i < strings.length; i++){
      list.add(Text(strings[i]));
    }
    return Column(children: list);
  }

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
  return "Yo";
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
              data != null ?
                  Column(children: [
                    GetArray(data['title']),
                    GetArray(data['text']),
                    GetArray(data['icon']),
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
                ],
              ),
            ),
    );
  }
}
