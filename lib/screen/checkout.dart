import 'package:delivery/component/bottom_button.dart';
import 'package:delivery/model/item_checkout_data.dart';
import 'package:delivery/screen/address_management.dart';
import 'package:delivery/utils/constants.dart';
import 'package:delivery/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Checkout {
  static callCheckout(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 12.0, bottom: 10.0),
              child: Text(
                'Itens in cart',
                style: Constants.kTitleTextStyle,
              ),
            ),
            Provider.of<ItemCheckoutData>(context, listen: true).getSize() == 0
                ? Expanded(
                    child: Center(
                      child: Text(
                        'Cart is empty',
                        style: TextStyle(fontSize: 19.0, color: Colors.grey),
                      ),
                    ),
                  )
                : Expanded(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: ListView.builder(
                            itemCount: Provider.of<ItemCheckoutData>(context,
                                    listen: true)
                                .getSize(),
                            itemBuilder: (BuildContext context, int index) {
                              return Provider.of<ItemCheckoutData>(context,
                                      listen: true)
                                  .checkoutList[index];
                            },
                          ),
                        ),
                        Divider(),
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
                          'Pedir',
                          () async {
                            String user = await Util.getUser();

                            if (user.isEmpty)
                              Navigator.pushNamed(context, 'login');
                            else
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AddressManagement(),
                                ),
                              );
                          },
                        )
                      ],
                    ),
                  ),
          ],
        );
      },
    );
  }
}
