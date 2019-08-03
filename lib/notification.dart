import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:store_transaction/message.dart';
import 'message.dart';

class SendNotification extends StatefulWidget {
  @override
  _SendNotificationState createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
  final FirebaseMessaging _messaging = FirebaseMessaging();
  final List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    firebaseCloudMessagingListener();
  }
  void firebaseCloudMessagingListener() {

      _messaging.getToken().then((token){
          print('messaging token: '+token);
      });

      _messaging.configure(
        onLaunch: (Map<String, dynamic> message) async {
          print('on Launch $message');
        },
        onMessage: (Map<String, dynamic> message) async {
           print('on Message: $message');
          //  final notification = message['notification'];
          //  setState(() {
          //    print(notification['title']);
          //  });
        },
        onResume: (Map<String, dynamic> message) async {
           print('on Resume: $message');
        }
      );
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),

    );
  }
}