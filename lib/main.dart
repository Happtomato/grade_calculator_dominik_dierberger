import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:m335/LoginWidget.dart';
import 'package:m335/SignUpWidget.dart';
import 'firebase_options.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:m335/main.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'GradeCalculator',
      theme: ThemeData(
        fontFamily: 'Roboto',
        backgroundColor: Colors.deepPurpleAccent,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurpleAccent,
        title: Image.asset("assets/images/logo.png", height: 100,
            width: 100,
            fit: BoxFit.fitWidth),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 300.0),
        child: Center(
          child: Form(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginWidget()),
                      );
                    },
                    child: const Text('LogIn'),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpWidget()),
                        );
                      },
                      child: const Text('SignUp'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}