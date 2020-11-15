import 'package:cached_network_image/cached_network_image.dart';
import 'package:delivery/component/quantity_count.dart';
import 'package:delivery/component/rounded_button.dart';
import 'package:delivery/model/picked_product.dart';
import 'package:delivery/model/product.dart';
import 'package:delivery/model/product_checkout.dart';
import 'package:delivery/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  final Product _product;

  ProductDetail(this._product);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  TextEditingController _controller;
  int _qtd = 1;

  @override
  void initState() {
    super.initState();
    _controller = new TextEditingController(text: _qtd.toString());
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: callBottomSheet,
      leading: Container(
        width: 75.0,
        child: CachedNetworkImage(
          imageUrl: widget._product.img,
          placeholder: (context, url) => SpinKitThreeBounce(
            color: Colors.grey,
            size: 30.0,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      title: Text(
        widget._product.title,
        style: TextStyle(fontSize: 18.0),
      ),
      subtitle: Text(
        widget._product.description,
        style: TextStyle(fontSize: 14.0),
        maxLines: 2,
      ),
      trailing: Text(
        'R\$ ' + Constants.currency.format(widget._product.price),
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }

  callBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: CachedNetworkImage(
                  imageUrl: widget._product.img,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => SpinKitThreeBounce(
                    color: Colors.grey,
                    size: 30.0,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, bottom: 4.0),
                            child: Text(
                              widget._product.title,
                              style: TextStyle(fontSize: 20.0),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, bottom: 4.0),
                            child: Text(
                              'R\$ ' +
                                  Constants.currency
                                      .format(widget._product.price),
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, bottom: 4.0),
                        child: Text(
                          widget._product.description,
                          style: TextStyle(fontSize: 18.0, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.orangeAccent,
                  child: Row(
                    children: <Widget>[
                      quantityController(),
                      Expanded(
                        child: FlatButton(
                          onPressed: () {
                            for (var i = 0; i < _qtd; i++) {
                              Provider.of<ProductCheckout>(context,
                                      listen: false)
                                  .add(new PickedProduct(widget._product, ''));
                            }

                            Navigator.pop(context);
                          },
                          child: Text(
                            'Adicionar',
                            style:
                                TextStyle(color: Colors.black, fontSize: 15.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget quantityController() {
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 25.0),
      child: Row(
        children: <Widget>[
          RoundedButton(40.0, removeQtd, Colors.white, Icons.remove),
          Container(
              margin: EdgeInsets.only(left: 12.0, right: 12.0),
              width: 60.0,
              child: QuantityCount(16.0, _controller)),
          RoundedButton(40.0, addQtd, Colors.white, Icons.add)
        ],
      ),
    );
  }

  void removeQtd() {
    if (_qtd > 1)
      setState(() {
        _controller.text = (--_qtd).toString();
      });
  }

  void addQtd() {
    setState(() {
      _controller.text = (++_qtd).toString();
    });
  }
}
