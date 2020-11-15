import 'package:delivery/model/product_checkout.dart';
import 'package:delivery/model/product.dart';
import 'package:delivery/screen/checkout.dart';
import 'package:delivery/screen/product_detail.dart';
import 'package:delivery/utils/firebase_notification.dart';
import 'package:delivery/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RefreshController _refresh = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();

    FirebaseNotification.configure(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SmartRefresher(
          enablePullDown: true,
          controller: _refresh,
          onRefresh: _onRefresh,
          child: Column(
            children: <Widget>[
              // header
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () async {
                        String user = await Util.getUser();

                        if (user.isNotEmpty)
                          Navigator.pushNamed(context, 'client');
                        else
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
                      child: FutureBuilder<String>(
                        future: Util.getUser(), // a Future<String> or null
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return new Text('No connection');
                            case ConnectionState.waiting:
                              return new Text('Awaiting result...');
                            default:
                              if (snapshot.hasError)
                                return new Text('Error: ${snapshot.error}');
                              else {
                                return '${snapshot.data}'.isEmpty
                                    ? FlatButton(
                                        child: Text('Log in'),
                                        color: Colors.orange,
                                        onPressed: () {
                                          Navigator.pushNamed(context, 'login');
                                        },
                                      )
                                    : new Text('${snapshot.data}');
                              }
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: Image.asset('images/hamburguer.png',
                    height: 110, width: 110),
              ),
              // body list
              Expanded(
                flex: 10,
                child: FutureBuilder(
                  future: Product.fetchProduct(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.none)
                      return Text('No connection');
                    else if (!snapshot.hasData)
                      return Center(
                        child: SpinKitThreeBounce(
                          color: Colors.orangeAccent,
                          size: 30.0,
                        ),
                      );
                    else {
                      return snapshot.data.length > 0
                          ? ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ProductDetail(snapshot.data[index]);
                              },
                            )
                          : Center(
                              child: Text('No itens'),
                            );
                    }
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: Stack(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Checkout.callCheckout(context),
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.orangeAccent,
                        child: Text(
                          'Cart',
                          style: TextStyle(fontSize: 22.0),
                        ),
                      ),
                    ),
                    Provider.of<ProductCheckout>(context, listen: true)
                                .getSize() >
                            0
                        ? Positioned(
                            left: MediaQuery.of(context).size.width * 0.85,
                            top: MediaQuery.of(context).size.height * 0.015,
                            child: InkResponse(
                              child: Container(
                                height: 35,
                                width: 35,
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${Provider.of<ProductCheckout>(context, listen: true).getSize()}',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container()
                    // BottomButton('Cart', () => Checkout.callCheckout(context))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onRefresh() async {
    await Product.fetchProduct();

    _refresh.refreshCompleted();
  }
}
