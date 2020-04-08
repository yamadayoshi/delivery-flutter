import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/component/quantity_button.dart';
import 'package:delivery/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

class Product extends StatefulWidget {
  final int _id;
  final String _title;
  final String _description;
  final double _price;
  final int _status;
  // final DateTime _registration;

  static List<Product> productList = [];

  Product(this._id, this._title, this._description, this._price, this._status);

  @override
  _ProductState createState() => _ProductState();

  static Future<List<Product>> fetchProduct() async {
    final String endpoint = "${Constants.endpoint}api/products";

    Response response = await get(endpoint);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = convert.jsonDecode(response.body);

      productList.clear();

      for (dynamic product in jsonResponse) {
        productList.add(Product(
            product['id'],
            product['name'],
            product['description'],
            product['price'] as double,
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
      leading: Container(
        width: 75.0,
        child: CachedNetworkImage(
          imageUrl: "${Constants.endpoint}/product/image/${this.widget._id}",
          placeholder: (context, url) => SpinKitThreeBounce(
            color: Colors.grey,
            size: 30.0,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      title: Text(
        this.widget._title,
        style: TextStyle(fontSize: 18.0),
      ),
      subtitle: Text(
        this.widget._description,
        style: TextStyle(fontSize: 14.0),
        maxLines: 2,
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
                flex: 2,
                child: CachedNetworkImage(
                  imageUrl:
                      "${Constants.endpoint}/product/image/${this.widget._id}",
                  placeholder: (context, url) => SpinKitThreeBounce(
                    color: Colors.grey,
                    size: 30.0,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Divider(),
              Expanded(
                flex: 4,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 4.0),
                      child: Text(
                        this.widget._title,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 4.0),
                      child: Text(
                        'R\$ ' + Constants.currency.format(this.widget._price),
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 4.0),
                      child: Text(
                        this.widget._description,
                        style: TextStyle(fontSize: 18.0, color: Colors.grey),
                      ),
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
