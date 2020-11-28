import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Util {
  static Future<String> getClientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt('id') != null ? prefs.getInt('id').toString() : '';
  }

  static Future<String> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString('name') != null ? prefs.getString('name') : '';
  }

  static void loginUser(Map<String, dynamic> client) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int id = client['id'];
    String name = client['name'];
    String email = client['email'];
    String phone = client['phone'];

    if (id.toString().isNotEmpty) await prefs.setInt("id", id);
    if (name.isNotEmpty) await prefs.setString('name', name);
    if (email.isNotEmpty) await prefs.setString("email", email);
    if (phone.isNotEmpty) await prefs.setString("phone", phone);
  }

  static void setAddress(int id, String nickname, String address) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!id.isNaN) await prefs.setString('addressId', id.toString());
    if (nickname.isNotEmpty) await prefs.setString('addressNickname', nickname);
    if (address.isNotEmpty) await prefs.setString('address', address);
  }

  static Future<List<String>> getAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String id = prefs.getString('addressId') != null
        ? prefs.getString('addressId')
        : '';
    String nickname = prefs.getString('addressNickname') != null
        ? prefs.getString('addressNickname')
        : '';
    String addr =
        prefs.getString('address') != null ? prefs.getString('address') : '';

    List<String> address = [id, nickname, addr];

    return address;
  }

  static showSnack(BuildContext context, String text, String labelAction,
      Function function) {
    final snackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: labelAction,
        onPressed: () {},
      ),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
