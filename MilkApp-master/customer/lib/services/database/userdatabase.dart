import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer/models/user.dart';

class UserDatabase{
  final String uid;
  UserDatabase({this.uid});

  final CollectionReference adminCollection=Firestore.instance.collection('customer');

  Future<void> updateUserData(String fname, String lname, String contact, int wallet) async {
    return await adminCollection.document(uid).setData({
      'firstname':fname,
      'lastname':lname,
      'contact':contact,
      'wallet': wallet,
    });
  }

  Future<void> updateData(String id,String fname,String lname,String contact) async {
    return await adminCollection.document(id).updateData({
      'firstname':fname,
      'lastname':lname,
      'contact':contact,
    });
  }

  Future<void> updateAttr(String id, String houseNo, String landmark, String city, String pincode, String country) async{
    return await adminCollection.document(id).updateData({
      'houseNo': houseNo,
      'landmark': landmark,
      'city': city,
      'pincode': pincode,
      'country': country
    });
  }

  Future<User> getCustomerById(String id) async {
    DocumentSnapshot doc= await adminCollection.document(id).get();
    return User(
      uid: id,
      contact: doc.data['contact'],
      firstname: doc.data['firstname'],
      lastname: doc.data['lastname'], 
      wallet: doc.data['wallet'],
      city: doc.data['city'],
      country: doc.data['country'],
      houseNo: doc.data['houseNo'],
      landmark: doc.data['landmark'],
      pincode: doc.data['pincode'],  
    );
  }

  Future<void> updateWallet(String uid, int wallet) async {
    try{
      return await adminCollection.document(uid).updateData({
        'wallet': wallet,
      });
    }catch(Exception){
      
    }
  }

}