import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:m335/Gallery.dart';
import 'package:m335/SignOutWidget.dart';
import 'package:m335/couseScreen.dart';
import 'package:m335/main.dart';

class CourseList extends StatelessWidget {
  final String userUid;

  const CourseList({super.key, required this.userUid});

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserGrades(String uid) {
    // Create a reference to the cities collection
    final coursesRef = FirebaseFirestore.instance.collection('courses');

    // Create a query against the collection.
    final query = coursesRef.where("uid", isEqualTo: uid);

    // Get the snapshot of the query
    final snapshot = query.snapshots();

    // Return the list of documents in the snapshot
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: getUserGrades(userUid),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return DataTable(
            columns: const [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Grade')),
            ],
            rows: snapshot.data!.docs.map(
                  (courses) => DataRow(
                cells: [
                  DataCell(Text(courses['name'])),
                  DataCell(Text(courses['grade'].toString())),
                ],
              ),
            ).toList(),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
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
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              backgroundColor: Colors.grey,
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyApp()),
                    );
                  },
                ),
                GButton(
                  icon: LineIcons.graduationCap,
                  text: 'Exams',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateCourseScreen()),
                    );
                  },
                ),
                GButton(
                  icon: LineIcons.photoVideo,
                  text: 'Gallery',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Gallery()),
                    );
                  },
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
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
