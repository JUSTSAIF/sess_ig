import 'package:SESSIG/classes/user.dart';
import 'package:SESSIG/screens/Result.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:is_first_run/is_first_run.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:device_apps/device_apps.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var uuid = Uuid().toString();
  String error_msg = '';
  bool isError = false;
  late FocusNode username_fn;
  late FocusNode password_fn;
  TextEditingController username_c = TextEditingController();
  TextEditingController password_c = TextEditingController();
  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId;
    }
  }

  @override
  void initState() {
    super.initState();
    username_fn = FocusNode();
    password_fn = FocusNode();
  }

  @override
  void dispose() {
    username_fn.dispose();
    password_fn.dispose();
    super.dispose();
  }

  void login() async {
    var url = Uri.parse('https://b.i.instagram.com/api/v1/accounts/login/');
    var response = await http.post(url, body: {
      'uuid': uuid,
      'device_id': await _getId(),
      'username': username_c.text,
      'password': password_c.text,
      'from_reg': 'false',
      'csrftoken': 'missing',
      'login_attempt_countn': '0'
    }, headers: {
      'User-Agent':
          'Instagram 37.0.0.21.97 Android (23/6.0; 480dpi; 1080x1920; Meizu; MX6; MX6; mt6797; ru_RU; 98288242)',
      'x-requested-with': 'XMLHttpRequest',
      'x-csrftoken': 'missing',
      'x-instagram-ajax': '9a16d12cf843',
      'x-ig-app-id': '936619743392459',
    });
    var json_data = json.decode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isError = false;
      });
      var user_create_date_req = await http.get(Uri.parse(
          'https://o7aa.pythonanywhere.com/?id=' +
              json_data['logged_in_user']['pk'].toString()));
      var ucd = json.decode(user_create_date_req.body)['data'].toString();
      var cookies = response.headers['set-cookie'].toString();
      final startIndex = cookies.indexOf("sessionid=");
      final endIndex = cookies.indexOf(";", startIndex + "sessionid=".length);
      var SESSION_ID = cookies
          .substring(startIndex + "sessionid=".length, endIndex)
          .toString();
      var USERNAME = json_data['logged_in_user']['username'].toString();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Result(
              UD: new User(SESSION_ID, USERNAME, ucd),
            ),
          ));
    } else {
      setState(() {
        isError = true;
      });
      error_msg = json_data["message"];
    }
  }

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
          color: HexColor("#1D1D1D"),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                    child: TextFormField(
                      controller: username_c,
                      style: TextStyle(color: Colors.white),
                      focusNode: username_fn,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white70),
                        filled: true,
                        border: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelText: 'Username',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                    child: TextFormField(
                      controller: password_c,
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      focusNode: password_fn,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white70),
                        filled: true,
                        border: UnderlineInputBorder(),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    constraints:
                        BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                    margin: EdgeInsets.all(10),
                    child: ElevatedButton(
                      onPressed: () => login(),
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'LOGIN',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                                letterSpacing: 10,
                                color: Colors.white,
                              ),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  isError
                      ? Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            "🔴 $error_msg",
                            style:
                                TextStyle(color: Colors.redAccent, fontSize: 9),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ));
  }
}
