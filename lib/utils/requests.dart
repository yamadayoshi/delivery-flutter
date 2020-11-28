import 'dart:convert';

import 'package:delivery/model/address.dart';
import 'package:delivery/model/client_app.dart';
import 'package:delivery/model/order.dart';
import 'package:delivery/model/picked_product.dart';
import 'package:delivery/utils/constants.dart';
import 'package:http/http.dart';

Future<Response> registerClient(ClientApp client) {
  return post(
    '${Constants.endpoint}api/client/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(
      client.toJson(),
    ),
  );
}

Future<Response> authClient(String email, String passwd) {
  return post('${Constants.endpoint}api/client/auth',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String, String>{'email': email, 'passwd': passwd}));
}

Future<Response> setFirebaseToken(String clientId, String firebaseToken) {
  return put(
    '${Constants.endpoint}api/client/googletoken/$clientId',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, String>{'token': firebaseToken}),
  );
}

Future<Response> getProducts() {
  return get('${Constants.endpoint}api/products');
}

Future<Response> addAddress(Address address, String clientId) {
  return post('${Constants.endpoint}api/address',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(address.toJson(clientId)));
}

Future<Response> getAddressClient(String clientId) {
  return get('${Constants.endpoint}api/address/client/$clientId');
}

Future<Response> addOrder(Order order) {
  return post('${Constants.endpoint}api/order',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(order.toJson()));
}

Future<Response> addOrderItem(List<PickedProduct> itens, int orderId) {
  return post(
    '${Constants.endpoint}api/orderitens',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(
      itens.map((e) => e.toJson(orderId)).toList(),
    ),
  );
}
