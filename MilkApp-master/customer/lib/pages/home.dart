import 'package:customer/services/auth.dart';
import 'package:flutter/material.dart';
import './home/HomePage.dart' as home;
import './home/ManagePage.dart' as manage;
import './home/ContactPage.dart' as contact;
import './home/UserPage.dart' as user;

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
    controller = new TabController(length: 4, vsync: this);
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
        centerTitle: true,
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
            new Tab(icon: new Icon(Icons.contact_phone)),
            new Tab(icon: new Icon(Icons.person)),
          ]
        )
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new home.Home(),
          new manage.Manage(),
          new contact.Contact(),
          new user.userPage(),
        ],
      )
    );
  }
}