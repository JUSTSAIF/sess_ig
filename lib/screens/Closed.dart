import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import "dart:math";

class Closed extends StatelessWidget {
  const Closed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    final _random = new Random();
    return Scaffold(
        key: _key,
        appBar: AppBar(
          title: Text("SESSIG - By Mr28",
              style: TextStyle(color: HexColor("#30618A"))),
          centerTitle: true,
          backgroundColor: HexColor("#262626"),
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () => launch("https://www.instagram.com/qq_iq/"),
            ),
          ],
        ),
        body: Container(
            color: HexColor("#1D1D1D"),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/' +
                        ['1', '2'][_random.nextInt(2)].toString() +
                        '.png'),
                    width: 120,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'App is closed !',
                    style: TextStyle(
                        color: HexColor("#F32F29"),
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Try again later 0w0',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            )));
  }
}
