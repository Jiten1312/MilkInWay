import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/models/order.dart';

class OrderDatabase {
  final CollectionReference orderCollection =
      Firestore.instance.collection('orders');

  //get list from snapshot
  List<Order> _orderListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Order(
        id: doc.documentID,
        custId: doc.data['custId'] ?? '',
        sdate: doc.data['sdate'].toDate() ?? 0,
        edate: doc.data['edate'].toDate() ?? 0,
        noOfItems: doc.data['noOfItem'] ?? 0,
        amount: doc.data['amount'] ?? 0,
        itemName: doc.data['itemName'] ?? '',
        itemPrice: doc.data['itemPrice'] ?? 0,
      );
    }).toList();
  }

  Future<void> updateOrderData(
    String custId,
    String itemName,
    int itemPrice,
    DateTime sdate,
    DateTime edate,
    int noOfItem,
    int amount,
  ) async {
    return await orderCollection.document().setData({
      'custId': custId,
      'itemName': itemName,
      'itemPrice': itemPrice,
      'sdate': sdate,
      'edate': edate,
      'noOfItem': noOfItem,
      'amount': amount,
    });
  }

  //get item snapshot
  Stream<List<Order>> get orders {
    return orderCollection.snapshots().map(_orderListFromSnapshot);
  }

  Future<Order> getOrderByDate(String id) async {
    try {
      QuerySnapshot doc =
          await orderCollection.where('custId', isEqualTo: id).getDocuments();
      return Order(
        custId: id,
        itemName: doc.documents[0]['itemName'],
        itemPrice: doc.documents[0]['itemPrice'],
        noOfItems: doc.documents[0]['noOfItems'],
        sdate: doc.documents[0]['sdate'].toDate() ?? 0,
        edate: doc.documents[0]['edate'].toDate() ?? 0,
      );
    } catch (e) {
      return null;
    }
  }
}
