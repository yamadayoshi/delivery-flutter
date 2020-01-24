import 'package:delivery/model/item_list.dart';
import 'package:flutter/material.dart';

import 'components/bottom_button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ItemList> itens = [new ItemList(), new ItemList(), new ItemList()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            Center(
              child: Icon(
                Icons.email,
                size: 70.0,
              ),
            ),
            Expanded(
              flex: 10,
              child: ListView.builder(
                itemCount: itens.length,
                itemBuilder: (BuildContext context, int index) {
                  return itens[index];
                },
              ),
            ),
            BottomButton('Sacola', _callCheckout)
          ],
        ),
      ),
    );
  }

  void _callCheckout() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Container(
                  margin: EdgeInsets.only(top: 12.0),
                  child: Text(
                    'Itens na sacola',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ),
//              Container(child: ListView.builder(itemBuilder: null)),
              BottomButton('Pedir', (){Navigator.pop(context);}),
            ],
          );
        });
  }
}
