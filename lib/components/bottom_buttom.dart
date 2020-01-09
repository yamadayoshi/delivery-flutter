import 'package:flutter/material.dart';

class BottomButtom extends StatefulWidget {
  @override
  _BottomButtomState createState() => _BottomButtomState();
}

class _BottomButtomState extends State<BottomButtom> {
  TextEditingController _controller;
  int qtd = 1;

  @override
  void initState() {
    _controller = new TextEditingController(text: qtd.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.yellowAccent,
        child: Row(
          children: <Widget>[
            quantityController(),
            Expanded(
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Adicionar',
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
              ),
            ),
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
          FloatingActionButton(
            onPressed: removeQtd,
            elevation: 3.0,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.remove,
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12.0, right: 12.0),
            width: 60.0,
            child: TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16.0),
              enabled: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: addQtd,
            elevation: 5.0,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  void removeQtd() {
    if (qtd > 1)
      setState(() {
        _controller.text = (--qtd).toString();
      });
  }

  void addQtd() {
    setState(() {
      _controller.text = (++qtd).toString();
    });
  }
}
