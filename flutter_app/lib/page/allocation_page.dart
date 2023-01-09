import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/dao/allocation.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/model/allocation_goods_response.g.dart';
import 'package:flutter_app/model/allocation_response.g.dart';
import 'package:flutter_app/utils/status.dart';
import 'package:flutter_app/widget/allocation_widget.dart';

class AllocationPage extends StatefulWidget {
  static const String routeName = '/allocation';
  @override
  State<StatefulWidget> createState() {
    return _AllocationPageState();
  }
}

// 调拨
class _AllocationPageState extends State<AllocationPage> {
  DataResult? dataResult;
  AllocationResponseData? allocation;
  AllocationGoodsResponse? allocationGoods;

  String? sn;
  int page = 0;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      var args = ModalRoute.of(context)?.settings.arguments;
      sn = args as String?;
      if (sn != "") {
        getPurchase(sn!);
      }
    });
  }

  void getAllocationGoods(id) async {
    var type = 1;
    if (Status.outShow(allocation!.orderStatus)) {
      type = 1;
    }
    if (Status.inShow(allocation!.orderStatus)) {
      type = 2;
    }
    dataResult = await AllocationDao.getAllocationGoodsDao(id, type, page);
    setState(() {
      allocationGoods = dataResult!.data;
    });
  }

  void getPurchase(String sn) async {
    dataResult = await AllocationDao.getAllocationScanDao(sn);
    getAllocationGoods(dataResult!.data!.id!);

    setState(() {
      allocation = dataResult!.data;
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
          title: Text("调拨")),
      body: allocation != null
          ? AllocationWidget(
              this.allocation!,
              this.allocationGoods,
              this.page,
              (page) => {
                    setState(() {
                      this.page = page;
                      getAllocationGoods(allocation!.id!);
                    })
                  })
          : Center(
              child: Text("调拨单不存在"),
            ),
    );
  }
}
