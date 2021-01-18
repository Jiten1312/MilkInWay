import 'package:admin/models/item.dart';
import 'package:admin/pages/home/itemlist.dart';
import 'package:flutter/material.dart';
import 'package:admin/services/database/itemdatabase.dart';
import 'package:provider/provider.dart';

class Manage extends StatefulWidget {
  @override
  _Manage createState() => _Manage();
}

class _Manage extends State<Manage> {
  bool view = true;
  @override
  Widget build(BuildContext context) {
    if (view) {
      return viewItem();
    } else {
      return addItem();
    }
  }

  Widget viewItem() {
    return StreamProvider<List<Item>>.value(
      value: ItemDatabase().items,
      child: Column(
        children: <Widget>[
          SizedBox(
            child: Expanded(
              child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() => view = false);
                  }),
            ),
          ),
          Expanded(child: ItemList()),
        ],
      ),
    );
  }

  Widget addItem() {
    String _name;
    int _price, _quantity;
    final _itemForm = GlobalKey<FormState>();

    return Scaffold(
      body: Form(
        key: _itemForm,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() => view = true);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.layers), onPressed: null),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Please enter name';
                              }
                            },
                            onSaved: (input) {
                              setState(() => _name = input);
                            },
                            decoration: InputDecoration(hintText: 'Item Name'),
                          ))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.money_off), onPressed: null),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: TextFormField(
                            validator: (input) {
                              bool isValid = RegExp("[0-9]+").hasMatch(input);
                              if (!isValid) {
                                return 'Iteam should be integer';
                              }
                            },
                            onSaved: (input) {
                              setState(() => _price = int.parse(input));
                            },
                            decoration: InputDecoration(hintText: 'Item price'),
                          ))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.plus_one), onPressed: null),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: TextFormField(
                            validator: (input) {
                              bool isValid = RegExp("[0-9]+").hasMatch(input);
                              if (!isValid) {
                                return 'Quantity should be integer';
                              }
                            },
                            onSaved: (input) {
                              setState(() => _quantity = int.parse(input));
                            },
                            decoration:
                                InputDecoration(hintText: 'Avilable Quantity'),
                          ))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 60,
                  child: RaisedButton(
                    onPressed: () async {
                      if (_itemForm.currentState.validate()) {
                        _itemForm.currentState.save();
                        await ItemDatabase()
                            .updateItemData(_name, _price, _quantity);
                        setState(() => view = true);
                      }
                    },
                    color: Color(0xFF00a79B),
                    child: Text(
                      'Add Item',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
