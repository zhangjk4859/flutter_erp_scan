import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/index.dart';
import 'package:flutter_app/model/user_info_response.dart';
import 'package:flutter_app/utils/toast.dart';

import 'group_page.dart';
import 'login_page.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  DataResult? dataResult;
  UserInfoResponseData? userInfo;

  List menuTitles = [
    '我的消息',
    '我的团队',
  ];
  List menuIcons = [
    Icons.message,
    Icons.people,
  ];

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      getUserInfo();
    });
  }

  void getUserInfo() async {
    dataResult = await IndexDao.getUserInfoDao();
    setState(() {
      userInfo = dataResult!.data;
    });
  }

  void getLogout() async {
    Navigator.of(context).pushReplacementNamed(LoginPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: const Text('我的'), actions: <Widget>[
          IconButton(
              onPressed: () async => {getLogout()}, icon: Icon(Icons.logout))
        ]),
        body: ListView.separated(
            itemBuilder: (context, index) {
              if (index == 0) {
                //用户头像
                return Container(
                    color: Colors.blue,
                    height: 150.0,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 60.0,
                            height: 60.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/ic_avatar_default.png'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          SizedBox(height: 10.0),
                          userInfo != null
                              ? Text(
                                  userInfo!.username!,
                                  style: TextStyle(color: Colors.white),
                                )
                              : TextButton(
                                  onPressed: () => {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                LoginPage.routeName)
                                      },
                                  child: Text(
                                    "登录",
                                    style: TextStyle(color: Colors.white),
                                  )),
                        ],
                      ),
                    ));
              }
              index -= 1;
              return ListTile(
                dense: true,
                leading: Icon(menuIcons[index]), //左图标
                title: Text(menuTitles[index]), //中间标题
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => {
                  if (userInfo == null)
                    {showToast("请登录后进行在进行操作")}
                  else if (index == 1)
                    {
                      Navigator.of(context).pushNamed(GroupPage.routeName,
                          arguments: userInfo?.id)
                    }
                },
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: menuTitles.length + 1));
  }
}
