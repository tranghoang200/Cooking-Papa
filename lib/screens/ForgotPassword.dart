import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  /*
  This widget is build when the user hit the forget password button
  in the login page. The user interface is very simple and easy to understand.
  When the user hit the "Forget Password" button, it will should up another
  interface which the user can enter their email and an link will be send to their
  mail account if the account is existed on the system.
   */
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
          gradient:
          new LinearGradient(colors: [Color(0xffffc0cb), Colors.pinkAccent[100]])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              height: height * 0.15,
            ),
            Container(
              margin: EdgeInsets.only(top: height * 0.15),
              height: height * 0.85,
              decoration: BoxDecoration(
                  color: Colors.white, //color of the rectangle box
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: ListView(
                children: [
                  SizedBox(height: height * 0.08),
                  Text(
                    'Forget password'.toUpperCase(),
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Center(
                    child: Container(
                      height: 1,
                      width: width * 0.8,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.15,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.05),
                    child: TextField(
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Your Email * ",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.bold, letterSpacing: 1.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.blue),
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.all(12),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: Colors.grey),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.08,
                  ),
                  Center(
                    child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                      decoration: BoxDecoration(
                          gradient: new LinearGradient(
                              colors: [ Color(0xffffc0cb), Colors.pinkAccent[100]]),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                color: Colors.pinkAccent[200],
                                offset: Offset(2, 2))
                          ]),
                      child: Text(
                        "Reset".toUpperCase(), //when you hit the "Reset" button then your email account will receive a link that you can click in and reset
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.7),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}