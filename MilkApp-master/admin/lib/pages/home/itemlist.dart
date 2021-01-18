import 'package:admin/models/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin/pages/home/itemtile.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    final List<Item> items = Provider.of<List<Item>>(context);

    if (items == null) {
      return Container(
        child: Text('No Items'),
      );
    } else {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          if (items[index] != null) {
            return ItemTile(item: items[index]);
          }
        },
      );
    }
  }
}
