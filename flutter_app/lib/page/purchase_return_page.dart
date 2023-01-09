import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/purchase_return.dart';
import 'package:flutter_app/model/purchase_return_goods_response.g.dart';
import 'package:flutter_app/model/purchase_return_response.g.dart';
import 'package:flutter_app/utils/date.dart';
import 'package:flutter_app/utils/page_util.dart';
import 'package:flutter_app/utils/status.dart';
import 'package:flutter_app/widget/purchase_return_widget.dart';

class PurchaseReturnPage extends StatefulWidget {
  static const String routeName = '/purchase_return';

  @override
  State<StatefulWidget> createState() => _PurchaseReturnPageState();
}

// 调拨
class _PurchaseReturnPageState extends State<PurchaseReturnPage> {
  DataResult? dataResult;
  PurchaseReturnResponseData? purchaseReturn;
  PurchaseReturnGoodsResponse? purchaseReturnGoods;

  String? sn;
  int page = 0;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      var args = ModalRoute.of(context)?.settings.arguments;
      sn = args as String?;
      if (sn != "") {
        getPurchaseReturn(sn!);
      }
    });
  }

  void getPurchaseReturnGoods(id) async {
    dataResult = await PurchaseReturnDao.getPurchaseReturnGoodsDao(id, page);
    setState(() {
      purchaseReturnGoods = dataResult!.data;
    });
  }

  void getPurchaseReturn(String sn) async {
    dataResult = await PurchaseReturnDao.getPurchaseReturnScanDao(sn);
    getPurchaseReturnGoods(dataResult!.data!.id!);

    setState(() {
      purchaseReturn = dataResult!.data;
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
        title: Text("采购退货"),
      ),
      body: purchaseReturn != null
          ? PurchaseReturnWidght(purchaseReturn!, purchaseReturnGoods, page,
              (page) {
              setState(() {
                this.page = page;
                getPurchaseReturnGoods(purchaseReturn!.id!);
              });
            })
          : Center(
              child: Text("采购退货单不存在！"),
            ),
    );
  }
}
