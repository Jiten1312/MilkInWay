import 'package:admin/models/order.dart';
import 'package:admin/pages/home/orderlist.dart';
import 'package:admin/services/database/orderdatabase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget{
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home>{
  
  @override
  Widget build(BuildContext context){
    return StreamProvider<List<Order>>.value(
      value: OrderDatabase().orders,
      child: Column(
        children: <Widget> [
          Expanded(child: OrderList()),
        ],
      ),
    );   
  }
}
