import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:m335/SignOutWidget.dart';
import 'package:m335/UserPageWidget.dart';
import 'package:m335/courseListWidget.dart';
import 'package:m335/couseScreen.dart';
import 'package:m335/main.dart';


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

  void loadImages() async {
    // Access the Firebase storage
    var storage = FirebaseStorage.instance;
    // Get a reference to the folder where your pictures are stored
    var ref = storage.ref();
    // Get the list of files in the folder
    var files = await ref.listAll();
    // Loop through the files and download each one
    for (var file in files.items) {
      var downloadUrl = await file.getDownloadURL();
      // Use the download URL to create an Image widget
      var image = Image.network(downloadUrl);
      // Add the image to the list of images
        _images.add(image);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          backgroundColor: Colors.deepPurpleAccent,
          title: Image.asset('assets/images/logo.png', height:100, width:100, fit: BoxFit.fitWidth),



      ),
      body: GridView.count(
        crossAxisCount: 1,
        children: _images,
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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
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
                          builder: (context) => const UserPageWidget()),
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
                  icon: LineIcons.graduationCap,
                  text: 'Exams',
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

class StorageService {
  static Future<String> getDownloadURL(String path) async {
    return await FirebaseStorage.instance.ref(path).getDownloadURL();
  }
}
