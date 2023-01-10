import 'package:flutter/material.dart';
import 'package:m335/UserPageWidget.dart';
import 'package:m335/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignOutWidget extends StatefulWidget {
  const SignOutWidget({super.key});

  @override
  _signOutWidgetState createState() => _signOutWidgetState();
}

class _signOutWidgetState extends State<SignOutWidget> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 300.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        await _auth.signOut();
                      }
                      catch (e) {
                        print(e);
                      }
                    }
                    if(_auth.currentUser == null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MyApp()),
                        );
                      };
                  },
                  child: const Text('Confirm Sign Out'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(
                      context,
                      MaterialPageRoute(builder: (context) => const UserPageWidget()),
                    );
                  },
                  child: const Text('Go Back'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
