import 'package:flutter/material.dart';
import 'package:admin/models/item.dart';
import 'package:admin/services/database/itemdatabase.dart';

class ItemTile extends StatelessWidget {
  final Item item;
  ItemTile({this.item});
  String _name;
  int _price, _quantity;
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
          subtitle: Text('Price: ${item.price}   Quantity: ${item.quantity}'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Delete?'),
                      content: Text('Item will be deleted'),
                      actions: <Widget>[
                        MaterialButton(
                            child: Text('Cancel'),
                            onPressed: () async {
                              Navigator.of(context).pop();
                            }),
                        MaterialButton(
                            child: Text('Delete'),
                            onPressed: () async {
                              await ItemDatabase().deleteitemData(item.id);
                              Navigator.of(context).pop();
                            })
                      ],
                    );
                  });
            },
          ),
          onTap: () {
            final _itemForm = GlobalKey<FormState>();
            return showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Form(
                      key: _itemForm,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.layers), onPressed: null),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            right: 20, left: 10),
                                        child: TextFormField(
                                          validator: (input) {
                                            if (input.isEmpty) {
                                              return 'Name is empty';
                                            }
                                          },
                                          onSaved: (input) {
                                            this._name = input;
                                          },
                                          initialValue: item.name,
                                        ))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.money_off), onPressed: null),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            right: 20, left: 10),
                                        child: TextFormField(
                                          validator: (input) {
                                            bool isValid = RegExp("[0-9]+")
                                                .hasMatch(input);
                                            if (!isValid) {
                                              return 'Price should be integer';
                                            }
                                          },
                                          onSaved: (input) {
                                            this._price = int.parse(input);
                                          },
                                          initialValue: item.price.toString(),
                                        ))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: <Widget>[
                                IconButton(
                                    icon: Icon(Icons.plus_one),
                                    onPressed: null),
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            right: 20, left: 10),
                                        child: TextFormField(
                                          validator: (input) {
                                            bool isValid = RegExp("[0-9]+")
                                                .hasMatch(input);
                                            if (!isValid) {
                                              return 'Quantity should be integer';
                                            }
                                          },
                                          onSaved: (input) {
                                            this._quantity = int.parse(input);
                                          },
                                          initialValue:
                                              item.quantity.toString(),
                                        ))),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: MaterialButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }),
                                ),
                                Expanded(
                                  child: MaterialButton(
                                      child: Text('Update'),
                                      onPressed: () async {
                                        if (_itemForm.currentState.validate()) {
                                          _itemForm.currentState.save();
                                          Navigator.of(context).pop();
                                          await ItemDatabase().updateAttr(
                                              item.id,_name, _price, _quantity);
                                        }
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
