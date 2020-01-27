import 'package:flutter/material.dart';

class QuantityCount extends StatelessWidget {
  final double _size;
  final TextEditingController _controller;

  QuantityCount(this._size, this._controller);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: _size),
      enabled: false,
      decoration: InputDecoration(
        contentPadding:
        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
    );
  }
}
