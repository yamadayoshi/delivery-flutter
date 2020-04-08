import 'package:delivery/component/bottom_button.dart';
import 'package:delivery/model/address.dart';
import 'package:delivery/screen/address_register.dart';
import 'package:delivery/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AddressManagement extends StatefulWidget {
  @override
  _AddressManagementState createState() => _AddressManagementState();
}

class _AddressManagementState extends State<AddressManagement> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: Address.fetchAddress(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: SpinKitThreeBounce(
                  color: Colors.orangeAccent,
                  size: 30.0,
                ),
              );
            else {
              return snapshot.data.length > 0
                  ? Flex(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 20.0, bottom: 10.0),
                          child:
                              Text('Address', style: Constants.kTitleTextStyle),
                        ),
                        Expanded(
                          flex: 12,
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return snapshot.data[index];
                            },
                          ),
                        ),
                        BottomButton('Add address', () {
                          AddressRegister.callRegister(context);
                        })
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('No address registered'),
                          FlatButton(
                            color: Colors.yellow,
                            child: Text('Register Address'),
                            onPressed: () {
                              AddressRegister.callRegister(context);
                            },
                          )
                        ],
                      ),
                    );
            }
          },
        ),
      ),
    );
  }
}
