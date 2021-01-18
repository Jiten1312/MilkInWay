import 'package:customer/models/cancel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CancelList extends StatefulWidget {

  String orderid, custid;
  CancelList({this.orderid, this.custid});

  @override
  _CancelListState createState() => _CancelListState(orderid: orderid, custid: custid);
}

class _CancelListState extends State<CancelList> {

  String orderid, custid;
  _CancelListState({this.orderid, this.custid});

  @override
  Widget build(BuildContext context) {
    final List<Cancel> cancelorder = Provider.of<List<Cancel>>(context);

    if(cancelorder == null)
    {
      return Container(
        child: Text('No cancelled orders'),
        );
    }
    else{
      return Container(
        height: 400.0,
        //width: 800.0,
        child: ListView.builder(
          //scrollDirection: Axis.horizontal,
          itemCount: cancelorder.length,
          // ignore: missing_return
          itemBuilder: (context, index){
            if (cancelorder[index] != null && cancelorder[index].orderId == orderid && cancelorder[index].custId == custid) {
              return Text(
                '${cancelorder[index].date.toString()}',
              );
            }
            else
              return Container();
          },
        ),
      );
    }
  }
}