import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/index.dart';
import 'package:flutter_app/dao/task.dart';
import 'package:flutter_app/model/task_response.g.dart';
import 'package:flutter_app/page/allocation_in_out.dart';
import 'package:flutter_app/page/distribution_page.dart';
import 'package:flutter_app/page/purchase_in_page.dart';
import 'package:flutter_app/page/purchase_out_page.dart';
import 'package:flutter_app/page/sale_in_page.dart';
import 'package:flutter_app/page/sale_out_page.dart';
import 'package:flutter_app/utils/images.dart';
import 'package:flutter_app/vo/common_params.dart';

import 'assembly_in_out.dart';

Map<String, Icon> icons = {
  "Purchase": Icon(
      const IconData(FontIcon.caigourukudan, fontFamily: 'iconfont'),
      color: Colors.red),
  "PurchaseReturn": Icon(
      const IconData(FontIcon.caigoutuihuodan, fontFamily: 'iconfont'),
      color: Colors.red),
  "Sale": Icon(const IconData(FontIcon.xiaoshouchuku, fontFamily: 'iconfont'),
      color: Colors.red),
  "SaleReturn": Icon(const IconData(FontIcon.tuihuo, fontFamily: 'iconfont'),
      color: Colors.red),
  "Allocation": Icon(const IconData(FontIcon.tiaobo, fontFamily: 'iconfont'),
      color: Colors.red),
  "Assemble": Icon(const IconData(FontIcon.zujian, fontFamily: 'iconfont'),
      color: Colors.red),
};

Map<String, String> route = {
  "Purchase": PurchaseInPage.routeName,
  "PurchaseReturn": PurchaseOutPage.routeName,
  "Sale": SaleOutPage.routeName,
  "SaleReturn": SaleInPage.routeName,
  "Allocation": AllocationInOutPage.routeName,
  "Assemble": AssemblyInOutPage.routeName,
};

class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: new Scaffold(
        appBar: new AppBar(
            centerTitle: true,
            bottom: PreferredSize(
                child: Material(
                  color: Colors.blue,
                  child: TabBar(
                      indicatorColor: Colors.red,
                      labelColor: Colors.red,
                      unselectedLabelColor: Colors.white,
                      tabs: [
                        Tab(text: '全部'),
                        Tab(text: '待分配'),
                        Tab(text: '处理中'),
                        Tab(text: '已完成'),
                      ]),
                ),
                preferredSize: Size.fromHeight(0))),
        body: new TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            TabContent(0),
            TabContent(1),
            TabContent(2),
            TabContent(3),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TabContent extends StatefulWidget {
  int index = 0;
  TabContent(this.index);
  @override
  _TabContentState createState() => _TabContentState(this.index);
}

class _TabContentState extends State<TabContent> {
  bool _manage = false;
  int _page = 1;
  int index = 0;
  List<TaskResponseDataItem> _list = [];

  bool isLoading = false; //是否正在加载数据

  ScrollController _scrollController = ScrollController();

  _TabContentState(this.index);

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      this.initialized();
      this.getTask();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMore();
      }
    });
  }

  void getTask() async {
    DataResult result = await TaskDao.getTaskDao(this.index, _page);
    if (result.data != null) {
      TaskResponse response = result.data;
      setState(() {
        if (response.data != null) {
          _list.addAll(response.data!.toList());
        }
      });
    }
  }

  void initialized() async {
    bool _manage = await IndexDao.IsManage();
    setState(() {
      this._manage = _manage;
    });
  }

  /// 上拉加载更多
  Future _getMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 1), () {
        setState(() {
          ++_page;
          getTask();
          isLoading = false;
        });
      });
    }
  }

  /// 下拉刷新方法,为list重新赋值
  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        this._list.clear();
        this._page = 1;
        getTask();
      });
    });
  }

  Widget _renderRow(BuildContext context, int index) {
    if (index < this._list.length) {
      Icon? icon = icons[this._list[index].serviceCode!];
      if (icon == null) {
        icon = Icon(Icons.filter_none);
      }

      return ListTile(
          leading: icon,
          title: Row(
            children: [
              Text("${this._list[index].serviceName!}"),
              Container(
                padding: EdgeInsets.all(2),
              ),
              Text(
                "${this._list[index].sn!}",
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          subtitle: Row(
            children: [
              Row(
                children: [
                  Text("商品数:"),
                  Container(
                    padding: EdgeInsets.all(1),
                  ),
                  Text(
                    "${this._list[index].totalNum!}",
                    style: TextStyle(color: Colors.red[800]),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(2),
              ),
              this._list[index].userId != 0
                  ? Row(children: [
                      Text(
                        "${this._list[index].userName!}",
                        style: TextStyle(color: Colors.green[200]),
                      )
                    ])
                  : Text(""),
            ],
          ),
          trailing: this._list[index].finish == 0
              ? GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  child: Icon(Icons.rotate_right),
                  onTap: () => {
                    Navigator.of(context)
                        .pushNamed(DistributionPage.routeName,
                            arguments: this._list[index].id)
                        .then((value) => {_onRefresh()})
                  },
                )
              : Icon(Icons.arrow_right_rounded),
          onTap: () {
            String? routeName = route[this._list[index].serviceCode];
            if (routeName != null) {
              Navigator.of(context).pushNamed(routeName,
                  arguments: CommonParams(this._list[index].sn!,
                      this._list[index].userId!, this._list[index].finish!));
            }
          },
          dense: true,
          focusColor: Colors.grey,
          hoverColor: Colors.blueGrey);
    }
    return _getMoreWidget();
  }

  /// 加载更多时显示的组件,给用户提示
  Widget _getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '加载中...',
              style: TextStyle(fontSize: 16.0),
            ),
            CircularProgressIndicator(
              strokeWidth: 1.0,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!this._manage && this.index == 1) {
      return Container(
        child: Center(
          child: Text("没有权限访问该功能"),
        ),
      );
    }
    if (this._list.length == 0) {
      return Container(
        child: Center(
          child: Text("没有任何任务"),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _list.length,
        itemBuilder: _renderRow,
        controller: _scrollController,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
