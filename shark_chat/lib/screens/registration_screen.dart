import 'package:firebase_core/firebase_core.dart';
import 'package:shark_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:shark_chat/ConstWidjet/buuton_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shark_chat/screens/chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late final _auth = FirebaseAuth.instance;
  late String email;
  late String pass;
   bool showspin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspin,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logoAnim',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/blue-shark-logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration:
                    KTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    //Do something with the user input.
                    pass = value;
                  },
                  decoration: KTextFieldDecoration.copyWith(
                      hintText: 'Enter your password',
                      fillColor: Colors.black)),
                      

                      
                      
              SizedBox(
                height: 24.0,
              ),
              ButtonWidjet(
                text: 'Register',
                color: Colors.blueAccent,
                whenpressed: () async {
                  setState(() {
                    showspin=true;
                  });
                  try {
                    final usrauth = await _auth.createUserWithEmailAndPassword(
                        email: email, password: pass);
                         
                        
                    if (usrauth != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                    showspin=false;
                  });
                   
                  } catch (e) {
                    print(e);
                     
                  }
                  
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
