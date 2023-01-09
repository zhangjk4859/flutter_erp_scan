import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app/page/purchase_in_page.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class AppJpush {
  static JPush jpush = new JPush();

  static Future<void> initialized(
      BuildContext context, Function() callback) async {
    jpush.setup(
      appKey: "909f73f80eae788c4d3d7e6b", //你自己应用的 AppKey
      channel: "developer-default",
      production: false,
      debug: true,
    );

    jpush.addEventHandler(
        onReceiveNotification: (Map<String, dynamic> message) async {
          callback.call();
        },
        onOpenNotification: (Map<String, dynamic> message) async {
          String extras = message['extras']["cn.jpush.android.EXTRA"];
          var data = jsonDecode(extras);

          String sn = data["sn"];
          String serviceCode = data["service_code"];
          if (serviceCode == "Purchase") {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.of(context)
                  .pushNamed(PurchaseInPage.routeName, arguments: sn);
            });
          }
        },
        onReceiveMessage: (Map<String, dynamic> message) async {
          callback.call();
        },
        onReceiveNotificationAuthorization:
            (Map<String, dynamic> message) async {});

    jpush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));
  }
}
