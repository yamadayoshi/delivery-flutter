import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/model/picked_product.dart';
import 'package:delivery/utils/constants.dart';
import 'package:flutter/material.dart';

class CheckoutProduct extends StatelessWidget {
  final PickedProduct _pickedProduct;

  CheckoutProduct(this._pickedProduct);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ListTile(
        leading: CachedNetworkImage(imageUrl: _pickedProduct.product.img),
        title: Text(
          _pickedProduct.product.title,
          style: TextStyle(fontSize: 18.0),
        ),
        trailing: Text(
          'R\$ ${Constants.currency.format(_pickedProduct.product.price)}',
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
