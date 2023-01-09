import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/purchase.dart';
import 'package:flutter_app/model/purchase_goods_response.g.dart';
import 'package:flutter_app/model/purchase_response.g.dart';
import 'package:flutter_app/widget/purchase_widget.dart';

class PurchasePage extends StatefulWidget {
  static const String routeName = '/purchase';

  @override
  State<StatefulWidget> createState() => _PurchasePageState();
}

// 调拨
class _PurchasePageState extends State<PurchasePage> {
  DataResult? dataResult;
  PurchaseResponseData? purchase;
  PurchaseGoodsResponse? purchaseGoods;

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

  void getPurchaseGoods(id) async {
    dataResult = await PurchaseDao.getPurchaseGoodsDao(id, page);
    setState(() {
      purchaseGoods = dataResult!.data;
    });
  }

  void getPurchase(String sn) async {
    dataResult = await PurchaseDao.getPurchaseScanDao(sn);
    getPurchaseGoods(dataResult!.data!.id!);

    setState(() {
      purchase = dataResult!.data;
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
        title: Text("采购订单"),
      ),
      body: purchase != null
          ? PurchaseWidght(this.purchase!, this.purchaseGoods, this.page,
              (page) {
              setState(() {
                this.page = page;
                getPurchaseGoods(purchase!.id!);
              });
            })
          : Center(),
    );
  }
}
