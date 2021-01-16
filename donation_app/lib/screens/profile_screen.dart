import 'dart:io';
import 'package:donation_app/widgets/app_drawer.dart';
import 'package:donation_app/widgets/profile_screen/avatar.dart';
import 'package:donation_app/widgets/profile_screen/change_password.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile-screen";

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File image;

  void pickImage(bool fromGallery) async {
    ImagePicker picker = ImagePicker();
    final pickedImage = await picker.getImage(
        source: (fromGallery) ? ImageSource.gallery : ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  UserAvatar.fromFile(image),
                  Positioned(
                    right: MediaQuery.of(context).size.width * 0.25,
                    bottom: 20,
                    child: InkWell(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                          size: 28.0,
                        ),
                        onTap: () {
                          showModalBottomSheet(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          "Choose your avatar",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        //width: MediaQuery.of(context).size.width,
                                        child: FlatButton.icon(
                                          icon: Icon(Icons.camera),
                                          onPressed: () {
                                            pickImage(false);
                                            Navigator.pop(context);
                                          },
                                          label: Text(
                                            "Camera",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        //width: MediaQuery.of(context).size.width,
                                        child: FlatButton.icon(
                                          icon: Icon(Icons.image),
                                          onPressed: () {
                                            pickImage(true);
                                            Navigator.pop(context);
                                          },
                                          label: Text(
                                            "Gallery",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }),
                  ),
                ],
              ),
              ChangePass(),
            ],
          ),
        ),
      ),
    );
  }
}
