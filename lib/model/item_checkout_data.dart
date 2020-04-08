import 'package:delivery/component/item_checkout.dart';
import 'package:flutter/material.dart';

class ItemCheckoutData extends ChangeNotifier {
  List<ItemCheckout> checkoutList = [];

  void addItem(ItemCheckout item) {
    checkoutList.add(item);
    notifyListeners();
  }

  deleteItem(int index) {
    checkoutList.removeAt(index).item;
    notifyListeners();
  }

  bool clear() {
    checkoutList.clear();

    return checkoutList.length == 0;
  }

  int getSize() {
    return checkoutList.length;
  }

  double getTotalValue() {
    double total = 0.0;

    checkoutList.forEach((item) => {total += (item.qtd * item.value)});

    return total;
  }

  @override
  String toString() {
    String qtd = checkoutList.last.qtd.toString();
    String item = checkoutList.last.item;
    String value = checkoutList.last.value.toString();

    return 'Last item: qtd=$qtd, item=$item, val=$value';
  }
}
