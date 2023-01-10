import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:m335/SignOutWidget.dart';
import 'package:m335/UserPageWidget.dart';
import 'package:m335/courseListWidget.dart';

class Gallery extends StatefulWidget {
  const Gallery({super.key});

  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {

  final List<Image> _images = [];

  @override
  void initState() {
    super.initState();
    loadImages();
    setState(() {
      _images;
    });

  }

  Future<List<Image>> loadImages() async {
    final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    //use this line of code when deployed this will work with the upload image function
    //final ref = FirebaseStorage.instance.ref().child('images/$currentUserUid');
    // this code works with the test images in the database
    final ref = FirebaseStorage.instance.ref().child('');
    final listResult = await ref.listAll();
    final urls = await Future.wait(
        listResult.items.map((ref) => ref.getDownloadURL()));
    return urls.map((url) => Image.network(url)).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          backgroundColor: Colors.deepPurpleAccent,
          title: Image.asset('assets/images/logo.png', height:100, width:100, fit: BoxFit.fitWidth),
      ),
      body: FutureBuilder(
        future: loadImages(),
        builder: (context, AsyncSnapshot<List<Image>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: GridView.count(
                crossAxisCount: 1,
                children: snapshot.data!.map((e)=> e as Widget).toList(),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
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

class StorageService {
  static Future<String> getDownloadURL(String path) async {
    return await FirebaseStorage.instance.ref(path).getDownloadURL();
  }
}

