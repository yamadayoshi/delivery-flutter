import 'package:delivery/utils/constants.dart';
import 'package:http/http.dart';
import 'dart:convert' as convert;

class Product {
  final int _id;
  final String _title;
  final String _description;
  final double _price;
  final String _img;

  Product(this._id, this._title, this._description, this._price, this._img);

  int get id => _id;
  String get title => _title;
  String get description => _description;
  double get price => _price;
  String get img => _img;

  static List<Product> productList = [];

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
            product['img']));
      }
    }

    return productList;
  }

  @override
  String toString() {
    return 'name => $title';
  }
}
