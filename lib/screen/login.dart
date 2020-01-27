import 'package:delivery/component/rounded_text_field.dart';
import 'package:delivery/screen/home.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(
            Icons.add_to_queue,
            color: Colors.red,
            size: 100.0,
          ),
          RoundedTextField('Email', Colors.white, Colors.amberAccent, Colors.amberAccent),
          RoundedTextField('Password', Colors.white, Colors.amberAccent, Colors.amberAccent),
          Container(
            margin: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.black87,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Implement registration functionality.
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Create Account',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          FlatButton(
            child: Text(
              'I have an account',
              style: TextStyle(color: Colors.black, fontSize: 15.0),
            ),
            onPressed: () {
              _callLogin();
            },
          )
        ],
      ),
    );
  }

  void _callLogin() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.deepOrangeAccent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              RoundedTextField('Email', Colors.black87, Colors.amberAccent, Colors.amberAccent),
              RoundedTextField('Password', Colors.black87, Colors.amberAccent, Colors.amberAccent),
              Container(

                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.black87,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () {
                        // push home and remove login from stack
                        Navigator.of(context).pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
