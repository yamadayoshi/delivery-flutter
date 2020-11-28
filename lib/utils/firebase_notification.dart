import 'dart:async';
import 'dart:convert';

import 'package:delivery/utils/requests.dart';
import 'package:delivery/utils/util.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class FirebaseNotification {
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  static String fcmToken;

  static void configure(BuildContext context) {
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );

    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    firebaseMessaging.getToken().then((token) {
      fcmToken = token;
      Util.getClientId().then((id) => setFirebaseToken(id, token));
      print(token);
    });
  }

  Future messaging() {
    final String serverToken =
        "AAAA9zbQkVQ:APA91bFLXEpeCzw1uBnV1TAW2dqCZiL2aXxn0NrvM-En1VnO3Ws4A9RltzjRn14bxjTv09IxPMaA0Rznb55B678WvlBcWpi4cVQXB6jcQioR5tkkq1SIZbv3LIvyHrrTEkGYvoX6Q8TB";

    Future<Map<String, dynamic>> sendMessage() async {
      await firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: false),
      );

      await post(
        'https://fcm.googleapis.com/fcm/send',
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': 'A notification from delivery app',
              'title': 'Delivery App'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            'to': await firebaseMessaging.getToken(),
          },
        ),
      );

      final Completer<Map<String, dynamic>> completer =
          Completer<Map<String, dynamic>>();

      firebaseMessaging.configure(
          onMessage: (Map<String, dynamic> message) async {
        completer.complete(message);
      });

      return completer.future;
    }
  }
}
