import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

class Contact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'About MilkInWay:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'MilkInWay gives you a hassle-free and convenient delivery system right at your doorstep. Automate your online milk delivery operation and allows you to customize a schedule according to your needs.',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            const Divider(
                color: Colors.black26,
                height: 10,
                thickness: 2,
                indent: 0,
                endIndent: 0),
            Row(
              children: <Widget>[
                Text(
                  'Email: milkinway@gmail.com',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                    child: IconButton(
                        icon: Icon(Icons.email),
                        onPressed: () async {
                          String url = "mailto:milkinway@gmail.com";
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        })),
              ],
            ),
            Row(
              children: <Widget>[
                Text(
                  'Contact: 7490065905             ',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                Expanded(
                    child: IconButton(
                        icon: Icon(Icons.call),
                        onPressed: () async {
                          String url = "tel:+917490065905";
                          if (await canLaunch(url)) {
                            await launch(url);
                          } else {
                            throw 'Could not launch $url';
                          }
                        })),
              ],
            ),
          ],
        ));
  }
}
