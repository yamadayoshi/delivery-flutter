import 'dart:convert';

import 'package:delivery/component/rounded_address_text_field.dart';
import 'package:delivery/model/address.dart';
import 'package:delivery/utils/requests.dart';
import 'package:delivery/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class AddressRegister {
  static final _nicknameTextController = TextEditingController();
  static final _zipcodeTextController = TextEditingController();
  static final _addressTextController = TextEditingController();
  static final _numberTextController = TextEditingController();
  static final _neighborhoodTextController = TextEditingController();
  static final _cityTextController = TextEditingController();
  static final _complementTextController = TextEditingController();
  static final _ufTextController = TextEditingController();

  static List<bool> fieldErrors = [
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  static callRegister(BuildContext context) async {
    final textFieldFocusNode = FocusNode();
    String userId = await Util.getClientId();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.yellow,
              flexibleSpace: Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: AssetImage("images/linear_yellow_r.png"),
                      fit: BoxFit.fill),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size(double.maxFinite,
                    MediaQuery.of(context).size.height * 0.08),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    focusNode: textFieldFocusNode,
                    controller: _zipcodeTextController,
                    onTap: () {
                      textFieldFocusNode.canRequestFocus = true;
                    },
                    onEditingComplete: () {
                      getAddress(context);
                      textFieldFocusNode.unfocus();
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        color: Colors.black87,
                        onPressed: () async {
                          textFieldFocusNode.unfocus();
                          textFieldFocusNode.canRequestFocus = false;
                          getAddress(context);
                        },
                      ),
                      hintText: "Zipcode",
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            body: Builder(builder: (contextBuilder) {
              return Container(
                child: ListView(
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            RoundedAddressTextField(
                              true,
                              'Nickname',
                              Colors.grey,
                              Colors.amberAccent,
                              Colors.amberAccent,
                              _nicknameTextController,
                              false,
                              TextInputAction.next,
                              TextInputType.text,
                              fieldErrors[0],
                              (submit) {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                            RoundedAddressTextField(
                              false,
                              'Address',
                              Colors.grey,
                              Colors.amberAccent,
                              Colors.amberAccent,
                              _addressTextController,
                              false,
                              TextInputAction.next,
                              TextInputType.text,
                              fieldErrors[1],
                              (submit) {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                            RoundedAddressTextField(
                              true,
                              'Number',
                              Colors.grey,
                              Colors.amberAccent,
                              Colors.amberAccent,
                              _numberTextController,
                              false,
                              TextInputAction.next,
                              TextInputType.number,
                              fieldErrors[2],
                              (submit) {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                            RoundedAddressTextField(
                              false,
                              'Neighborhood',
                              Colors.grey,
                              Colors.amberAccent,
                              Colors.amberAccent,
                              _neighborhoodTextController,
                              false,
                              TextInputAction.next,
                              TextInputType.number,
                              fieldErrors[3],
                              (submit) {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                            RoundedAddressTextField(
                              false,
                              'City',
                              Colors.grey,
                              Colors.amberAccent,
                              Colors.amberAccent,
                              _cityTextController,
                              false,
                              TextInputAction.next,
                              TextInputType.number,
                              fieldErrors[4],
                              (submit) {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                            RoundedAddressTextField(
                              false,
                              'UF',
                              Colors.grey,
                              Colors.amberAccent,
                              Colors.amberAccent,
                              _ufTextController,
                              false,
                              TextInputAction.next,
                              TextInputType.number,
                              fieldErrors[4],
                              (submit) {
                                FocusScope.of(context).nextFocus();
                              },
                            ),
                            RoundedAddressTextField(
                              true,
                              'Complement',
                              Colors.grey,
                              Colors.amberAccent,
                              Colors.amberAccent,
                              _complementTextController,
                              false,
                              TextInputAction.next,
                              TextInputType.text,
                              fieldErrors[4],
                              (submit) {
                                // dismiss keyboard
                                FocusScope.of(context).unfocus();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        color: Colors.deepOrangeAccent,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        elevation: 5.0,
                        child: MaterialButton(
                          onPressed: () {
                            register(context, contextBuilder, userId);
                          },
                          minWidth: 50.0,
                          height: 42.0,
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }

  static void register(
      BuildContext context, BuildContext contextBuilder, String userId) async {
    //dismiss the keyboard
    FocusScope.of(context).unfocus();

    if (_nicknameTextController.text.isNotEmpty &&
        _numberTextController.text.isNotEmpty) {
      Address address = new Address(
          0,
          _cityTextController.text.trim(),
          _complementTextController.text.trim(),
          _neighborhoodTextController.text.trim(),
          _nicknameTextController.text.trim(),
          int.parse(_numberTextController.text.trim()),
          _addressTextController.text.trim(),
          _ufTextController.text.trim(),
          _zipcodeTextController.text.trim());

      Response clientResponse = await addAddress(address, userId);

      if (clientResponse.statusCode == 200) {
        Navigator.popAndPushNamed(context, 'addressManagement');
        _clear();
      } else {
        Util.showSnack(
            contextBuilder,
            'Error registering user, check the connection! ${clientResponse.statusCode}',
            'Close',
            () {});

        FocusScope.of(context).nextFocus();
      }
    } else {
      Util.showSnack(
          contextBuilder, 'Please fill the fields above!', 'Close', () {});

      FocusScope.of(context).nextFocus();
    }
  }

  static void getAddress(BuildContext contextBuilder) async {
    if (_zipcodeTextController.text.isNotEmpty) {
      Response response = await get(
          "https://viacep.com.br/ws/${_zipcodeTextController.text}/json/");

      if (response.statusCode == 200) {
        Map<String, dynamic> address = jsonDecode(response.body);

        if (address.length > 1) {
          _addressTextController.text = address['logradouro'];
          _neighborhoodTextController.text = address['bairro'];
          _cityTextController.text = address['localidade'];
          _ufTextController.text = address['uf'];
        }
      } else
        print('Zipcode doesnt exist');
    }
  }

  static void _clear() {
    _nicknameTextController.clear();
    _zipcodeTextController.clear();
    _addressTextController.clear();
    _numberTextController.clear();
    _neighborhoodTextController.clear();
    _cityTextController.clear();
    _complementTextController.clear();
    _ufTextController.clear();
  }
}
