import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ItemList extends StatefulWidget {
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
            'Item title',
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            'Nosso classico da casa que de mais, nao e mesmo, ne',
            style: TextStyle(fontSize: 15.0),
          ),
          Text(
            'R\$23,90',
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
                      'Item title',
                      style: TextStyle(fontSize: 22.0),
                    ),
                    Text(
                      'Item title',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Container(
                      child: FlatButton(
                        onPressed: null,
                        child: Text(
                          'Adicionar',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            '-',
                            style: TextStyle(
                                color: Colors.black26, fontSize: 40.0),
                          ),
                        ),
                        FlatButton(
                          child: Text(
                            '+',
                            style: TextStyle(
                                color: Colors.black26, fontSize: 40.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
