import 'package:delivery/component/item_checkout.dart';
import 'package:delivery/component/quantity_button.dart';
import 'package:delivery/utils/constants.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  final int _id;
  final String _title;
  final String _description;
  final double _price;

  ItemList(this._id, this._title, this._description, this._price);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _callBottomSheet,
      leading: Icon(
        Icons.all_inclusive,
        size: 55.0,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            this.widget._title,
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            this.widget._description,
            style: TextStyle(fontSize: 15.0),
          ),
          Text(
            'R\$' + Constants.currency.format(this.widget._price),
            style: TextStyle(fontSize: 18.0),
          )
        ],
      ),
    );
  }

  void _callBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.all_inclusive,
                      size: 80.0,
                    ),
                    Text(
                      this.widget._title,
                      style: TextStyle(fontSize: 22.0),
                    ),
                    Text(
                      this.widget._description,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              QuantityButton(this.widget._id, this.widget._title, this.widget._price),
            ],
          ),
        );
      },
    );
  }
}