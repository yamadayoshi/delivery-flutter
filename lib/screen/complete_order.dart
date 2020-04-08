import 'package:delivery/component/bottom_button.dart';
import 'package:delivery/component/item_checkout.dart';
import 'package:delivery/model/item_checkout_data.dart';
import 'package:delivery/screen/home.dart';
import 'package:delivery/utils/constants.dart';
import 'package:delivery/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class CompleteOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: Util.getAddress(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: SpinKitThreeBounce(
                  color: Colors.orangeAccent,
                  size: 30.0,
                ),
              );
            else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text('Order details',
                              style: Constants.kTitleTextStyle),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Delivery address',
                              style: TextStyle(fontSize: 17.0)),
                          Text(snapshot.data[1],
                              style: TextStyle(fontSize: 16.0)),
                          Text(snapshot.data[2],
                              style: TextStyle(fontSize: 16.0), maxLines: 3),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Card(
                      child: ListView.builder(
                        itemCount:
                            Provider.of<ItemCheckoutData>(context, listen: true)
                                .getSize(),
                        itemBuilder: (BuildContext context, int index) {
                          return Provider.of<ItemCheckoutData>(context,
                                  listen: true)
                              .checkoutList[index];
                        },
                      ),
                    ),
                  ),
                  Padding(
                          padding: EdgeInsets.only(
                              top: 8.0, left: 12.0, right: 12.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Total: ', style: TextStyle(fontSize: 21.0)),
                              Text(
                                  'R\$ ${Constants.currency.format(Provider.of<ItemCheckoutData>(context, listen: false).getTotalValue())}',
                                  style: TextStyle(fontSize: 20.0))
                            ],
                          ),
                        ),
                  BottomButton(
                    'Order',
                    () {
                      _completeOrder(context, snapshot.data[0]);
                    },
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void _completeOrder(BuildContext context, String addressId) async {
    String userId = await Util.getUserId();

    print('${Constants.endpoint}api/order/add?clientId=$userId&addressId=$addressId&itens=${prepareItens(context)}&status=1&notes=Tocar a campainha');

    Response response = await get(
        '${Constants.endpoint}api/order/add?clientId=$userId&addressId=$addressId&itens=${prepareItens(context)}&status=1&notes=Tocar a campainha');

    if (response.statusCode == 200) {
      Provider.of<ItemCheckoutData>(context, listen: false)
          .checkoutList
          .clear();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => Home()),
          (Route<dynamic> route) => false);
    } else
      print('Error ${response.statusCode}');
  }

  String prepareItens(BuildContext context) {
    StringBuffer orderItens = new StringBuffer();
    int count = 0;
    List<ItemCheckout> itens =
        Provider.of<ItemCheckoutData>(context, listen: false).checkoutList;

    for (ItemCheckout item in itens) {
      count++;

      String isFinal = itens.length != count ? ";" : "";
      orderItens.write('${item.id.toString()},${item.qtd},Notes$isFinal');
    }

    return orderItens.toString();
  }
}
