import 'package:delivery/component/quantity_button.dart';
import 'package:delivery/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

class Product extends StatefulWidget {
  final int _id;
  final String _title;
  final String _description;
  final double _price;
  final String _img;
  final int _status;
  // final DateTime _registration;

  static List<Product> productList = [];

  Product(this._id, this._title, this._description, this._price, this._img, this._status);

  @override
  _ProductState createState() => _ProductState();

  static Future<List<Product>> fetchProduct() async {
    final String endpoint = "http://192.168.0.102:8080/api/products";

    Response response = await get(endpoint);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = convert.jsonDecode(response.body);      

      for (dynamic product in jsonResponse) {
        productList.add(Product(
            product['id'],
            product['name'],
            product['description'],
            product['price'] as double,
            product['img'],
            product['status']));
      }
    }

    return productList;
  }
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _callBottomSheet,
      leading: Icon(
        Icons.all_inclusive,
        size: 55.0,
      ),
      title: Text(
        this.widget._title,
        style: TextStyle(fontSize: 18.0),
      ),
      subtitle: Text(
        this.widget._description,
        style: TextStyle(fontSize: 15.0),
      ),
      trailing: Text(
        'R\$ ' + Constants.currency.format(this.widget._price),
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  void _callBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.all_inclusive,
                      size: 80.0,
                    ),
                    Text(
                      this.widget._title,
                      style: TextStyle(fontSize: 22.0),
                    ),
                    Text(
                      this.widget._description,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              QuantityButton(
                  this.widget._id, this.widget._title, this.widget._price),
            ],
          ),
        );
      },
    );
  }
}
