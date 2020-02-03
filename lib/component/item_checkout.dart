import 'package:delivery/model/item_checkout_data.dart';
import 'package:delivery/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

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
    int itemIndex = Provider.of<ItemCheckoutData>(context, listen: false).checkoutList.indexOf(this);

    return ListTile(
      onTap: () {
        showDialog<bool>(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text('Delete item?'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Yes'),
                  onPressed: () {
                    Provider.of<ItemCheckoutData>(context, listen: false).deleteItem(itemIndex);
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  isDefaultAction: false,
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            );
          },
        );
      },
      leading: Text(
        '$_qtd x',
        style: TextStyle(fontSize: 18.0),
      ),
      title: Text(
        _item,
        style: TextStyle(fontSize: 18.0),
      ),
      trailing: Text(
        'R\$ $value',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
