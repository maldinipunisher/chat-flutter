import 'package:chatapp/services/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  User user;
  TestPage(this.user, {Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(onPressed: () async {
        var data = await MessageServices.getContacts(widget.user);
        print(data);

        var rooms = await MessageServices.getRooms(widget.user, data);
        print(rooms);
      }),
    );
  }
}
