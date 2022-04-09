import 'package:clipboard/clipboard.dart';
import 'package:SESSIG/classes/user.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class Result extends StatelessWidget {
  const Result({Key? key, required this.UD}) : super(key: key);
  final User UD;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: EdgeInsets.all(20),
        alignment: Alignment.topLeft,
        color: HexColor("#1D1D1D"),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("USERNAME : ${UD.username}",
                style: TextStyle(color: HexColor("#DEDEDE"), fontSize: 15)),
            SizedBox(height: 10),
            Text("Acc Date : ${UD.acc_create_date}",
                style: TextStyle(color: HexColor("#DEDEDE"), fontSize: 15)),
            SizedBox(height: 35),
            Text("SESSION ID : ",
                style: TextStyle(color: HexColor("#DEDEDE"), fontSize: 15)),
            SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(HexColor("#AAD7FF")),
              ),
              child: Container(
                alignment: Alignment.center,
                height: 28,
                child: Text("${UD.sessionid}",
                    style: TextStyle(
                      color: HexColor("#4F4F4F"),
                      fontSize: 15,
                    )),
              ),
              onPressed: () {
                FlutterClipboard.copy("${UD.sessionid}").then((value) =>
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Session id Copied"),
                    )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
