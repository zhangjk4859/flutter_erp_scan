import 'package:flutter/material.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/index.dart';
import 'package:flutter_app/page/index_page.dart';
import 'package:flutter_app/page/login_page.dart';
import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:loading_indicator_view/loading_indicator_view.dart';

import 'package:flutter_app/utils/images.dart';

// 加载页面
class LoadingPage extends StatefulWidget {
  @override
  _LoadingState createState() => new _LoadingState();
}

class _LoadingState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();

    // 加载页面停顿3s
    new Future.delayed(Duration(seconds: 3), () async {
      isLogin();
    });
  }

  void isLogin() async {
    DataResult result = await IndexDao.IsLoginDao();
    bool loginResponse = result.data;
    // ignore: unrelated_type_equality_checks
    if (loginResponse == true) {
      Navigator.of(context).pushReplacementNamed(IndexPage.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        primary: true,
        backgroundColor: Colors.white,
        body: Stack(alignment: Alignment.topCenter, children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 100),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    Assets.IMAGES_LOGO,
                    height: 120,
                  ),
                  Text("施耐克扫码",
                      style: new TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.black))
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 90,
            child: Center(
                child: LineSpinFadeLoaderIndicator(
              ballColor: Colors.black12,
              maxBallAlpha: 50,
              maxLineHeight: 6,
              maxLineWidth: 5,
            )),
          ),
          Positioned(
            bottom: 20,
            child: Center(
                child: Column(
              children: [
                Image.asset(
                  Assets.IMAGES_LOGO,
                  height: 50,
                ),
                Text('v1.0.0',
                    style: new TextStyle(fontSize: 10, color: Colors.black26))
              ],
            )),
          )
        ]));
  }
}
