import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final String _hint;
  final Color _hintColor;
  final Color _enabledColor;
  final Color _focusedColor;
  final TextEditingController _textController;
  final bool _passwd;

  RoundedTextField(this._hint, this._hintColor, this._enabledColor,
      this._focusedColor, this._textController, this._passwd);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      child: TextField(
        controller: _textController,
        obscureText: _passwd,
        decoration: InputDecoration(
          hintText: _hint,
          hintStyle: TextStyle(color: _hintColor),
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _enabledColor, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: _focusedColor, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
      ),
    );
  }
}
