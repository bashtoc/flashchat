
import 'package:flutter/material.dart';
import 'roundedbutton.dart';
import 'package:flashechat/screens/login_screen.dart';
import 'package:flashechat/screens/registration_screen.dart';


class WelcomeScreen extends StatefulWidget {

  static const String  id = 'welcomescreen';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(

              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    margin: EdgeInsets.zero,
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),

                 const Text(
                  'Flash Chat',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
             const SizedBox(
              height: 48.0,
            ),
            roundedButton(
              title: 'login',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
           roundedButton(title: 'Register', colour: Colors.blueAccent,    onPressed: () {
             Navigator.pushNamed(context, RegistrationScreen.id);
           }, )
          ],
        ),
      ),
    );
  }
}

