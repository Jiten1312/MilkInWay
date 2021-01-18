import 'package:firebase_auth/firebase_auth.dart';
import 'package:customer/models/user.dart';

import './database/userdatabase.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged
      //.map((FirebaseUser user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password,String fname,String lname,String contact) async {
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim());
      FirebaseUser user = result.user;
      await UserDatabase(uid: user.uid).updateUserData(fname,lname, contact, 0);
      return _userFromFirebaseUser(user); 
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      return null;
    } 
  }

  //Forgot Password
  Future sendPasswordResetEmail(String email) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    }catch(err){
      return null;
    }
  }
  //SignOut
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}