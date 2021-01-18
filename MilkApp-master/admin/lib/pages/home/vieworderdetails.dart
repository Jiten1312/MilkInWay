import 'package:admin/models/customer.dart';
import 'package:admin/services/database/orderdatabase.dart';
import 'package:flutter/material.dart';
import 'package:admin/models/order.dart';
import 'package:admin/services/database/customerdatabase.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:admin/pages/home/cancelList.dart';
import 'package:admin/services/database/cancelorder.dart';
import 'package:admin/models/cancel.dart';

class ViewOrderDetails extends StatefulWidget {
  final Order order;
  ViewOrderDetails({this.order});
  @override
  _ViewOrderDetailsState createState() => _ViewOrderDetailsState(order: order);
}

class _ViewOrderDetailsState extends State<ViewOrderDetails> {
  final Order order;
  String status = "Order Not completed";
  _ViewOrderDetailsState({this.order});
  @override
  Widget build(BuildContext context) {
    if (order.completed == true) {
      status = "Order Completed";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('MilkInWay'),
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        children: <Widget>[
          Expanded(
              child: FutureBuilder(
                  future: viewCustomer(),
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
        child: Icon(Icons.done),
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Completed'),
                content: Text('This order will marked as completed'),
                actions: <Widget>[
                  MaterialButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  MaterialButton(
                      child: Text('Confirm'),
                      onPressed: () async {
                        await OrderDatabase().markCompleted(order.id);
                        setState(() => status = 'Order Completed');
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

  Future<Widget> viewCustomer() async {
    Customer customer = await CustomerDatabase().getCustomerById(order.custId);
    //Item item = await ItemDatabase().getItemById(order.itemId);
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Customer Name: ',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                  child: Text(
                customer.firstname + " " + customer.lastname,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              )),
              const Divider(
                  color: Colors.black,
                  height: 10,
                  thickness: 2,
                  indent: 0,
                  endIndent: 0),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'Contact number: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                  child: Text(
                customer.contact,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              )),
              Expanded(
                  child: IconButton(
                      icon: Icon(Icons.call),
                      onPressed: () async {
                        String url = "tel:+91" + customer.contact;
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      })),
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
                'Address',
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
                'House Number:\t',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                  child: Text(
                customer.houseNo,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              )),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'Landmark: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                  child: Text(
                customer.landmark,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              )),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'City: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                  child: Text(
                customer.city,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              )),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'Pincode: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                  child: Text(
                customer.pincode,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              )),
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'Country: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                  child: Text(
                customer.country,
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
                'Status: ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                  child: Text(
                status,
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
