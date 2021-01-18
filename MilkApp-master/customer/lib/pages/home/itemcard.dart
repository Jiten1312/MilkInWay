import 'package:customer/models/item.dart';
import 'package:customer/pages/home/subscribeitem.dart';
import 'package:flutter/material.dart';
import 'package:customer/services/database/itemdatabase.dart';

class ItemCard extends StatelessWidget{

  final Item item;
  ItemCard({this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.amberAccent,
          ),
          title: Text('${item.name}'),
          subtitle: Text('Price: ${item.price}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Subscribe(item: item)),
            );  
          } 
        ),
      ),
    );
    /*
    return Container(
      margin: EdgeInsets.only(right: 20.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              /*Image(
                image: AssetImage(imagePath),
                height: 65.0,
                width: 65.0,
              ),*/
              SizedBox(width: 20.0,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('${item.name}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                  Text('Price: ${item.price}   Quantity: ${item.quantity}'),
                ],
              )
            ],
          )
        ),
      ),
    );*/
  }
}