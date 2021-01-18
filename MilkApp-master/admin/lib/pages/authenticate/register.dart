import 'package:admin/services/auth.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String _error = "";

  // text field state
  String _email = '';
  String _password = '';
  String _firstName, _lastName, _contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('MilkInWay'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('SignIn'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            showAlert(),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.person), onPressed: null),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                debugPrint('FN invalid');
                                return 'Enter First Name';
                              }
                            },
                            onChanged: (input) {
                              setState(() => _firstName = input);
                            },
                            decoration: InputDecoration(hintText: 'FirstName'),
                          ))),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                debugPrint('LN invalid');
                                return 'Enter Last Name';
                              }
                            },
                            onChanged: (input) {
                              setState(() => _lastName = input);
                            },
                            decoration: InputDecoration(hintText: 'LastName'),
                          )))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.email), onPressed: null),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: TextFormField(
                            validator: (input) {
                              if (input.isEmpty) {
                                debugPrint('Email invalid');
                                return 'Enter Email Adress';
                              }
                            },
                            onChanged: (input) {
                              setState(() => _email = input);
                            },
                            decoration: InputDecoration(hintText: 'email'),
                          )))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.call), onPressed: null),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: TextFormField(
                            validator: (input) {
                              if (input.length !=10) {
                                debugPrint('contact invalid');
                                return 'Enter 10-digit contact number';
                              }
                            },
                            onChanged: (input) {
                              setState(() => _contact = input);
                            },
                            decoration: InputDecoration(hintText: 'Phone'),
                          ))),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.lock), onPressed: null),
                  Expanded(
                      child: Container(
                          margin: EdgeInsets.only(right: 5, left: 10),
                          child: TextFormField(
                            validator: (input) {
                              if (input.length < 6) {
                                return 'Password length too short';
                              }
                            },
                            onChanged: (input) {
                              setState(() => _password = input);
                            },
                            decoration: InputDecoration(hintText: 'Password'),
                            obscureText: true,
                          ))),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(right: 20, left: 0),
                    child: TextFormField(
                      obscureText: true,
                      validator: (input) {
                        if (input != _password) {
                          return 'password does\'t match ';
                        }
                      },
                      decoration: InputDecoration(hintText: 'Confirm Password'),
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 60,
                  child: RaisedButton(
                    onPressed: () async {
                      try {
                        if (_formkey.currentState.validate()) {
                          dynamic result = await _auth
                              .registerWithEmailAndPassword(_email, _password,_firstName,_lastName,_contact);
                          print(result);
                        }
                      } catch (exception) {
                        print("_errorMESSAGEIS" + exception.message);
                        setState(() => _error = exception.message);
                      }
                    },
                    color: Color(0xFF00a79B),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget showAlert() {
    if (_error != "") {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _error,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() => _error = "");
                  }),
            ),
          ],
        ),
      );
    }
    return SizedBox();
  }
}
