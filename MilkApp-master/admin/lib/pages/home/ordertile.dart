import 'package:admin/pages/home/vieworderdetails.dart';
import 'package:flutter/material.dart';
import 'package:admin/models/order.dart';

class OrderTile extends StatelessWidget {
  final Order order;
  OrderTile({this.order});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: const Icon(Icons.assignment),
          title: Text(order.sdate.day.toString()+"/"+order.sdate.month.toString()+"/"+order.sdate.year.toString()+" to "+order.edate.day.toString()+"/"+order.edate.month.toString()+"/"+order.edate.year.toString()),
          subtitle: Text(order.itemName),
          onTap: () async {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ViewOrderDetails(order: order)));
          },
        ),
      ),
    );
  }
}
