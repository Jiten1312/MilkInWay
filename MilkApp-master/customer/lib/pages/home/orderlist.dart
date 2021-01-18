import 'package:customer/models/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customer/pages/home/ordertile.dart';

class OrderList extends StatefulWidget {
  DateTime selectedDate;
  String uid;
  OrderList({this.selectedDate, this.uid});

  @override
  _OrderListState createState() =>
      _OrderListState(selectedDate: selectedDate, uid: uid);
}

class _OrderListState extends State<OrderList> {
  DateTime selectedDate;
  String uid;
  _OrderListState({this.selectedDate, this.uid});

  @override
  Widget build(BuildContext context) {
    final List<Order> orders = Provider.of<List<Order>>(context);

    if (orders == null) {
      return Container(
        child: Text('No Orders'),
      );
    } else {
      return ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          if (orders[index] != null &&
              selectedDate.compareTo(orders[index].sdate) >= 0 &&
              selectedDate.compareTo(orders[index].edate) <= 0 &&
              orders[index].custId == uid) {
            return OrderTile(order: orders[index], selectedDate: selectedDate);
          } else {
            return Container(
            );
          }
        },
      );
    }
  }
}
