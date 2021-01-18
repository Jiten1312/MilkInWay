import 'package:admin/models/order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/pages/home/ordertile.dart';
import 'package:toggle_switch/toggle_switch.dart';

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  bool view = true;
  @override
  Widget build(BuildContext context) {
    if (view) {
      return showCompleted();
    } else {
      return showInCompleted();
    }
  }

  Widget showCompleted() {
    final List<Order> orders = Provider.of<List<Order>>(context);
    if (orders == null) {
      return Container(
        child: Text('No Orders'),
      );
    } else {
      return Container(
        child: Column(children: <Widget>[
          SizedBox(
            child: Expanded(
              child: RaisedButton(
                  child: Text('View In-completed Orders'),
                  onPressed: () {
                    setState(() => view = false);
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 15),
            child: Row(
              children: <Widget>[
                Text(
                  'Completed Orders',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                if (orders[index] != null) {
                  if (orders[index].completed == false) {
                    return Container();
                  }
                  return OrderTile(order: orders[index]);
                }
              },
            ),
          )
        ]),
      );
    }
  }

  Widget showInCompleted() {
    final List<Order> orders = Provider.of<List<Order>>(context);
    if (orders == null) {
      return Container(
        child: Text('No Orders'),
      );
    } else {
      return Container(
        child: Column(children: <Widget>[
          SizedBox(
            child: Expanded(
              child: RaisedButton(
                  child: Text('View Completed Orders'),
                  onPressed: () {
                    setState(() => view = true);
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 15),
            child: Row(
              children: <Widget>[
                Text(
                  'In-Completed Orders',
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                if (orders[index] != null) {
                  if (orders[index].completed == true) {
                    return Container();
                  }
                  return OrderTile(order: orders[index]);
                }
              },
            ),
          )
        ]),
      );
    }
  }
}
