import 'dart:convert';

import 'package:delivery/utils/constants.dart';
import 'package:delivery/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Address extends StatefulWidget {
  final int _id;
  final String _city;
  final String _complement;
  final String _neighborhood;
  final String _nickname;
  final int _number;
  final String _public_area;
  final String _uf;
  final String _zipcode;

  static List<Address> addressList = [];

  Address(this._id, this._city, this._complement, this._neighborhood,
      this._nickname, this._number, this._public_area, this._uf, this._zipcode);

  @override
  _AddressState createState() => _AddressState();

  static Future<List<Address>> fetchAddress() async {
    String userId = await Util.getUserId();

    final String endpoint =
        '${Constants.endpoint}api/address/client?clientId=$userId';

    print(endpoint);

    Response response = await get(endpoint);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse =
          jsonDecode(Utf8Decoder().convert(response.bodyBytes));

      addressList.clear();

      for (dynamic address in jsonResponse) {
        addressList.add(Address(
            address['id'],
            address['city'],
            address['complement'],
            address['neighborhood'],
            address['nickname'],
            address['number'],
            address['publicArea'],
            address['uf'],
            address['zipcode']));
      }
    }

    return addressList;
  }
}

class _AddressState extends State<Address> {
  @override
  Widget build(BuildContext context) {    
    String address =
        '${this.widget._public_area}, Nº ${this.widget._number}, ${this.widget._neighborhood} - ${this.widget._city} - ${this.widget._uf}';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ListTile(
          onTap: () {
            Util.setAddress(this.widget._id, this.widget._nickname, address);

            Navigator.pushNamed(context, 'completeOrder');
          },
          title: Text(this.widget._nickname, style: TextStyle(fontSize: 18.0), maxLines: 3),
          subtitle: Text(address, style: TextStyle(fontSize: 15.0)),
        ),
      ),
    );
  }
}
