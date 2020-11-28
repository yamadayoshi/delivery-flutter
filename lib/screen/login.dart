import 'dart:convert';

import 'package:delivery/component/rounded_icon_text_field.dart';
import 'package:delivery/screen/register.dart';
import 'package:delivery/utils/requests.dart';
import 'package:delivery/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailTextController = TextEditingController();
  final _passwdTextController = TextEditingController();

  bool _emailError = false;
  bool _passwdError = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
            image: AssetImage("images/yellow_splash_back.png"),
            fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomPadding: false,
        body: Builder(
          builder: (contextBuilder) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: Image.asset('images/hamburguer.png',
                      height: 120, width: 120),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 23.0,
                        ),
                      ),
                    ),
                    RoundedIconTextField(
                      Icons.perm_identity,
                      'Email',
                      Colors.grey,
                      Colors.amberAccent,
                      Colors.amberAccent,
                      _emailTextController,
                      false,
                      TextInputAction.next,
                      TextInputType.emailAddress,
                      _emailError,
                      (submit) {
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                    RoundedIconTextField(
                      Icons.lock,
                      'Password',
                      Colors.grey,
                      Colors.amberAccent,
                      Colors.amberAccent,
                      _passwdTextController,
                      true,
                      TextInputAction.done,
                      TextInputType.text,
                      _passwdError,
                      (submit) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          elevation: 5.0,
                          child: MaterialButton(
                            onPressed: () async {
                              //dismiss the keyboard
                              FocusScope.of(context).unfocus();

                              _emailError = _emailTextController.text.isEmpty;
                              _passwdError = _passwdTextController.text.isEmpty;

                              if (!_emailError && !_passwdError) {
                                Response response = await authClient(
                                    '${_emailTextController.text}',
                                    '${_passwdTextController.text}');

                                if (response.body.isNotEmpty &&
                                    response.statusCode == 200) {
                                  Map<String, dynamic> client =
                                      jsonDecode(response.body);

                                  // login user
                                  Util.loginUser(client);

                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      'home', (Route<dynamic> route) => false);
                                } else {
                                  Util.showSnack(
                                      contextBuilder,
                                      'Invalid email or password!',
                                      'Close',
                                      () {});

                                  FocusScope.of(context).nextFocus();
                                }
                              } else {
                                Util.showSnack(
                                    contextBuilder,
                                    'Please fill email and login!',
                                    'OK',
                                    () {});

                                FocusScope.of(context).nextFocus();
                              }
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
                FlatButton(
                  child: Text(
                    'Dont have account? Create here!',
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                  onPressed: () {
                    //dismiss the keyboard
                    FocusScope.of(context).unfocus();

                    Register.callRegister(context);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
