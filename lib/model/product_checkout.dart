import 'package:delivery/model/picked_product.dart';
import 'package:flutter/material.dart';

class ProductCheckout extends ChangeNotifier {
  List<PickedProduct> pickedProdList = [];

  void add(PickedProduct pickedProduct) {
    pickedProdList.add(pickedProduct);
    notifyListeners();

    print(pickedProdList.toList());
  }

  void delete(int index) {
    pickedProdList.removeAt(index);
    notifyListeners();

    print(pickedProdList.toList());
  }

  bool clear() {
    pickedProdList.clear();

    return pickedProdList.length == 0;
  }

  int getSize() {
    return pickedProdList.length;
  }

  double getTotalValue() {
    double total = 0.0;

    pickedProdList.forEach((item) => {total += item.product.price});

    return total;
  }

  @override
  String toString() {
    String item = pickedProdList.last.product.title;
    String value = pickedProdList.last.product.price.toString();

    return 'Last item: item=$item, val=$value';
  }
}
