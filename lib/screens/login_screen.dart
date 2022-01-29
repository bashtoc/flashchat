import 'package:flashechat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'constants.dart';
import 'package:flashechat/screens/roundedbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {
  static const String id = 'loginscreen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool showSpinner = false;

  String? validatePass(value) {
    {
      if (value!.isEmpty) {
        return 'required';
      } else {
        return null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 170.0,
              ),
              Hero(
                tag: 'logo',
                child: Container(
                  margin: EdgeInsets.zero,
                  height: 170.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(

                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        decoration:
                            ktextfield.copyWith(hintText: 'Enter your email'),
                        onChanged: (value) {
                          email = value;
                        },
                        validator: validatePass,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration:
                            ktextfield.copyWith(hintText: 'Enter your password'),
                        validator: validatePass,
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      roundedButton(
                          title: 'login',
                          colour: Colors.lightBlueAccent,
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {


                              try {



                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);

                                Navigator.pushNamed(context, ChatScreen.id);
                              } on FirebaseAuthException catch (error) {
                                Fluttertoast.showToast(
                                  msg: error.message.toString(),
                                  gravity: ToastGravity.TOP,
                                  timeInSecForIosWeb: 2,
                                );

                              }
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
