import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatabase{
  final String uid;
  UserDatabase({this.uid});

  final CollectionReference adminCollection=Firestore.instance.collection('admin');

  Future<void> updateUserData(String fname,String lname,String contact) async {
    return await adminCollection.document(uid).setData({
      'firstname':fname,
      'lastname':lname,
      'contact':contact,
    });
  }
}