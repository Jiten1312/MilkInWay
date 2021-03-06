import 'package:customer/models/order.dart';
import 'package:customer/pages/home/orderlist.dart';
import 'package:customer/services/database/subscribedatabase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderManage extends StatefulWidget {
  DateTime selectedDate;
  String uid;
  OrderManage({this.selectedDate,this.uid});

  @override
  _OrderManage createState() => _OrderManage(selectedDate: selectedDate, uid: uid);
}

class _OrderManage extends State<OrderManage> {
  DateTime selectedDate;
  String uid;
  _OrderManage({this.selectedDate,this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MilkInWay'),
        centerTitle: true,
      ),
      body: Container(
        child: StreamProvider<List<Order>>.value(
          value: OrderDatabase().orders,
          child: Column(
            children: <Widget>[
              Expanded(
                  child: OrderList(
                selectedDate: selectedDate, uid: uid
              )),
            ],
          ),
        ),
      ),
    );
  }
}
