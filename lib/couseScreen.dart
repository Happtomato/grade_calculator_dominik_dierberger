import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:m335/Gallery.dart';
import 'package:m335/SignOutWidget.dart';
import 'package:m335/UserPageWidget.dart';
import 'package:m335/courseListWidget.dart';

class CreateCourseScreen extends StatefulWidget {
  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final _firestore = FirebaseFirestore.instance;
  late String _courseName;
  late double _grade;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurpleAccent,
        title: Image.asset('assets/images/logo.png', height:100, width:100, fit: BoxFit.fitWidth),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _courseName = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Enter the name of the course',
                ),
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _grade = double.parse(value);
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter the grade for the course',
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
                _firestore
                    .collection('courses')
                    .add({
                  'name': _courseName,
                  'grade': _grade,
                  'uid': currentUserUid,
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CourseList(userUid: currentUserUid)),
                );
              },
              child: const Text('Create course'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.purple[300]!,
              hoverColor: Colors.purple[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserPageWidget()),
                    );
                  },
                ),
                GButton(
                  icon: LineIcons.photoVideo,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Gallery()),
                    );
                  },
                ),
                GButton(
                  icon: LineIcons.graduationCap,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CourseList(userUid: FirebaseAuth.instance.currentUser!.uid)),
                    );
                  },
                ),
                GButton(
                  icon: LineIcons.user,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignOutWidget()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
