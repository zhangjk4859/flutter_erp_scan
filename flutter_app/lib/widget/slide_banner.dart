import 'dart:async';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SlideBanner extends StatefulWidget {
  List<String> list = [];

  SlideBanner(this.list) {
    if (this.list.length == 0) {
      list = ["http://test.sneikparts.com/static/none-img.png"];
    }
  }

  @override
  _SlideBannerState createState() => _SlideBannerState();
}

class _SlideBannerState extends State<SlideBanner> {
  double dx = 0; //距离
  int curr = 0; //要移出的下标
  int next = 0; //要移入的下标
  bool toLeft = true; //自动播放的方向，默认向左
  Timer? timer;

  dragStart(Offset offset) {
    dx = 0;
  }

  //累计位移距离
  dragUpdate(Offset offset) {
    var x = offset.dx;
    dx += x;
  }

  //达到一定距离后则触发轮播图左右滑动
  dragEnd(Velocity v) {
    if (dx.abs() < 20) return;
    timer!.cancel();
    if (dx < 0) {
      //向左
      if (!toLeft) {
        setState(() {
          toLeft = true;
          curr = next - 1 < 0 ? this.widget.list.length - 1 : next - 1;
        });
      }
      setState(() {
        curr = next;
        next = (++next) % this.widget.list.length;
      });
    } else {
      //向右
      if (toLeft) {
        setState(() {
          toLeft = false;
          curr = (next + 1) % this.widget.list.length;
        });
      }
      setState(() {
        curr = next;
        next = --next < 0 ? this.widget.list.length - 1 : next;
      });
    }
    //setTimeout
    timer = Timer(Duration(seconds: 2), autoPlay);
  }

  autoPlay() {
    var second = const Duration(seconds: 2);
    timer = Timer.periodic(second, (t) {
      setState(() {
        toLeft = true;
        curr = next;
        next = (++next) % this.widget.list.length;
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
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return Container(
        child: GestureDetector(
            onHorizontalDragStart: (details) =>
                dragStart(details.globalPosition),
            onHorizontalDragUpdate: (details) => dragUpdate(details.delta),
            onHorizontalDragEnd: (details) => dragEnd(details.velocity),
            child: Stack(
                children: this
                    .widget
                    .list
                    .asMap()
                    .keys
                    .map((i) => AnimatedContainer(
                        duration: Duration(
                            milliseconds: (i == next || i == curr) ? 600 : 0),
                        curve: Curves.easeIn,
                        transform: Matrix4.translationValues(
                            i == next
                                ? 0
                                : i == curr
                                    ? (toLeft ? -width : width)
                                    : (toLeft ? width : -width),
                            0,
                            0),
                        width: width,
                        height: 200,
                        child: Image.network(this.widget.list[i],
                            width: width,
                            height: double.infinity,
                            fit: BoxFit.cover)))
                    .toList())));
  }
}
