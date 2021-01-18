import 'package:customer/models/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:customer/pages/home/itemcard.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    final List<Item> items = Provider.of<List<Item>>(context);

    if(items == null)
    {
      return Container(
        child: Text('No Item'),
        );
    }
    else{
      return Container(
        height: 400.0,
        //width: 800.0,
        child: ListView.builder(
          //scrollDirection: Axis.horizontal,
          itemCount: items.length,
          // ignore: missing_return
          itemBuilder: (context, index){
            if (items[index] != null) {
              return ItemCard(
                item: items[index],
              );
            }
          },
        ),
      );
    }
  }
}
/*
class ProductCategory extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    final items = Provider.of<List<Item>>(context);
    return Container(
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index){
          return ProductCard(
            productName: items[index].name,
            //imagePath: items[index].imagePath,
            productPrice: items[index].price,
            productQuantity: items[index].quantity,
          );
        },
      ),
    );
  }
}*/