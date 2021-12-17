
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:shark_chat/screens/login_screen.dart';
import 'package:shark_chat/screens/registration_screen.dart';
import 'package:shark_chat/ConstWidjet/buuton_widget.dart';
class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
   late AnimationController controller; // the animation contoller
   late Animation animation;
  @override
  void initState() {
    
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        duration: Duration(seconds: 3), vsync: this); //ticker
    animation =
        ColorTween(begin: Colors.grey, end: Colors.white).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {
        
      });
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logoAnim',
                  child: Container(
                    child: Image.asset('images/blue-shark-logo.png'),
                    height: 60.0,
                  ),
                ),
                DefaultTextStyle(
                  style: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('Shark Chat'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            ButtonWidjet(text: 'Log In',color: Colors.lightBlue,whenpressed: (){Navigator.pushNamed(context, LoginScreen.id);},),
            ButtonWidjet(text: 'Register',color:Colors.blueAccent ,whenpressed: (){Navigator.pushNamed(context, RegistrationScreen.id);},),
          ],
        ),
      ),
    );
  }
}


