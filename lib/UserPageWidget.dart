import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:m335/LoginWidget.dart';
import 'package:m335/SignOutWidget.dart';
import 'package:m335/couseScreen.dart';
import 'package:m335/main.dart';

class UserPageWidget extends StatefulWidget {
  const UserPageWidget({super.key});

  @override
  _userPageWidgetState createState() => _userPageWidgetState();
}

class _userPageWidgetState extends State<UserPageWidget> {

  late File _image;
  late String _uploadedImageUrl;

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    var image = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image as File;
    });

    uploadImage();
  }

  Future uploadImage() async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().toString()}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete(() => null);
    print('Image Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedImageUrl = fileURL;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Image"),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Pick Image',
            child: const Icon(Icons.add_photo_alternate),
          ),
        ],
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







