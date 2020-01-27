import 'package:delivery/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/item_checkout_data.dart';
import 'screen/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ItemCheckoutData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
        routes: <String, WidgetBuilder> {
          'login': (BuildContext context) => new Login(),
          'home':  (BuildContext context) => new Home(),
        },
      ),
    );
  }
}