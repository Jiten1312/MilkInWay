import 'package:customer/pages/authenticate/authenticate.dart';
import 'package:customer/models/user.dart';
import 'package:flutter/material.dart';
import 'package:customer/main.dart';
import 'package:provider/provider.dart';
import 'home/homepage.dart';
import 'home/view.dart';

class Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final user=Provider.of<User>(context); 
    
    if(user==null){
      print('Null User');
      return Authenticate();
    }else{
      return View();
    }
  }
}