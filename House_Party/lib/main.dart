import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:logingoogle/home.dart';
import 'package:logingoogle/welcome.dart';
import 'Register.dart';
import 'login.dart';
import 'dart:async';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const welcome(),
    routes: {
      'register': (context) => const MyRegister(),
      'login': (context) => const MyLogin(),
      'welcome': (context) => const welcome(),
      'fb': (context) => const MyApp(),
      'home': (contect) => Myhome()
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfisLoggedIn();
  }

  _checkIfisLoggedIn() async {
    final accessToken = await FacebookAuth.instance.accessToken;

    setState(() {
      _checking = false;
    });

    if (accessToken != null) {
      print(accessToken.toJson());
      final userData = await FacebookAuth.instance.getUserData();
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
      });
    } else {
      _login();
    }
  }

  _login() async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;

      final userData = await FacebookAuth.instance.getUserData();
      _userData = userData;
    } else {
      print(result.status);
      print(result.message);
    }
    setState(() {
      _checking = false;
    });
  }

  _logout() async {
    await FacebookAuth.instance.logOut();
    _accessToken = null;
    _userData = null;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print(_userData);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('demofbauth')),
        body: _checking
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _userData != null
                    ? Text('name: ${_userData!['name']}')
                    : Container(),
                _userData != null
                    ? Text('email: ${_userData!['email']}')
                    : Container(),
                _userData != null
                    ? Container(
                  child: Image.network(
                      _userData!['picture']['data']['url']),
                )
                    : Container(),
                SizedBox(
                  height: 20,
                ),
                CupertinoButton(color: Colors.blue,
                    child: Text(
                      _userData != null ? 'LOGOUT' : 'LOGIN',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: _userData != null ? _logout : _login)
              ],
            )),
      ),
    );
  }
}
final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main1() {
  runApp(MaterialApp(
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: darkBlue),
      debugShowCheckedModeBanner: false,
      home: TimeStampClock()));
}

class TimeStampClock extends StatefulWidget {
  @override
  ClockState createState() => ClockState();
}

class ClockState extends State<TimeStampClock> {
  late DateTime now;
  late String strTime;
  List<String> timeStamps = [];

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    strTime = timeToString(now);

    new Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        now = DateTime.now();
        strTime = timeToString(now);
      });
    });
  }

  String timeToString(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Timer App'),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 3,
                child: InkWell(
                  onTap: () {
                    timeStamps.add(strTime);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text("$strTime",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                  ),
                )),
            Expanded(
                flex: 7,
                child: ListView.builder(
                    itemCount: timeStamps.length,
                    itemBuilder: (context, idx) {
                      return InkWell(
                          child: Card(
                              color: Colors.white70,
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 24.0, horizontal: 16.0),
                                  child: Text(
                                      "${timeStamps[timeStamps.length - idx - 1]}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )))),
                          onTap: () {
                            timeStamps.removeAt(timeStamps.length - idx - 1);
                          });
                    })),
          ],
        ));
  }
}