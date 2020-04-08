import 'package:flutter/material.dart';

class RoundedAddressTextField extends StatelessWidget {
  final bool _enabled;
  final String _hint;
  final Color _hintColor;
  final Color _enabledColor;
  final Color _focusedColor;
  final TextEditingController _textController;
  final bool _isPasswd;
  final TextInputAction _action;
  final TextInputType _inputType;
  final bool _hasError;
  final Function _onSubmitted;

  RoundedAddressTextField(
      this._enabled,
      this._hint,
      this._hintColor,
      this._enabledColor,
      this._focusedColor,
      this._textController,
      this._isPasswd,
      this._action,
      this._inputType,
      this._hasError,
      this._onSubmitted);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      child: Container(
        child: TextField(
          controller: _textController,
          obscureText: _isPasswd,
          textInputAction: _action,
          onSubmitted: _onSubmitted,
          keyboardType: _inputType,
          enabled: _enabled,
          decoration: InputDecoration(            
            hintText: _hint,
            hintStyle: TextStyle(color: _hintColor),
            errorBorder: _hasError ? OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
              ),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ):null,
            errorText: _hasError ? 'Please verify the field above':null,
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
      ),
    );
  }
}
