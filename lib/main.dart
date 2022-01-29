import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flashechat/screens/login_screen.dart';
import 'package:flashechat/screens/welcome_screen.dart';
import 'package:flashechat/screens/registration_screen.dart';
import 'package:flashechat/screens/chat_screen.dart';

// ignore_for_file: prefer_const_constructors
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  const FlashChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,

        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          ChatScreen.id: (context) => ChatScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
        }

    );
  }
}
