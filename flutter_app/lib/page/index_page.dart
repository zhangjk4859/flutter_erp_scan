import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/app_jpush.dart';
import 'package:flutter_app/utils/images.dart';

import 'home_page.dart';
import 'my_page.dart';
import 'task_page.dart';

class IndexPage extends StatefulWidget {
  static const String routeName = '/index';

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage>
    with AutomaticKeepAliveClientMixin {
  bool showBadge = true;

  @override
  void initState() {
    super.initState();
    AppJpush.initialized(
        context,
        () => {
              setState(() {
                this.showBadge = true;
              })
            });
  }

  @override
  bool get wantKeepAlive => true;

  int _currentIndex = 0;

  List<Widget> _pageList = [
    HomePage(),
    TaskPage(),
    MyPage(),
  ];

  List<BottomNavigationBarItem> _getBarItem() {
    return [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
      BottomNavigationBarItem(
          icon: Badge(
            badgeContent: Text(''),
            child: Icon(const IconData(FontIcon.task, fontFamily: 'iconfont')),
            showBadge: showBadge,
          ),
          label: '代办任务'),
      BottomNavigationBarItem(icon: Icon(Icons.people), label: '我的'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: this._pageList[this._currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            this._currentIndex = index;
            if (index == 1) {
              this.showBadge = false;
            }
          });
        },
        currentIndex: this._currentIndex,
        items: _getBarItem(),
        fixedColor: Colors.pink,
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
