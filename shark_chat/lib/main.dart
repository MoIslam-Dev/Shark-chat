
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/chat_screen.dart';
/*
firebase_core: ^1.10.2
  firebase_auth: ^3.3.0
  cloud_firestore: ^3.1.1*/
void main() {
  
runApp(FlashChat());
}


class FlashChat extends StatelessWidget {
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      print(e);
      };
    }
    
  @override
  Widget build(BuildContext context) {
    initializeFlutterFire();
    
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes : {
        WelcomeScreen.id : (context)=> WelcomeScreen(),
        LoginScreen.id : (context)=> LoginScreen(),
        RegistrationScreen.id : (context)=> RegistrationScreen(),
        ChatScreen.id : (context)=> ChatScreen(),
      }
      ,
    );
  }
}
