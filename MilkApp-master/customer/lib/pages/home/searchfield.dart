import 'package:customer/pages/home/homepage.dart';
import 'package:customer/services/database/userdatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class SearchField extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchField> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Position _currentPosition;
  String _currentAddress;
  String _city, _pincode, _country,uid;

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (_currentPosition != null) Text(_currentAddress),
          FlatButton(
              child: Text("Get location"),
              onPressed: () {
                _getCurrentLocation();
                final _LocForm = GlobalKey<FormState>();
                String _houseNo, _landmark;
                return showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Container(
                        width: 500.0,
                        height: 300.0,
                        child: Form(
                          key: _LocForm,
                          child: Column(
                            children: <Widget>[ 
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                right: 20, left: 10),
                                            child: TextFormField(
                                              validator: (input) {
                                                if (input.isEmpty) {
                                                  return 'Please Enter House No, Apartment or Floor';
                                                }
                                              },
                                              onSaved: (input) {
                                                setState(() => _houseNo = input);
                                              },
                                              decoration: InputDecoration(
                                                  hintText:
                                                      'House No | Apartment | Floor'),
                                            ))),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                right: 20, left: 10),
                                            child: TextFormField(
                                              validator: (input) {
                                                if (input.isEmpty) {
                                                  return 'Please Enter Landmark';
                                                }
                                              },
                                              onSaved: (input) {
                                                setState(() => _landmark = input);
                                              },
                                              decoration: InputDecoration(
                                                  hintText: 'Landmark'),
                                            ))),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: MaterialButton(
                                          child: Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          }),
                                    ),
                                    Expanded(
                                      child: MaterialButton(
                                        child: Text('Update'),
                                        onPressed: () async {
                                          if (_LocForm.currentState.validate()) {
                                          _LocForm.currentState.save();
                                          Navigator.of(context).pop();
                                          uid = await getUserId();
                                          await UserDatabase().updateAttr(
                                              uid, _houseNo, _landmark, _city, _pincode, _country);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
        ],
      ),
      //),
    );
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
        _city = "${place.locality}";
        _pincode = "${place.postalCode}";
        _country = "${place.country}";

      });
    } catch (e) {
      print(e);
    }
  }
  Future<String> getUserId() async {
    final FirebaseUser user = await _auth.currentUser();
    uid = user.uid;
    return uid;
  }
}