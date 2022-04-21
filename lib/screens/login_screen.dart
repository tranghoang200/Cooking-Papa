import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cooking_papa/screens/ForgotPassword.dart';

/*
Contribute by Vuong Nguyen (Jay)
This class is called "LoginPage" which responsible for the
login page of the app when the app is first open. The class
has different widget for different purposes as you can see below.
 */

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  bool isRememberMe = false;
  /*
  The widget buildEmail will create a white rectangle box
  which include the email icon and the text said "Email"
  before the user enter their email.
   */
  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.email, color: Color(0xffe44c62)),
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  /*
  The widget buildPassword will also create a white rectangle box
  that has the same width and length as email rectangle box. It will
  contain the lock icon as well as the text "Password" before the
  user enter their actual password.
   */
  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
            obscureText: true,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.lock, color: Color(0xffe44c62)),
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  /*
  This widget buildForgotPassBtn is used to create a button that
  appear on the login screen as "Forgot Password" which later will
  allow the user to get their password back when they forget. The
  button is under the Password Rectangle at the right of the screen.
   */
  Widget buildForgotPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
        },
        padding: EdgeInsets.only(right: 0),
        child: Text(
          'Forgot Password',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /*
  The widget buildRememberMe will create a small white check box
  next to the text "Remember Me" which later during the term will
  allow user skip the step of entering their email and password
  when they try to re-open the app.
   */
  Widget buildRememberMe() {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  isRememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember Me',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  /*
  The widget buildLoginBtn is a simple white rectangle button which
  allow the user to login after they enter correct email and password.
   */
  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5,
        onPressed: () => Navigator.of(context).pushNamed('/'),
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
              color: Color(0xff834d47),
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  /*
  The widget buildSignUpBtn is a button for the user to sign up when
  they are first time user.
   */
  Widget buildSignUpBtn() {
    return GestureDetector(
      onTap: () => print("Sign Up Pressed"), //print statement
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: 'Don\'t have an Account? ',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
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
                    ])),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: 25, //responsible for the email box
                      vertical: 120),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Welcome to Cooking Papa',
                        style: TextStyle(
                            fontFamily: 'lobster',
                            color: Colors.redAccent,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 50),
                      buildEmail(),
                      SizedBox(height: 30),
                      buildPassword(),
                      buildForgotPassBtn(),
                      buildRememberMe(),
                      buildLoginBtn(),
                      buildSignUpBtn(),
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
