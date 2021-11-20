import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  bool isEditing = false;
  TextEditingController? _controller = TextEditingController(
      text: FirebaseAuth.instance.currentUser!.displayName);
  Widget myName = Text(
    '${FirebaseAuth.instance.currentUser!.displayName}',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  );

  /* Widget userInfo() {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('User')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return Container(
            height: MediaQuery.of(context).size.height * 0.2,
            child:
          );
        });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Profile')),
        actions: [
          IconButton(
              onPressed: () async {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
                Navigator.pop(context);
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.network(
                    FirebaseAuth.instance.currentUser!.photoURL!)),
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isEditing == false
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                    myName,
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            isEditing = true;
                                          });
                                        },
                                        child: Text('Change display name'))
                                  ])
                            : Column(
                                children: [
                                  TextField(
                                    controller: _controller,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () async {
                                            setState(() {
                                              isEditing = false;
                                            });
                                          },
                                          child: Text('Cancel')),
                                      ElevatedButton(
                                          onPressed: () async {
                                            _controller = TextEditingController(
                                                text: _controller?.text);
                                            FirebaseAuth.instance.currentUser!
                                                .updateDisplayName(
                                                    _controller!.text);
                                            setState(() {
                                              myName = Text(
                                                '${_controller!.text}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              );
                                              isEditing = false;
                                              print(_controller?.text);
                                            });
                                          },
                                          child: Text('Save'))
                                    ],
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        /* Text(
                  snapshot.data!['email'].toString(),
                  style: TextStyle(fontSize: 20),
                ),*/
                      ],
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
    /*return */
  }
}
