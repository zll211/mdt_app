import 'dart:io';

import 'package:com.hzztai.mdt/common/services/http_service.dart';
import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

typedef OnMessage = void Function(Map<String, dynamic> message);
typedef OnRegistration = void Function(String id);

class JPushNotify {
  final JPush jpush = new JPush();
  final OnRegistration onRegistration;
  final OnMessage onReceiveNotification;
  final OnMessage onOpenNotification;
  final OnMessage onReceiveMessage;

  JPushNotify({this.onRegistration, this.onReceiveNotification, this.onOpenNotification, this.onReceiveMessage}) {
    // Platform messages may fail, so we use a try/catch PlatformException.
    jpush.getRegistrationID().then((rid) {
      print('flutter getRegistrationID: $rid');
      if (onRegistration != null) onRegistration(rid);
    });

    jpush.setup(
      appKey: "8504f04d21bb2b34e5c7bd03",
      channel: "developer-default",
      production: false,
      debug: true,
    );
//    jpush.applyPushAuthority(new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    try {
      jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          print("flutter onReceiveNotification: $message");
          if (onReceiveNotification != null) onReceiveNotification(message);
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          print("flutter onOpenNotification: $message");
          if (onOpenNotification != null) onOpenNotification(message);
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          print("flutter onReceiveMessage: $message");
          if (onReceiveMessage != null) onReceiveMessage(message);
        },
      );
    } on PlatformException {}
  }

  /// 上报极光 id 和 平台
  static Future<void> reportId(String id) async {
    await HttpService.post('/jpush_bind', {
      'registration_id': id,
      'platform': Platform.isIOS ? 'ios' : 'Android'
    }, needAuth: true);
  }
}
