import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/sale.dart';
import 'package:flutter_app/model/sale_goods_response.g.dart';
import 'package:flutter_app/model/sale_response.g.dart';
import 'package:flutter_app/utils/date.dart';
import 'package:flutter_app/utils/page_util.dart';
import 'package:flutter_app/utils/status.dart';
import 'package:flutter_app/widget/sale_widget.dart';

class SalePage extends StatefulWidget {
  static const String routeName = '/sale';

  @override
  State<StatefulWidget> createState() => _SalePageState();
}

// 销售订单
class _SalePageState extends State<SalePage> {
  DataResult? dataResult;
  SaleResponseData? sale;
  SaleGoodsResponse? saleGoods;

  String? sn;
  int page = 0;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      var args = ModalRoute.of(context)?.settings.arguments;
      sn = args as String?;
      if (sn != "") {
        getSale(sn!);
      }
    });
  }

  void getSaleGoods(id) async {
    dataResult = await SaleDao.getSaleGoodsDao(id, page);
    setState(() {
      saleGoods = dataResult!.data;
    });
  }

  void getSale(String sn) async {
    dataResult = await SaleDao.getSaleScanDao(sn);
    getSaleGoods(dataResult!.data!.id!);

    setState(() {
      sale = dataResult!.data;
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
        title: Text("销售订单"),
      ),
      body: sale != null
          ? SaleWidget(
              this.sale!,
              this.saleGoods,
              this.page,
              (page) => {
                    setState(() {
                      this.page = page;
                      getSaleGoods(sale!.id!);
                    })
                  })
          : Center(),
    );
  }
}
