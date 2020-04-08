import 'package:delivery/component/item_checkout.dart';
import 'package:delivery/component/quantity_count.dart';
import 'package:delivery/component/rounded_button.dart';
import 'package:delivery/model/item_checkout_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuantityButton extends StatefulWidget {
  final int _id;
  final String _title;
  final double _price;

  QuantityButton(this._id, this._title, this._price);

  @override
  _QuantityButtonState createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  TextEditingController _controller;
  int _qtd = 1;

  @override
  // ignore: must_call_super
  void initState() {
    _controller = new TextEditingController(text: _qtd.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.orangeAccent,
        child: Row(
          children: <Widget>[
            quantityController(),
            Expanded(
              child: FlatButton(
                onPressed: () {
                  Provider.of<ItemCheckoutData>(context, listen: false).addItem((new ItemCheckout(widget._id, _qtd, widget._title, widget._price)));
                  print(Provider.of<ItemCheckoutData>(context, listen: false).toString());

                  Navigator.pop(context);
                },
                child: Text(
                  'Adicionar',
                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                ),
              ),
            )
          ],
        ),
      ),
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
