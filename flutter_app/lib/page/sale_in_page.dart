import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/sale_return.dart';
import 'package:flutter_app/model/public_response.g.dart';
import 'package:flutter_app/model/sale_return_goods_response.g.dart';
import 'package:flutter_app/model/sale_return_response.g.dart';
import 'package:flutter_app/page/store_in_out.dart';
import 'package:flutter_app/page/store_page.dart';
import 'package:flutter_app/utils/code.dart';
import 'package:flutter_app/utils/status.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/vo/common_params.dart';
import 'package:flutter_app/vo/get_googs_sn_param.dart';
import 'package:flutter_app/vo/store_params.dart';
import 'package:flutter_app/widget/group_saoma_text_field.dart';
import 'package:flutter_app/widget/sale_return_widget.dart';

class SaleInPage extends StatefulWidget {
  static const String routeName = '/sale_in';

  @override
  State<StatefulWidget> createState() {
    return _SaleInPageState();
  }
}

// 销售退货
class _SaleInPageState extends State<SaleInPage> {
  TextEditingController? _saleReturnController;

  CommonParams? params;
  String saleReturnSn = "";

  bool saleReturnReadOnly = false;

  SaleReturnResponseData? saleReturn;
  SaleReturnGoodsResponse? saleReturnGoods;

  int page = 0;

  @override
  void initState() {
    _saleReturnController =
        TextEditingController.fromValue(TextEditingValue(text: saleReturnSn));
    _saleReturnController!.addListener(() {
      setState(() {
        saleReturnSn = _saleReturnController!.text;
      });
      CodeType type = analysisCode(saleReturnSn);
      if (type == CodeType.sale_return) {
        getSaleReturn(saleReturnSn);
      }
    });

    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      var args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        params = (args as CommonParams?)!;
        setState(() {
          saleReturnSn = params!.sn;
          _saleReturnController!.text = saleReturnSn;
          // ignore: unnecessary_null_comparison
          if (params != null) {
            this.saleReturnReadOnly = true;
          } else {
            this.saleReturnReadOnly = false;
          }
        });
        getSaleReturn(saleReturnSn);
      }
    });
  }

  void getSaleReturnGoods(id) async {
    DataResult dataResult = await SaleReturnDao.getSaleReturnGoodsDao(id, page);
    setState(() {
      saleReturnGoods = dataResult.data;
    });
  }

  void getSaleReturn(String sn) async {
    DataResult dataResult = await SaleReturnDao.getSaleReturnScanDao(sn);
    getSaleReturnGoods(dataResult.data!.id!);

    setState(() {
      saleReturn = dataResult.data;
    });
  }

  bool checkGoodsSnParam(List<GetGoodsSnParamVo> products) {
    for (int index = 0; index < products.length; index++) {
      if (products[index].optNum <= 0) {
        showToast("${products[index].name} 退货数量不能小于0");
        return false;
      }
      if (products[index].waitNum - products[index].optNum < 0) {
        showToast(
            "${products[index].name} 退货数量不能大于 ${products[index].waitNum}");
        return false;
      }
    }
    return true;
  }

  Future<PublicResponse> doConfirm(List<String> goods) async {
    DataResult result = await SaleReturnDao.postSaleReturnStoreIn(
        StoreGoodsParams(saleReturn!.id!, goods));
    return result.data!;
  }

  void onSaleReturnIn(List<GetGoodsSnParamVo> param) {
    if (!checkGoodsSnParam(param)) {
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return StoreInOutPage(param, 2);
    })).then((list) {
      if (list != null && list.length > 0)
        doConfirm(list).then((value) {
          showToast(value.msg!);
          getSaleReturn(saleReturnSn);
        });
    });
  }

  void onSaleReturnClear() {
    this.saleReturn = null;
    this.saleReturnGoods = null;
  }

  bool onStoreShow() {
    return saleReturn != null && Status.inShow(saleReturn!.orderStatus!);
  }

  StoreParam? onStoreParam(GroupSaomaDataItem item) {
    return StoreParam(saleReturn!.id!, StoreGoods.SaleIn, item.sn,
        number: item.num);
  }

  void onProduct(String val, CreateProductCallback callback) {
    getSaleReturnGoodsOne(this.saleReturn!.id!, val).then((value) {
      if (value != null) {
        if (value.code == 1) {
          if (value.data!.state! == 5) {
            showToast("该商品已经入库完成");
          } else {
            var surplusNum = value.data!.returnNum! - value.data!.returnInNum!;
            callback.call(GroupSaomaDataItem(value.data!.name!, val,
                allNum: value.data!.returnNum!, surplusNum: surplusNum));
          }
        } else {
          showToast(value.msg!);
        }
      } else {
        showToast("没有发现该商品");
      }
    });
  }

  Future<SaleReturnGoodsOneResponse> getSaleReturnGoodsOne(
      int id, String sn) async {
    DataResult dataResult =
        await SaleReturnDao.getSaleReturnGoodsOneScan(id, sn);
    return dataResult.data;
  }

  @override
  Widget build(BuildContext context) {
    return StorePage(
      title: Text("销售退货"),
      storeTitle: Text("退货"),
      saomaReadOnly: this.saleReturnReadOnly,
      saomaController: this._saleReturnController!,
      onSaomaClear: this.onSaleReturnClear,
      onStore: this.onSaleReturnIn,
      onStoreShow: this.onStoreShow,
      onStoreParam: this.onStoreParam,
      onProduct: this.onProduct,
      child: saleReturn != null
          ? SaleReturnWidget(
              this.saleReturn!,
              this.saleReturnGoods,
              this.page,
              (page) => {
                    setState(() {
                      this.page = page;
                      getSaleReturnGoods(saleReturn!.id!);
                    })
                  })
          : Center(),
    );
  }
}
