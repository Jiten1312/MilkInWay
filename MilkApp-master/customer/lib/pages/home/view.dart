import 'package:customer/pages/home.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'ManagePage.dart';

class View extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:'MilkInWay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: 'Home',
      routes:{
        'Home':(context)=>MyTabs(),
        'Manage':(context)=>Manage(),
      },
    );
  }
}