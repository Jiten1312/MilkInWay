import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/models/item.dart';

class ItemDatabase {
  final CollectionReference itemCollection =
      Firestore.instance.collection('item');

  Future<void> updateItemData(String name, int price, int quantity) async {
    return await itemCollection.document().setData({
      'name': name,
      'price': price,
      'quantity': quantity,
    });
  }

  Future<void> updateAttr(
      String id, String name, int price, int quantity) async {
    return await itemCollection.document(id).updateData({
      'name': name,
      'price': price,
      'quantity': quantity,
    });
  }

  Future<void> deleteitemData(String id) async {
    return await itemCollection.document(id).delete();
  }

  //get list from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Item(
        id: doc.documentID,
        name: doc.data['name'] ?? '',
        price: doc.data['price'] ?? 0,
        quantity: doc.data['quantity'] ?? 0,
      );
    }).toList();
  }

  //get item snapshot
  Stream<List<Item>> get items {
    return itemCollection.snapshots().map(_itemListFromSnapshot);
  }

  //get Item by ID
  Future<Item> getItemById(String id) async {
    try {
      DocumentSnapshot doc = await itemCollection.document(id).get();
      return Item(
        id: id,
        name: doc.data['name'],
        price: doc.data['price'],
        quantity: doc.data['quantity'],
      );
    } catch (e) {
      return null;
    }
  }
}
