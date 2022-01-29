import 'package:flashechat/screens/chat_screen.dart';
import 'package:flashechat/screens/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_Screen';



  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? validatePass(value) {
    {
      if (value.isEmpty) {
        return 'required';
      } else {
        return null;
      }
    }
  }

  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(

        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 10,),
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      padding: EdgeInsets.zero,
                      height: 160.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: ktextfield.copyWith(hintText: 'Enter your email'),
                    validator: validatePass),
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
                  decoration: ktextfield.copyWith(hintText: 'Enter your password'),
                  validator: validatePass,
                  ),

                const SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.blueAccent,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () async {


                        if (_formKey.currentState!.validate()) {

                        }
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
 ;                         if (newUser != null);
                          Navigator.pushNamed(context, ChatScreen.id);

                        } on FirebaseAuthException catch (error){
                          Fluttertoast.showToast(msg: error.message.toString(),
                          gravity: ToastGravity.TOP,
                             timeInSecForIosWeb: 2,
                          );
                         }
                        },

                      minWidth: 200.0,
                      height: 42.0,
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
