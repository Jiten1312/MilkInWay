import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/models/cancel.dart';

class CancelDatabase {
  final CollectionReference cancelCollection =
      Firestore.instance.collection('cancelorder');

  Future<void> setCancelData(
      String orderId, String custId, DateTime date, String itemName) async {
    return await cancelCollection.document().setData({
      'orderId': orderId,
      'custId': custId,
      'date': date,
      'itemName': itemName,
    });
  }

  List<Cancel> _cancelListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Cancel(
        id: doc.documentID,
        custId: doc.data['custId'] ?? '',
        orderId: doc.data['orderId'] ?? '',
        date: doc.data['date'].toDate() ?? 0,
        itemName: doc.data['itemName'] ?? '',
      );
    }).toList();
  }

  //get item snapshot
  Stream<List<Cancel>> get cancelorder {
    return cancelCollection.snapshots().map(_cancelListFromSnapshot);
  }

  Future<bool> check(String custid, DateTime date) async {
    QuerySnapshot doc =
          await cancelCollection.where('date', isEqualTo: date).where('custId', isEqualTo: custid).getDocuments();

    if(doc.documents.length == 0)
      return true;
    else
      return false;
  }

}
