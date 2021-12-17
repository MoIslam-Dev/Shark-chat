
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shark_chat/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messagetextcontroller = TextEditingController();
  late String textmessages;
  final _firestor = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User logedInUser;
  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        logedInUser = user;
        print(logedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
                print('${logedInUser.email} Is signOut');
                // getStramMessages();
              }),
        ],

        
        title: Text('Shark Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _firestor
                    .collection('messages')
                    .orderBy('time')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final messages = snapshot.data!.docs.reversed.toList();
       
                    return Expanded(
                      child: ListView.builder(
                          reverse: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 20.0),
                          itemCount: messages.length,
                          itemBuilder: (context, i) {
                            Color materialclr;
                            if (logedInUser.email == messages[i]['sender']) {
                              materialclr = Colors.lightBlue;
                            } else {
                              materialclr = Colors.teal;
                            }
                            return Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment:
                                    logedInUser.email == messages[i]['sender']
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${messages[i]['sender']}",
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black54),
                                  ),
                                  Material(
                                      elevation: 5.0,
                                      borderRadius: logedInUser.email ==
                                              messages[i]['sender']
                                          ? BorderRadius.only(
                                              topLeft: Radius.circular(30.0),
                                              bottomLeft: Radius.circular(30.0),
                                              bottomRight:
                                                  Radius.circular(30.0))
                                          : BorderRadius.only(
                                              topRight: Radius.circular(30.0),
                                              bottomLeft: Radius.circular(30.0),
                                              bottomRight:
                                                  Radius.circular(30.0)),
                                      color: materialclr,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        child: Text(
                                          "${messages[i]['text']}",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white),
                                        ),
                                      )),
                                ],
                              ),
                            );
                          }),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlue,
                    ),
                  );
                }),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messagetextcontroller,
                      onChanged: (value) {
                        //Do something with the user input.
                        textmessages = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messagetextcontroller.clear();
                      //Implement send functionality.
                      _firestor.collection('messages').add(
                          {'text': textmessages, 'sender': logedInUser.email ,'time': FieldValue.serverTimestamp()});
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
