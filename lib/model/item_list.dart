import 'package:delivery/components/bottom_buttom.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  List itens = [
    'Hamburguer de carne',
    'Maravilhoso hamburguer da casa',
    'R\$22,90'
  ];

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
            itens[0],
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            itens[1],
            style: TextStyle(fontSize: 15.0),
          ),
          Text(
            itens[2],
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
                flex: 5,
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.all_inclusive,
                      size: 80.0,
                    ),
                    Text(
                      itens[0],
                      style: TextStyle(fontSize: 22.0),
                    ),
                    Text(
                      itens[1],
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              BottomButtom(),
            ],
          ),
        );
      },
    );
  }
}
