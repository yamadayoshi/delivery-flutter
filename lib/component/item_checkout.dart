import 'package:delivery/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ItemCheckout extends StatelessWidget {
  final int _id;
  final int _qtd;
  final String _item;
  final double _value;

  ItemCheckout(this._id, this._qtd, this._item, this._value);

  int get id => _id;

  int get qtd => _qtd;

  String get item => _item;

  double get value => _value;

  @override
  Widget build(BuildContext context) {
    String value = Constants.currency.format(_value);

    return Container(
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Text(
              '$_qtd x',
              style: TextStyle(fontSize: 18.0),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(left: 15.0),
              child: Text(
                _item,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: Text(
              'R\$ $value',
              style: TextStyle(fontSize: 19.0),
            ),
          )
        ],
      ),
    );
  }
}
