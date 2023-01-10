import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:m335/Gallery.dart';
import 'package:m335/SignOutWidget.dart';
import 'package:m335/UserPageWidget.dart';
import 'package:m335/couseScreen.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurpleAccent,
        title: Image.asset('assets/images/logo.png', height:100, width:100, fit: BoxFit.fitWidth),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("courses")
            .where('uid', isEqualTo: userUid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final List<QueryDocumentSnapshot<Map<String, dynamic>>> docSnapList =
              snapshot.data?.docs ?? [];

          if (docSnapList.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'No courses found.',
                ),
              ),
            );
          }
          final List<Map<String, dynamic>> docList = docSnapList.map((QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot) => queryDocumentSnapshot.data()).toList();
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: docList.length,
            itemBuilder: (context, index) {

              String name = docList[index]['name'].toString();
              String grade = docList[index]['grade'].toString();

              name ??= "No name";
              grade ??= "No grade";

              return ListTile(
                leading: Text(name),
                title: Text(grade),
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateCourseScreen(),
                ),
              );
            },
            tooltip: 'Create new course',
            child: const Icon(Icons.add),
          ),
        ],
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
