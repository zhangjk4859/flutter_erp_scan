import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/index.dart';
import 'package:flutter_app/model/group_response.g.dart';
import 'package:flutter_app/utils/images.dart';
import 'package:flutter_app/utils/page_util.dart';

class GroupPage extends StatefulWidget {
  static const String routeName = '/group';

  @override
  State<StatefulWidget> createState() => _GroupPageState();
}

// 商品溯源
class _GroupPageState extends State<GroupPage> {
  DataResult? dataResult;

  GroupDataOrganize? organize;
  List<GroupDataUsersItem>? users = [];

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      getGroup();
    });
  }

  void getGroup() async {
    dataResult = await IndexDao.getGroup();
    setState(() {
      GroupData groupData = dataResult!.data;
      organize = groupData.organize!;
      users = groupData.users!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(
              // 绘制返回键
              child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context); // 关闭当前页面
            },
          )),
          title: Text("我的团队"),
          actions: [
            IconButton(
                onPressed: () {},
                padding: EdgeInsets.all(3.0),
                icon: Icon(
                    const IconData(FontIcon.saoma, fontFamily: 'iconfont'))),
          ],
        ),
        body: users!.length > 0
            ? ListView.separated(
                itemBuilder: (context, index) {
                  if (index == 0) {
                    //用户头像
                    return Container(
                        color: Colors.blue,
                        child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                PageUtil.buildListItemStyle(
                                    "组名称",
                                    TextStyle(color: Colors.white),
                                    Text(organize!.name!,
                                        style:
                                            TextStyle(color: Colors.grey[800])),
                                    context),
                                PageUtil.buildListItemStyle(
                                    "组描述",
                                    TextStyle(color: Colors.white),
                                    Text(
                                      organize!.desc!,
                                      style: TextStyle(color: Colors.grey[800]),
                                    ),
                                    context),
                              ]),
                        ));
                  }
                  index -= 1;
                  GroupDataUsersItem user = users![index];
                  return ListTile(
                    title: Text(user.username!), //中间标题
                    trailing:
                        user.organizeManage == 1 ? Text("组长") : Text("组员"),
                    subtitle: Text(user.phone!),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: users!.length + 1)
            : Center(child: Text("没有发现团队信息")));
  }
}
