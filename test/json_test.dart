import 'dart:convert';

import 'package:delivery/model/picked_product.dart';
import 'package:delivery/model/product.dart';

void main() {
  List<PickedProduct> productCheck = [];

  productCheck.add(
      PickedProduct(Product(1, 'Xbox', 'Microgame', 4799.00, 'url'), 'New'));
  productCheck.add(PickedProduct(
      Product(1, 'Playstation', 'Sonygame', 4499.00, 'url'), 'New'));

  print(jsonEncode(productCheck.map((e) => e.toJson(5)).toList()));
}
