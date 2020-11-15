import 'package:delivery/screen/address_management.dart';
import 'package:delivery/screen/client.dart';
import 'package:delivery/screen/complete_order.dart';
import 'package:delivery/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/product_checkout.dart';
import 'screen/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProductCheckout())
      ],
      child: MaterialApp(
        title: 'Delivery',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
        routes: <String, WidgetBuilder>{
          'login': (BuildContext context) => new Login(),
          'home': (BuildContext context) => new Home(),
          'client': (BuildContext context) => new Client(),
          'addressManagement': (BuildContext context) =>
              new AddressManagement(),
          'completeOrder': (BuildContext context) => new CompleteOrder(),
        },
      ),
    );
  }
}
