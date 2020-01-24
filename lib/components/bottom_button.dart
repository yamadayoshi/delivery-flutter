import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String name;
  final Function func;

  BottomButton(this.name, this.func);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: func,
        child: Container(
          alignment: Alignment.center,
          color: Colors.orangeAccent,
          child: Text(
            name,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
