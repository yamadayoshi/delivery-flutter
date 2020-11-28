import 'dart:convert';

import 'package:delivery/utils/requests.dart';
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

  String get city => _city;
  String get complement => _complement;
  String get neighborhood => _neighborhood;
  String get nickname => _nickname;
  int get number => _number;
  String get public_area => _public_area;
  String get uf => _uf;
  String get zipcode => _zipcode;

  Address(this._id, this._city, this._complement, this._neighborhood,
      this._nickname, this._number, this._public_area, this._uf, this._zipcode);

  @override
  _AddressState createState() => _AddressState();

  static Future<List<Address>> fetchAddress() async {
    String clientId = await Util.getClientId();

    Response response = await getAddressClient(clientId);

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

  Map<String, dynamic> toJson(String clientId) => {
        'client': {'id': clientId},
        'nickname': nickname,
        'zipcode': zipcode,
        'publicArea': public_area,
        'number': number,
        'neighborhood': neighborhood,
        'complement': complement,
        'city': city,
        'uf': uf,
        'status': '1'
      };
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
          title: Text(this.widget._nickname,
              style: TextStyle(fontSize: 18.0), maxLines: 3),
          subtitle: Text(address, style: TextStyle(fontSize: 15.0)),
        ),
      ),
    );
  }
}
