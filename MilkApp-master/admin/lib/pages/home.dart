import 'package:admin/services/auth.dart';
import 'package:flutter/material.dart';
import './home/HomePage.dart' as home;
import './home/ManagePage.dart' as manage;
import './home/calendar.dart' as calendar;

class MyTabs extends StatefulWidget{
  @override
  MyTabState createState() => new MyTabState();
}

class MyTabState extends State<MyTabs> with SingleTickerProviderStateMixin{

  TabController controller;
  final AuthService _auth = AuthService();

  @override
  void initState(){
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("MilkInWay"),
        actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
      ),
      bottomNavigationBar: new Material(
        color: Colors.teal,
        child: new TabBar(
          controller: controller,
          tabs: <Tab>[
            new Tab(icon: new Icon(Icons.home)),
            new Tab(icon: new Icon(Icons.date_range)),
            new Tab(icon: new Icon(Icons.launch)),
          ]
        )
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new home.Home(),
          new calendar.Calendar(),
          new manage.Manage(),
        ],
      )
    );
  }
}