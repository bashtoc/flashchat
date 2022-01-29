import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login_screen.dart';

// ignore_for_file: prefer_const_constructors

class ChatScreen extends StatefulWidget {
  static  String  id = 'chatscreen';


   ChatScreen({Key? key,}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final _auth = FirebaseAuth.instance;



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Stream<QuerySnapshot> _fireStore = FirebaseFirestore.instance.collection('messages').snapshots();
  late String messageText;
  late final  User loggedInUser;



  @override
  void initState(){
    super.initState();


    getCurrentUser();
  }



  getCurrentUser() async{
    try{
    final user = await _auth.currentUser;
    if (user!= null) {

       print(loggedInUser.email);
    }
    } catch(e){
      //print(e);
    }
  }





  String? validatePass(value) {
    {
      if (value.isEmpty) {
        return 'message field empty';
      } else {
        return null;
      }
    }

  }


  @override
  Widget build(BuildContext context) {



    // final bool isMe;
    // final currentUser = loggedInUser.email;
    // final messageSender = messageText;
    // isMe: currentUser == messageSender;


    CollectionReference messages = FirebaseFirestore.instance.collection('messages');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
             _auth.signOut();
             Navigator.pushNamed(context, LoginScreen.id);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SizedBox(
                height: 200,
                child:GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: StreamBuilder<QuerySnapshot>( stream: _fireStore, builder: (BuildContext context, AsyncSnapshot <QuerySnapshot> snapshot,){

                    if (snapshot.hasError){
                      return Text('something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting){
                      return Text ('loading');
                    }
                    final data = snapshot.requireData;
                    return ListView.builder(

                      reverse: true,
                        primary: true,
                        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                        itemCount: data.size,
                        itemBuilder:
                            (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('${data.docs[index]['sender']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black38,
                                  ),
                                ),
                                Material(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), bottomLeft: Radius.circular(30.0), bottomRight: Radius.circular(30.0)),
                                  elevation: 5.0,

                                  color:  Colors.lightBlueAccent ,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                    child:  Text(' ${data
                                        .docs[index]['text']}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        );
                    }
                  ),
                )
              ),
            ),

            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: TextFormField(
                        controller: messageController,
                        validator: validatePass,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {

                      CircularProgressIndicator(value: 2,);

                      if (_formKey.currentState!.validate()) {
                        try{
                     messages.add({
                        'sender': loggedInUser.email,
                        'text': messageText,
                      });} catch(e){
                        print(e);
                      }

                        messageController.clear();
                      }
                    },
                    child:  Text(
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


