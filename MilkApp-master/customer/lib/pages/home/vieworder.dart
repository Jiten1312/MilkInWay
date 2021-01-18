import 'package:customer/models/cancel.dart';
import 'package:customer/models/order.dart';
import 'package:customer/models/user.dart';
import 'package:customer/pages/home/cancelList.dart';
import 'package:customer/services/database/cancelorder.dart';
import 'package:customer/services/database/subscribedatabase.dart';
import 'package:customer/services/database/userdatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewOrder extends StatefulWidget {
  final Order order;
  DateTime selectedDate;
  ViewOrder({this.selectedDate, this.order});

  @override
  ViewOrderPage createState() =>
      ViewOrderPage(selectedDate: selectedDate, order: order);
}

class ViewOrderPage extends State<ViewOrder> {
  DateTime selectedDate;
  final Order order;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid;
  ViewOrderPage({this.selectedDate, this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MilkInWay'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        children: <Widget>[
          Expanded(
              child: FutureBuilder(
                  future: viewCustomer(selectedDate),
                  builder: (context, AsyncSnapshot<Widget> snapshot) {
                    Widget widget = Container();
                    if (snapshot.hasData) {
                      widget = snapshot.data;
                    }
                    return widget;
                  })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.cancel),
          onPressed: () async {
            bool flag = await CancelDatabase().check(order.custId, selectedDate);
            print(flag);
            if(flag == false)
              return null;
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Cancel Order'),
                  content: Text('Order cancellation for $selectedDate'),
                  actions: <Widget>[
                    MaterialButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    MaterialButton(
                        child: Text('Confirm'),
                        onPressed: () async {
                          CancelDatabase().setCancelData(order.id, order.custId,
                              selectedDate, order.itemName);
                          User user = await UserDatabase().getCustomerById(order.custId);
                          int refund = order.itemPrice*order.noOfItems + user.wallet;
                          UserDatabase().updateWallet(order.custId, refund); 
                          Navigator.of(context).pop();
                        }),
                  ],
                );
              },
            );
          }),
    );
  }

  Future<Widget> viewCustomer(DateTime date) async {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Selected Date:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                  child: Text(
                '$selectedDate',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              )),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'Item Ordered',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'Name: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                  child: Text(
                order.itemName,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              )),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'price: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                  child: Text(
                order.itemPrice.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              )),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'total Items: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                  child: Text(
                order.noOfItems.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              )),
            ],
          ),
          const Divider(
              color: Colors.black26,
              height: 10,
              thickness: 2,
              indent: 0,
              endIndent: 0),
          Row(
            children: <Widget>[
              Text(
                'total Amount Paid: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                  child: Text(
                order.amount.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              )),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'Subscription Duration: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                order.sdate.day.toString() +
                    "/" +
                    order.sdate.month.toString() +
                    "/" +
                    order.sdate.year.toString() +
                    " to " +
                    order.edate.day.toString() +
                    "/" +
                    order.edate.month.toString() +
                    "/" +
                    order.edate.year.toString(),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
          const Divider(
              color: Colors.black26,
              height: 10,
              thickness: 2,
              indent: 0,
              endIndent: 0),
          Row(
            children: <Widget>[
              Text(
                'Order cancellation for dates: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          viewCancelOrders(order.id, order.custId),
        ],
      ),
    );
  }

  Widget viewCancelOrders(String orderid, String custid) {
    return Container(
      child: StreamProvider<List<Cancel>>.value(
        value: CancelDatabase().cancelorder,
        child: CancelList(orderid: orderid, custid: custid),
      ),
    );
  }
}
