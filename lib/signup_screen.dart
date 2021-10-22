import 'package:ecommerce/login.dart';
import 'package:ecommerce/services.dart';
import 'package:ecommerce/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late String Email;
  late String Password;
  FirebaseAuthe _services = FirebaseAuthe();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 1.8,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'Images/login.jpg',
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(15),
                  //     topRight: Radius.circular(15)),
                  // boxShadow: [
                  //   BoxShadow(
                  //     blurRadius: 2,
                  //     color: Colors.pink,
                  //     offset: Offset(1, 0),
                  //   ),
                  // ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign up',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextField(
                        onChanged: (value) {
                          Email = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: 'E-mail',
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextField(
                        obscureText: true,
                        onChanged: (value) {
                          Password = value;
                        },
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.visibility,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: 'Password',
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () async {
                            final user = await _services.SignupwithEmail(
                                Email, Password);
                            final storing =
                                await _services.StoreData(Email, Password);
                            if (user != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WelcomeScreen(),
                                ),
                              );
                            } else {
                              final snackBar = SnackBar(
                                content: Text('Account Already exist'),
                                action: SnackBarAction(
                                  label: 'Sign in',
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  },
                                ),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: Container(
                            height: 45,
                            // width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(11),
                              color: kbtnclr,
                            ),
                            child: Center(
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
