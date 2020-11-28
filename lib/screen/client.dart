import 'package:delivery/component/rounded_text_field.dart';
import 'package:delivery/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Client extends StatelessWidget {
  final List<String> options = ['Profile', 'Address'];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.supervised_user_circle,
                      color: Colors.deepOrangeAccent,
                      size: 70.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: FutureBuilder<String>(
                        future: Util.getUser(), // a Future<String> or null
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return new Text('Press button to start');
                            case ConnectionState.waiting:
                              return new Text('Awaiting result...');
                            default:
                              if (snapshot.hasError)
                                return new Text('Error: ${snapshot.error}');
                              else
                                return new Text('${snapshot.data}',
                                    style: TextStyle(fontSize: 20.0));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: ListView.separated(
                  padding: EdgeInsets.all(10.0),
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        if (index == 1) _callAddress(context);
                      },
                      child: Container(
                          height: 28.0,
                          child: Text(
                            options[index],
                            style: TextStyle(fontSize: 18.0),
                          ),
                          margin: EdgeInsets.all(5.0)),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: FlatButton(
                  child: Text('Log out', style: TextStyle(fontSize: 18.0)),
                  color: Colors.redAccent,
                  onPressed: () async {
                    SharedPreferences shared =
                        await SharedPreferences.getInstance();

                    shared.clear();

                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _callAddress(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          children: <Widget>[
            RoundedTextField('Address', Colors.grey, Colors.amberAccent,
                Colors.amberAccent, null, false)
          ],
        );
      },
    );
  }
}
