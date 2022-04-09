import 'package:SESSIG/screens/Closed.dart';
import 'package:SESSIG/screens/Home.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() async {
  try {
    final result = await InternetAddress.lookup('google.com')
        .timeout(Duration(seconds: 1));
    if (!result.isNotEmpty && !result[0].rawAddress.isNotEmpty) {
      exit(0);
    }
  } on SocketException catch (_) {
    exit(0);
  }

  var req = await http.get(Uri.parse("https://pastebin.com/raw/nrgZkJGv"));
  var data = req.body.toString();
  runApp(MaterialApp(
    home: data.toLowerCase() == "true" ? Home() : Closed(),
  ));
}
