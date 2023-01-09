import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/index.dart';
import 'package:flutter_app/dao/task.dart';
import 'package:flutter_app/model/group_response.g.dart';
import 'package:flutter_app/utils/page_util.dart';
import 'package:flutter_app/utils/toast.dart';

class DistributionPage extends StatefulWidget {
  static const String routeName = '/distribution';

  @override
  State<StatefulWidget> createState() => _DistributionPageState();
}

// 销售订单
class _DistributionPageState extends State<DistributionPage> {
  DataResult? dataResult;

  GroupDataOrganize? organize;
  List<GroupDataUsersItem>? users = [];
  int change = 0;
  int distributionId = 0;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      int? args = ModalRoute.of(context)?.settings.arguments as int;
      getGroup();
      setState(() {
        this.distributionId = args;
      });
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

  void distribution() async {
    if (this.distributionId == 0) {
      showToast("分配对象不可以为空");
      return;
    }
    if (this.change == 0) {
      showToast("请选择分配人员");
      return;
    }
    await TaskDao.getDistributionDao(this.distributionId, this.change);
    showToast("分配成功");
    Navigator.pop(context);
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
            title: Text("分配"),
            actions: [
              IconButton(
                icon: Icon(Icons.done),
                onPressed: () async => {distribution()},
              )
            ]),
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
                  return RadioListTile(
                    contentPadding: EdgeInsets.all(0),
                    dense: true,
                    title: Text(
                        "${user.username!} [${user.organizeManage == 1 ? "组长" : "组员"}]"),
                    subtitle: Text(user.phone!),
                    groupValue: this.change,
                    onChanged: (value) => {
                      setState(() {
                        this.change = value as int;
                      })
                    },
                    value: user.id!,
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: users!.length + 1)
            : Center(child: Text("没有发现团队信息")));
  }
}
