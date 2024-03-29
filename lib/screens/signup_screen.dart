import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _firstName = new TextEditingController();
  final _lastName = new TextEditingController();
  final _email = new TextEditingController();
  final _password = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firstName = TextFormField(
      autofocus: false,
      controller: _firstName,
      keyboardType: TextInputType.name,
      // onSaved: (value)
      //   {
      //     _email.text = value!;
      //   },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final lastName = TextFormField(
      autofocus: false,
      controller: _lastName,
      keyboardType: TextInputType.name,
      // onSaved: (value)
      //   {
      //     _email.text = value!;
      //   },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final email = TextFormField(
      autofocus: false,
      controller: _email,
      keyboardType: TextInputType.emailAddress,
      // onSaved: (value)
      //   {
      //     _email.text = value!;
      //   },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final password = TextFormField(
      autofocus: false,
      controller: _password,
      obscureText: true,
      // onSaved: (value)
      // {
      //   _email.text = value!;
      // },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final signUpBtn = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.white,
      child: MaterialButton(
        padding: EdgeInsets.all(15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () async {
          try {
            UserCredential userCredential = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _email.text, password: _password.text);
            final user = FirebaseAuth.instance.currentUser;
            final uid = user.uid;
            DatabaseReference ref = FirebaseDatabase.instance.ref();
            await ref
                .update({
                  uid: {
                    "favorite": {
                      0: {
                        'title': 'sample',
                        'image': 'sample',
                        'id': 1,
                        'servings': 'sample',
                        'readyInMinutes': 35,
                        'instructions': '',
                        'extendedIngredients': '',
                        'summary': ''
                      }
                    }
                  }
                })
                .then((value) => Navigator.of(context).pushNamed('/'))
                .catchError((error) => print(error));
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("Weak password!"),
                  content: Text("The password provided is too weak."),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text("Ok"),
                    ),
                  ],
                ),
              );
            } else if (e.code == 'email-already-in-use') {
              return showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("Email already in use!"),
                  content: Text("The account already exists for that email."),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text("Ok"),
                    ),
                  ],
                ),
              );
            }
          } catch (e) {
            print(e);
          }
        },
        child: Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Color(0xff834d47),
              fontWeight: FontWeight.bold),
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Color(0xffffc0cb),
        body: Center(
          child: SingleChildScrollView(
              child: Container(
                  color: Colors.white,
                  child: Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 200,
                              // child: Image.asset(name),
                            ),
                            firstName,
                            SizedBox(height: 20),
                            lastName,
                            SizedBox(height: 20),
                            email,
                            SizedBox(height: 20),
                            password,
                            SizedBox(height: 20),
                            signUpBtn,
                            SizedBox(height: 15),
                          ],
                        ),
                      )))),
        ));
  }
}
