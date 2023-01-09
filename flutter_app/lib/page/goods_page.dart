import 'package:bmprogresshud/bmprogresshud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/product.dart';
import 'package:flutter_app/dao/storage_scan.dart';
import 'package:flutter_app/model/product_response.g.dart';
import 'package:flutter_app/model/storage_scan_response.g.dart';
import 'package:flutter_app/utils/page_util.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/vo/store_params.dart';
import 'package:flutter_app/widget/page_loading.dart';
import 'package:flutter_app/widget/slide_banner.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_tag_layout/flutter_tag_layout.dart';

class GoodsPage extends StatefulWidget {
  static const String routeName = '/goods';

  @override
  State<StatefulWidget> createState() => _GoodsPageState();
}

// 商品溯源
class _GoodsPageState extends State<GoodsPage> {
  DataResult? dataResult;
  ProductResponseData? product;
  StoreParam? param;

  bool loadding = true;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      var args = ModalRoute.of(context)?.settings.arguments;
      param = args as StoreParam?;
      if (param!.goodsSn != "") {
        getProduct(param!.goodsSn);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getProduct(String sn) async {
    dataResult = await ProductDao.getProductScanDao(sn, type: 1);
    setState(() {
      product = dataResult!.data;
    });
  }

  void doStorageScan() async {
    DataResult result = await StorageScanDao.getStorageScan(param!);
    StorageScanResponse response = result.data;
    if (response.code == 1) {
      showToast(response.msg!);
      Navigator.pop(context, 1);
    } else {
      showToast(response.msg!);
      Navigator.pop(context, 0);
    }
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
          title: product != null ? Text("${product!.name}") : Text("产品信息"),
        ),
        body: ProgressHud(
            child: product != null
                ? Container(
                    padding: const EdgeInsets.all(5),
                    child: ListView(
                      children: [
                        Container(
                          child: SlideBanner(product!.image!),
                        ),
                        Container(
                          child: Column(
                            children: [
                              PageUtil.buildListItem(
                                  "入库商品编号", Text(param!.goodsSn), context),
                              PageUtil.buildListItem(
                                  "产品编号", Text(product!.sn!), context),
                              PageUtil.buildListItem(
                                  "OE码", Text(product!.oe!), context),
                              PageUtil.buildListItem(
                                  "供应商",
                                  product!.supplier!.length > 0
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              120,
                                          child: Wrap(
                                              alignment:
                                                  WrapAlignment.spaceBetween,
                                              children: product!.supplier!
                                                  .map((e) => TextTagWidget(e,
                                                      borderColor: Colors.blue))
                                                  .toList()))
                                      : Container(),
                                  context),
                              PageUtil.buildListItem("库存量",
                                  Text(product!.stock.toString()), context),
                              PageUtil.buildListItem(
                                  "产品分类", Text(product!.theClass!), context),
                              PageUtil.buildListItem(
                                  "所属品牌", Text(product!.brand!), context),
                              PageUtil.buildListItem(
                                  "适用车型",
                                  product!.carBrand!.length > 0
                                      ? Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              120,
                                          child: Wrap(
                                              children: product!.carBrand!
                                                  .map((e) => TextTagWidget(e,
                                                      borderColor: Colors.blue))
                                                  .toList()))
                                      : Container(),
                                  context),
                              PageUtil.buildListItem(
                                  "适用车系", Text(product!.car!), context),
                              product!.type! == 1
                                  ? PageUtil.buildSection(
                                      "包含单品",
                                      Container(
                                          padding: const EdgeInsets.all(0),
                                          child: DataTable(
                                            columns: [
                                              DataColumn(label: Text('编号')),
                                              DataColumn(label: Text('OE')),
                                              DataColumn(label: Text('型号')),
                                            ],
                                            rows: product!.subGoods!
                                                .map((e) => DataRow(cells: [
                                                      DataCell(
                                                        Text(
                                                          e.sn!,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                      ),
                                                      DataCell(Text(e.oe!)),
                                                      DataCell(Text(e.name!)),
                                                    ]))
                                                .toList(),
                                          )),
                                      context)
                                  : Container(),
                            ],
                          ),
                        ),
                        Container(),
                      ],
                    ))
                : Center(child: PageLoadding(this.loadding, "没有发现商品信息"))));
  }
}
