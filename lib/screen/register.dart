import 'dart:convert';

import 'package:delivery/component/rounded_icon_text_field.dart';
import 'package:delivery/utils/constants.dart';
import 'package:delivery/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Register {
  static callRegister(BuildContext context) {
    final _nameTextController = TextEditingController();
    final _usernameTextController = TextEditingController();
    final _phoneTextController = TextEditingController();
    final _emailTextController = TextEditingController();
    final _passwdTextController = TextEditingController();

    List<bool> fieldErrors = [false, false, false, false, false];

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: AssetImage("images/yellow_splash_back.png"),
                fit: BoxFit.fill),
          ),
          child: Scaffold(
            backgroundColor: Colors.white10,
            body: Builder(
              builder: (contextBuilder) {
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 60.0, bottom: 20.0),
                        child: Image.asset('images/hamburguer.png',
                            height: 120, width: 120),
                      ),
                      Card(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 30.0, bottom: 20.0),
                              child: Center(
                                  child: Text(
                                'Create Account',
                                style: TextStyle(fontSize: 23.0),
                              )),
                            ),
                            RoundedIconTextField(
                              Icons.perm_identity,
                              'Name',
                              Colors.grey,
                              Colors.amberAccent,
                              Colors.amberAccent,
                              _nameTextController,
                              false,
                              TextInputAction.next,
                              TextInputType.text,
                              fieldErrors[0],
                              (submit) {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                            RoundedIconTextField(
                              Icons.perm_identity,
                              'Username',
                              Colors.grey,
                              Colors.amberAccent,
                              Colors.amberAccent,
                              _usernameTextController,
                              false,
                              TextInputAction.next,
                              TextInputType.text,
                              fieldErrors[1],
                              (submit) {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                            RoundedIconTextField(
                              Icons.phone,
                              'Phone',
                              Colors.grey,
                              Colors.amberAccent,
                              Colors.amberAccent,
                              _phoneTextController,
                              false,
                              TextInputAction.next,
                              TextInputType.number,
                              fieldErrors[2],
                              (submit) {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                            RoundedIconTextField(
                              Icons.email,
                              'Email',
                              Colors.grey,
                              Colors.amberAccent,
                              Colors.amberAccent,
                              _emailTextController,
                              false,
                              TextInputAction.next,
                              TextInputType.emailAddress,
                              fieldErrors[3],
                              (submit) {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                            RoundedIconTextField(
                              Icons.visibility_off,
                              'Password',
                              Colors.grey,
                              Colors.amberAccent,
                              Colors.amberAccent,
                              _passwdTextController,
                              true,
                              TextInputAction.next,
                              TextInputType.text,
                              fieldErrors[4],
                              (submit) {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                            Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Material(
                                  color: Colors.deepOrangeAccent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                  elevation: 5.0,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      fieldErrors = [
                                        _nameTextController.text.isEmpty,
                                        _usernameTextController.text.isEmpty,
                                        !(_phoneTextController.text.length >= 10),
                                        !_emailTextController.text.contains('@') || !_emailTextController.text.contains('.com'),
                                        !(_passwdTextController.text.length >= 8)
                                      ];

                                      //dismiss the keyboard
                                      FocusScope.of(context).unfocus();

                                      if (validFields(fieldErrors)) {
                                        Response userResponse = await get(
                                            "${Constants.endpoint}api/client/add?name=${_nameTextController.text}&username=${_usernameTextController.text}&passwd=${_passwdTextController.text}&email=${_emailTextController.text}&phone=${_phoneTextController.text}");

                                        if (userResponse.statusCode == 200) {
                                          Map<String, dynamic> client = jsonDecode(userResponse.body);

                                          // login user
                                          Util.loginUser(client);                                          
                                          
                                          // push home and remove login from stack
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  'home',
                                                  (Route<dynamic> route) =>
                                                      false);
                                        } else {
                                          Util.showSnack(
                                              contextBuilder,
                                              'Error registering user, check the connection!',
                                              'Close',
                                              () {});

                                          FocusScope.of(context).nextFocus();
                                        }
                                      } else {
                                        Util.showSnack(
                                            contextBuilder,
                                            'Please fill the fields above!',
                                            'Close',
                                            () {});
                                        
                                        FocusScope.of(context).nextFocus();
                                      }
                                    },
                                    minWidth: 200.0,
                                    height: 42.0,
                                    child: Text(
                                      'Create',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  static bool validFields(var list) {
    for (bool item in list) {
      if (item) return false;
    }

    return true;
  }
}
