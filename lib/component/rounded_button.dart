import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final double _size;
  final Function _function;
  final Color _color;
  final IconData _icon;

  RoundedButton(this._size, this._function, this._color, this._icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _size,
      child: FloatingActionButton(
        onPressed: _function,
        elevation: 3.0,
        backgroundColor: _color,
        child: Icon(
          _icon,
          color: Colors.black,
        ),
      ),
    );
  }
}
