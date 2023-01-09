import 'dart:async';

import 'package:flutter/material.dart';

class OpacityBanner extends StatefulWidget {
  @override
  _OpacityBannerState createState() => _OpacityBannerState();
}

class _OpacityBannerState extends State<OpacityBanner> {
  int zIndex = 0;
  List<String> list = ['ff0000', '00ff00', '0000ff', 'ffff00'];
  Timer? timer;

  //setInterval控制当前动画元素的下标，实现动画轮播
  autoPlay() {
    var second = const Duration(seconds: 2);
    timer = Timer.periodic(second, (t) {
      setState(() {
        zIndex = (++zIndex) % list.length;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    timer = Timer(Duration(seconds: 2), autoPlay);
  }

  @override
  void dispose() {
    if (timer != null) timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(alignment: Alignment.center, children: [
      Stack(
          children: list
              .asMap()
              .keys
              .map<Widget>((i) => AnimatedOpacity(
                    curve: Curves.easeIn,
                    duration: Duration(milliseconds: 600),
                    opacity: i == zIndex ? 1 : 0,
                    child: Container(
                      color:
                          Color(int.parse(list[i], radix: 16)).withAlpha(255),
                      height: 300, //100%
                    ),
                  ))
              .toList()),
      Positioned(
          bottom: 20,
          child: Row(
              children: list
                  .asMap()
                  .keys
                  .map((i) => Container(
                      width: 10,
                      height: 10,
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: i == zIndex ? Colors.blue : Colors.grey,
                          shape: BoxShape.circle)))
                  .toList()))
    ]));
  }
}
