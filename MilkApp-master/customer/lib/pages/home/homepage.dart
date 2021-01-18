import 'package:carousel_pro/carousel_pro.dart';
import 'package:customer/models/item.dart';
import 'package:customer/models/user.dart';
import 'package:customer/services/database/itemdatabase.dart';
import 'package:customer/services/database/userdatabase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:customer/pages/home/itemlist.dart';
import 'package:customer/pages/home/itemcard.dart';
import 'package:customer/pages/home/searchfield.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  CalendarController _controller = CalendarController();
  @override
  Widget build(BuildContext context) {
    Widget image_slider_carousel = Container(
      height: 200,
      child: Carousel(
        boxFit: BoxFit.fill,
        images: [
          AssetImage('assets/images/img1.jpg'),
          AssetImage('assets/images/img2.jpg'),
          AssetImage('assets/images/img3.jpg'),
          AssetImage('assets/images/img4.jpg'),
          AssetImage('assets/images/img5.jpg'),
        ],
        autoplay: true,
        indicatorBgPadding: 1.0,
      ),
    );
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.only(top: 50.0, left: 0.0, right: 0.0),
      children: <Widget>[
        SearchField(),
        Text("\n"),
        Expanded(
            child: FutureBuilder(
                future: viewRecentLocation(),
                builder: (context, AsyncSnapshot<Widget> snapshot) {
                  Widget widget = Container();
                  if (snapshot.hasData) {
                    widget = snapshot.data;
                  }
                  return widget;
                })),
        image_slider_carousel,
        Text("\n"),
        TableCalendar(
          calendarController: _controller,
          initialCalendarFormat: CalendarFormat.week,
          headerVisible: false,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "\nProducts\n",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
        viewItem(),
      ],
    ));
  }

  Widget viewItem() {
    return Container(
      child: StreamProvider<List<Item>>.value(
        value: ItemDatabase().items,
        child: ItemList(),
      ),
    );
  }

  Future<Widget> viewRecentLocation() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    User curUser = await UserDatabase().getCustomerById(user.uid);
    if (curUser.city!=null && curUser.houseNo!=null) {
      return Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
              'Recent Location: City: ${curUser.city}   Pincode: ${curUser.pincode}'),
        ),
      );
    }
    else{
      return Container();
    }
  }
}
