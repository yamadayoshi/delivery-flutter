import 'dart:convert';

import 'package:delivery/component/rounded_address_text_field.dart';
import 'package:delivery/utils/constants.dart';
import 'package:delivery/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

class AddressRegister {
  static final _nicknameTextController = TextEditingController();
  static final _cepTextController = TextEditingController();
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
    String userId = await Util.getUserId();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Scaffold(
          body: Builder(builder: (contextBuilder) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Center(
                    child: Text('Address Registration',
                        style: Constants.kTitleTextStyle)),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  focusNode: textFieldFocusNode,
                  controller: _cepTextController,
                  onTap: () {
                    textFieldFocusNode.canRequestFocus = true;
                  },
                  onEditingComplete: () {
                    getAddress();
                    textFieldFocusNode.unfocus();
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () async {
                        textFieldFocusNode.unfocus();
                        textFieldFocusNode.canRequestFocus = false;

                        getAddress();
                      },
                    ),
                    hintText: "CEP",
                    hintStyle: TextStyle(color: Colors.grey),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.amberAccent, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.amberAccent, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Card(
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
                            FocusScope.of(context).dispose();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Material(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                      onPressed: () {
                        register(context, contextBuilder, userId);
                      },
                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
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
      Response userResponse = await get(
          "${Constants.endpoint}api/address/add?clientId=$userId&nickname=${_nicknameTextController.text}&zipcode=${_cepTextController.text}&publicArea=${_addressTextController.text}&number=${_numberTextController.text}&complement=${_complementTextController.text}&neighborhood=${_neighborhoodTextController.text}&city=${_cityTextController.text}&uf=${_ufTextController.text}");

      print(
          "${Constants.endpoint}api/address/add?clientId=$userId&nickname=${_nicknameTextController.text}&zipcode=${_cepTextController.text}&publicArea=${_addressTextController.text}&number=${_numberTextController.text}&complement=${_complementTextController.text}&neighborhood=${_neighborhoodTextController.text}&city=${_cityTextController.text}&uf=${_ufTextController.text}");

      if (userResponse.statusCode == 200) {
        Navigator.popAndPushNamed(context, 'addressManagement');
      } else {
        Util.showSnack(contextBuilder,
            'Error registering user, check the connection!', 'Close', () {});

        FocusScope.of(context).nextFocus();
      }
    } else {
      Util.showSnack(
          contextBuilder, 'Please fill the fields above!', 'Close', () {});

      FocusScope.of(context).nextFocus();
    }
  }

  static void getAddress() async {
    if (_cepTextController.text.isNotEmpty) {
      Response response = await get(
          "https://viacep.com.br/ws/${_cepTextController.text}/json/");

      if (response.statusCode == 200) {
        Map<String, dynamic> address = jsonDecode(response.body);

        _addressTextController.text = address['logradouro'];
        _neighborhoodTextController.text = address['bairro'];
        _cityTextController.text = address['localidade'];
        _ufTextController.text = address['uf'];
      } else
        print(response.statusCode);
    }
  }
}
