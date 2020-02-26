import 'package:delivery/model/item_checkout_data.dart';
import 'package:delivery/model/product.dart';
import 'package:delivery/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../component/bottom_button.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // List<ItemList> itens = [
  //   new ItemList(
  //       11, 'Hamburguer de carne', 'Maravilhoso hamburguer da casa', 22.9),
  //   new ItemList(6, 'X Salada', 'Muito alface', 18.5),
  //   new ItemList(21, 'X Egg', 'Caipira', 19.5),
  //   new ItemList(21, 'X Bacon', 'Pork', 23.8)
  // ];

  Future<List<Product>> fetchedProduct;

  @override
  void initState() {
    super.initState();
    fetchedProduct = Product.fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'login');
                    },
                    child: Icon(
                      Icons.supervised_user_circle,
                      color: Colors.deepOrangeAccent,
                      size: 48.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Olá User',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Icon(
                Icons.email,
                size: 70.0,
              ),
            ),
            Expanded(
              flex: 10,
              child: FutureBuilder<List<Product>>(
                future: fetchedProduct,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    SpinKitFadingCircle(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: index.isEven ? Colors.red : Colors.green,
                          ),
                        );
                      },
                    );
                  }
                  if (snapshot.hasError) {

                  }

                  List<Product> productList = snapshot.hasData ? snapshot.data : [];

                  return ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return productList[index];
                    },
                  );
                },
              ),
            ),
            BottomButton('Sacola', _callCheckout)
          ],
        ),
      ),
    );
  }

  void _callCheckout() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 12.0, bottom: 10.0),
              child: Text(
                'Itens na sacola',
                style: TextStyle(fontSize: 22.0),
              ),
            ),
            Expanded(
              flex: 5,
              child: Provider.of<ItemCheckoutData>(context, listen: true)
                          .getSize() >
                      0
                  ? new ListView.builder(
                      itemCount:
                          Provider.of<ItemCheckoutData>(context, listen: true)
                              .getSize(),
                      itemBuilder: (BuildContext context, int index) {
                        return Provider.of<ItemCheckoutData>(context,
                                listen: true)
                            .checkoutList[index];
                      })
                  : Center(
                      child: Text(
                        'Sacola vazia',
                        style: TextStyle(fontSize: 19.0, color: Colors.grey),
                      ),
                    ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.0, bottom: 5.0),
              child: Provider.of<ItemCheckoutData>(context, listen: true)
                          .getSize() >
                      0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('Total: R\$ ', style: TextStyle(fontSize: 20.0)),
                        Text(
                            Constants.currency.format(
                                Provider.of<ItemCheckoutData>(context,
                                        listen: false)
                                    .getTotalValue()),
                            style: TextStyle(fontSize: 20.0))
                      ],
                    )
                  : Container(),
            ),
            Provider.of<ItemCheckoutData>(context, listen: true).getSize() > 0
                ? BottomButton('Pedir', () {
                    Navigator.pop(context);
                  })
                : Container()
          ],
        );
      },
    );
  }
}
