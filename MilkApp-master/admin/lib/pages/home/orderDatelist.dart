import 'package:admin/models/customer.dart';
import 'package:admin/models/order.dart';
import 'package:admin/services/database/cancelorder.dart';
import 'package:admin/services/database/customerdatabase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/pages/home/orderDatetile.dart';

class OrderList extends StatefulWidget {
  DateTime selectedDate;
  OrderList({this.selectedDate});

  @override
  _OrderListState createState() => _OrderListState(selectedDate: selectedDate);
}

class _OrderListState extends State<OrderList> {
  DateTime selectedDate;
  _OrderListState({this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final List<Order> orders = Provider.of<List<Order>>(context);

    if (orders == null) {
      return Container(
        child: Text('No Orders'),
      );
    } else {
      return Scaffold(
        body: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            if (orders[index] != null &&
                selectedDate.compareTo(orders[index].sdate) >= 0 &&
                selectedDate.compareTo(orders[index].edate) <= 0) {
              return OrderTile(
                  order: orders[index], selectedDate: selectedDate);
            } else {
              return Container();
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.cancel),
          onPressed: () async {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Cancel Order'),
                  content: Text(
                      'All the orders for $selectedDate will be cancelled'),
                  actions: <Widget>[
                    MaterialButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    MaterialButton(
                        child: Text('Confirm'),
                        onPressed: () async {
                          orders.forEach(
                            (order) async {
                              bool flag = await CancelDatabase()
                                  .check(order.custId, selectedDate);
                              print(flag);
                              if (flag == false) {
                              } else {
                                if (selectedDate.compareTo(order.sdate) >= 0 &&
                                    selectedDate.compareTo(order.edate) <= 0) {
                                  CancelDatabase().setCancelData(
                                      order.id,
                                      order.custId,
                                      selectedDate,
                                      order.itemName);
                                  Customer customer = await CustomerDatabase()
                                      .getCustomerById(order.custId);
                                  int refund =
                                      order.itemPrice * order.noOfItems +
                                          customer.wallet;
                                  CustomerDatabase()
                                      .updateWallet(order.custId, refund);
                                }
                              }
                            },
                          );
                          Navigator.of(context).pop();
                        }),
                  ],
                );
              },
            );
          },
        ),
      );
    }
  }
}
