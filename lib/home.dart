import 'package:delivery/model/item_list.dart';
import 'package:flutter/material.dart';

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
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.center,
                color: Colors.orangeAccent,
                child: Text(
                  'Sacola',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
