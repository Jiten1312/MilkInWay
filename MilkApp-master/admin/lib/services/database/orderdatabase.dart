import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/models/order.dart';

class OrderDatabase{

  final CollectionReference orderCollection=Firestore.instance.collection('orders');

  //get list from snapshot
  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Order(
        id: doc.documentID,
        custId: doc.data['custId'] ?? '',
        sdate: doc.data['sdate'].toDate() ?? 0,
        edate: doc.data['edate'].toDate() ?? 0,
        noOfItems: doc.data['noOfItem'] ?? 0,
        amount: doc.data['amount'] ?? 0,
        itemName: doc.data['itemName'] ?? '',
        itemPrice: doc.data['itemPrice'] ?? 0,
        completed: doc.data['completed'] ?? false,
      );
    }).toList();
  }

  //get item snapshot
  Stream<List<Order>> get orders {
    return orderCollection.snapshots().map(_orderListFromSnapshot);
  }

  Future<void> markCompleted(String oid) async {
    try{
      return await orderCollection.document(oid).updateData({
        'completed': true,
      });
    }catch(Exception){
      
    }
  }
}