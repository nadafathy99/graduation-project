import 'dart:io';

import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final File file;
  final String url;
  UserAvatar.fromFile(this.file) : this.url = null;
  UserAvatar.fromNetwork(this.url) : this.file = null;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: CircleAvatar(
            radius: 80,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              radius: 78,
              backgroundColor: Colors.grey[200],
              backgroundImage: (file == null && url == null)
                  ? AssetImage("assets/images/defaultavatar.png")
                  : (file != null)
                      ? FileImage(file)
                      : (url != null)
                          ? NetworkImage(url)
                          : null,
            ),
          )),
    );
  }
}
