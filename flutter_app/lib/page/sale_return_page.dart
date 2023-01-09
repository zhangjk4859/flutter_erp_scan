import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/sale_return.dart';
import 'package:flutter_app/model/sale_return_goods_response.g.dart';
import 'package:flutter_app/model/sale_return_response.g.dart';
import 'package:flutter_app/utils/date.dart';
import 'package:flutter_app/utils/page_util.dart';
import 'package:flutter_app/utils/status.dart';
import 'package:flutter_app/widget/sale_return_widget.dart';

class SaleReturnPage extends StatefulWidget {
  static const String routeName = '/sale_return';

  @override
  State<StatefulWidget> createState() => _SaleReturnPageState();
}

// 销售退单
class _SaleReturnPageState extends State<SaleReturnPage> {
  DataResult? dataResult;
  SaleReturnResponseData? saleRetrun;
  SaleReturnGoodsResponse? saleRetrunGoods;

  String? sn;
  int page = 0;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      var args = ModalRoute.of(context)?.settings.arguments;
      sn = args as String?;
      if (sn != "") {
        getSaleReturn(sn!);
      }
    });
  }

  void getSaleReturnGoods(id) async {
    dataResult = await SaleReturnDao.getSaleReturnGoodsDao(id, page);
    setState(() {
      saleRetrunGoods = dataResult!.data;
    });
  }

  void getSaleReturn(String sn) async {
    dataResult = await SaleReturnDao.getSaleReturnScanDao(sn);
    getSaleReturnGoods(dataResult!.data!.id!);

    setState(() {
      saleRetrun = dataResult!.data;
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
        title: Text("销售退货"),
      ),
      body: saleRetrun != null
          ? SaleReturnWidget(this.saleRetrun!, this.saleRetrunGoods, this.page,
              (page) {
              setState(() {
                this.page = page;
                getSaleReturnGoods(saleRetrun!.id!);
              });
            })
          : Center(
              child: Text("销售退货单不存在！"),
            ),
    );
  }
}
