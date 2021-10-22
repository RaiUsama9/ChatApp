import 'package:ecommerce/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  FirebaseAuthe data = FirebaseAuthe();

  TextEditingController _controller = TextEditingController();
  var msg;
  String? email = FirebaseAuthe().fetch_data();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello ' + email!,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: data.databaseref,
              itemBuilder: (context, snapshot, animation, index) {
                if (snapshot.value['Email'] == email)
                  return BubbleChat(
                    check: true,
                    email: snapshot.value['Email'],
                    message: snapshot.value['Message'],
                  );
                else {
                  return BubbleChat(
                    check: false,
                    email: snapshot.value['Email'],
                    message: snapshot.value['Message'],
                  );
                }
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: TextField(
                    controller: _controller,
                    onChanged: (value) {
                      msg = value;
                    },
                    decoration: InputDecoration(
                      hintText: 'Send a Message',
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  print(msg);
                  data.addMessagetoRealTime(
                    msg,
                    email!,
                  );
                  _controller.clear();
                },
                child: Icon(
                  Icons.send,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BubbleChat extends StatelessWidget {
  BubbleChat({this.email, this.message, required this.check});
  String? email;
  String? message;
  bool check;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: check
          ? EdgeInsets.only(top: 10, left: 230, right: 10)
          : EdgeInsets.only(top: 10, right: 60, left: 10),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              email!,
              style: check == true
                  ? TextStyle(color: Colors.blue)
                  : TextStyle(color: Colors.green),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Container(
                  //color: Colors.red,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(blurRadius: 2, color: Colors.black)
                  ]),
                  child: Text(
                    message!,
                    style: check == true
                        ? TextStyle(color: Colors.blue)
                        : TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MessagetoUser {}
