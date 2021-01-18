import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/models/item.dart';

class ItemDatabase{

  final CollectionReference itemCollection=Firestore.instance.collection('item');

  //get list from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
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

  Future<bool> isItemAvailable(String id) async {
    DocumentSnapshot doc= await itemCollection.document(id).get();
    try{
      String name=doc.data['name'];
      print(name);
      if( name==null)
        return false;
      else 
        return true;
    }
    catch(Exception){
      return false;
    }
  }

}