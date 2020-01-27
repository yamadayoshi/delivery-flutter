import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String name;
  final Function function;

  BottomButton(this.name, this.function);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: function,
        child: Container(
          alignment: Alignment.center,
          color: Colors.orangeAccent,
          child: Text(
            name,
            style: TextStyle(fontSize: 22.0),
          ),
        ),
      ),
    );
  }
}
