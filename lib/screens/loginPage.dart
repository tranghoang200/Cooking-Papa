import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class loginPage extends StatefulWidget {

  @override
  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle> (
        value: SystemUiOverlayStyle.light,
        child: GestureDetector (
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffffc0cb), //first ff is the opacity
                      Color(0xffffc0cb), //if want to change color than change
                      Color(0xffffc0cb), //hex-code after ff
                      Color(0xffffc0cb),
                    ]
                  )
                ),
                child: Column (
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


