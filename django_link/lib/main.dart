import 'dart:async';
import 'dart:ui';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
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
  File jsonF; // File storage
  Directory dir; // location of file
  String filename = "Data.json"; // name of file
  bool fileExists = false; // existance of file
  Map<int, Color> colors =
  {
    50:Color.fromRGBO(136,14,79, .1),
    100:Color.fromRGBO(136,14,79, .2),
    200:Color.fromRGBO(136,14,79, .3),
    300:Color.fromRGBO(136,14,79, .4),
    400:Color.fromRGBO(136,14,79, .5),
    500:Color.fromRGBO(136,14,79, .6),
    600:Color.fromRGBO(136,14,79, .7),
    700:Color.fromRGBO(136,14,79, .8),
    800:Color.fromRGBO(136,14,79, .9),
    900:Color.fromRGBO(136,14,79, 1),
  };

  @override
  void initState() {
    super.initState();
    getApplicationDocumentsDirectory().then((Directory directory) {
      dir = directory;
      jsonF = new File(dir.path + "/" + filename);
      fileExists = jsonF.existsSync();
      if (fileExists) this.setState(() =>
      data = json.decode(jsonF.readAsStringSync()));
    });
  }

  // Creating json file
  void createFile(Map<String, dynamic> content, Directory dir, String fileName) {
      print("Creating file!");
      File file = new File(dir.path + "/" + fileName);
      file.create().then((value) => fileExists = true);
      file.writeAsStringSync(json.encode(content));
  }

  // Writing to json file
  void writeFile(Map<String, dynamic> content){
    print("Writing File");
      if (fileExists) {
        print("File exists");
        var jsonFileContent = json.decode(jsonF.readAsStringSync());
        jsonFileContent.addAll(content);
        jsonF.writeAsStringSync(json.encode(jsonFileContent));
      } else {
        print("File does not exist!");
        createFile(content, dir, filename);
      }
      this.setState(() => data = json.decode(jsonF.readAsStringSync()));
    }

    // Colour from hex to RGB
  MaterialColor getColor(String color){
      int colored = int.parse(color.replaceAll('#', '0xff')); // Hex code for colour
      MaterialColor colorCustom = MaterialColor(colored, colors);
    return colorCustom;
  }

  // Title conversion
  String setTitle(){
    String titles = "";
    for(var i = 0;i<data['title'].length;i++){
      titles += data['title'][i];
      if (i!=data['title'].length - 1) titles += " / ";
    }
    return titles;
  }
  
  // Get Json Response
  void getData() async{
    var response = await http.get(
      Uri.encodeFull('http://10.0.2.2:8000/header/api/headers/1/'),
      headers: {
        "key":"^843@9fn#nk3tr#ril53u_3fv+3s(vptmmj(d7x40y^ins((gl",
        "Accept":"application/json",
      }
    );
    writeFile(json.decode(response.body));
  }

  List<PopupMenuEntry> popUp(){
    List<PopupMenuEntry> lis = [];
    for(var i = 0;i<data['text'].length;i++){
      lis.add(PopupMenuItem(
        value: i,
        child: Text(data['text'][i]),
      )
      );
    }
    return lis;
  }


  ListView sideDrawer(){
    List<Widget> list = [];
    for(var i = 0;i<data['text'].length;i++) {
      list.add(ListTile(title: Text(data['text'][i]),));
    }
    return ListView(children: list);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: data != null ? getColor(data['colour']): Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: data != null ? Text(setTitle()):Text("NO DATA IN JSON"),
        ),
        drawer: Drawer(
            child: sideDrawer()
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: RaisedButton(
                  child: Text('Get new data'),
                  onPressed: () {
                    setState(() {
                      getData();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
