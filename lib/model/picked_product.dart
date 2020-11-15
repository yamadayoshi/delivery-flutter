import 'package:delivery/model/product.dart';
import 'package:flutter/material.dart';

class PickedProduct extends ChangeNotifier {
  final Product _product;
  final String _notes;

  PickedProduct(this._product, this._notes);

  Product get product => _product;
  String get notes => _notes;

  @override
  String toString() {
    return '${_product.toString()} and $_notes';
  }
}
