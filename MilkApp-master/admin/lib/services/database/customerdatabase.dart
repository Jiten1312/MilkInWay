import 'package:admin/models/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerDatabase {
  final CollectionReference customerCollection =
      Firestore.instance.collection('customer');

  Future<Customer> getCustomerById(String id) async {
    try {
      DocumentSnapshot doc = await customerCollection.document(id).get();
      return Customer(
        id: id,
        contact: doc.data['contact'],
        firstname: doc.data['firstname'],
        lastname: doc.data['lastname'],
        houseNo: doc.data['houseNo'],
        landmark: doc.data['landmark'],
        city: doc.data['city'],
        pincode: doc.data['pincode'],
        country: doc.data['country'],
        wallet: doc.data['wallet']
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> updateWallet(String uid, int wallet) async {
    try{
      return await customerCollection.document(uid).updateData({
        'wallet': wallet,
      });
    }catch(Exception){
      
    }
  }
}
