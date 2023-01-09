import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/purchase_return.dart';
import 'package:flutter_app/model/public_response.g.dart';
import 'package:flutter_app/model/purchase_return_goods_response.g.dart';
import 'package:flutter_app/model/purchase_return_response.g.dart';
import 'package:flutter_app/page/store_in_out.dart';
import 'package:flutter_app/page/store_page.dart';
import 'package:flutter_app/utils/code.dart';
import 'package:flutter_app/utils/status.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/vo/common_params.dart';
import 'package:flutter_app/vo/get_googs_sn_param.dart';
import 'package:flutter_app/vo/store_params.dart';
import 'package:flutter_app/widget/group_saoma_text_field.dart';
import 'package:flutter_app/widget/purchase_return_widget.dart';

class PurchaseOutPage extends StatefulWidget {
  static const String routeName = '/purchase_out';

  @override
  State<StatefulWidget> createState() {
    return _PurchaseOutPageState();
  }
}

class _PurchaseOutPageState extends State<PurchaseOutPage> {
  TextEditingController? _purchaseReturnController;

  CommonParams? params;
  String purchaseReturnSn = "";

  bool purchaseReturnReadOnly = false;

  PurchaseReturnResponseData? purchaseReturn;
  PurchaseReturnGoodsResponse? purchaseReturnGoods;

  int page = 0;

  @override
  void initState() {
    _purchaseReturnController = TextEditingController.fromValue(
        TextEditingValue(text: purchaseReturnSn));
    _purchaseReturnController!.addListener(() {
      setState(() {
        purchaseReturnSn = _purchaseReturnController!.text;
      });
      CodeType type = analysisCode(purchaseReturnSn);
      if (type == CodeType.purchase_return) {
        getPurchaseReturn(purchaseReturnSn);
      }
    });
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      var args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        params = (args as CommonParams?)!;
        setState(() {
          purchaseReturnSn = params!.sn;
          _purchaseReturnController!.text = purchaseReturnSn;
          // ignore: unnecessary_null_comparison
          if (params != null) {
            this.purchaseReturnReadOnly = true;
          } else {
            this.purchaseReturnReadOnly = false;
          }
        });
        getPurchaseReturn(purchaseReturnSn);
      }
    });
  }

  void getPurchaseReturnGoods(id) async {
    DataResult dataResult =
        await PurchaseReturnDao.getPurchaseReturnGoodsDao(id, page);
    setState(() {
      purchaseReturnGoods = dataResult.data;
    });
  }

  void getPurchaseReturn(String sn) async {
    DataResult dataResult =
        await PurchaseReturnDao.getPurchaseReturnScanDao(sn);
    getPurchaseReturnGoods(dataResult.data!.id!);

    setState(() {
      purchaseReturn = dataResult.data;
    });
  }

  bool checkGoodsSnParam(List<GetGoodsSnParamVo> products) {
    for (int index = 0; index < products.length; index++) {
      if (products[index].optNum <= 0) {
        showToast("${products[index].name} 出库数量不能小于0");
        return false;
      }
      if (products[index].waitNum - products[index].optNum < 0) {
        showToast(
            "${products[index].name} 出库数量不能大于 ${products[index].waitNum}");
        return false;
      }
    }
    return true;
  }

  Future<PublicResponse> doConfirm(List<String> goods) async {
    DataResult result = await PurchaseReturnDao.postPurchaseReturnStoreOut(
        StoreGoodsParams(purchaseReturn!.id!, goods));
    return result.data!;
  }

  void onPurchaseReturnOut(List<GetGoodsSnParamVo> param) {
    if (!checkGoodsSnParam(param)) {
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return StoreInOutPage(param, 1);
    })).then((list) {
      if (list != null && list.length > 0) {
        doConfirm(list).then((value) {
          showToast(value.msg!);
          getPurchaseReturn(purchaseReturnSn);
        });
      }
    });
  }

  bool onStoreShow() {
    return purchaseReturn != null && Status.inShow(purchaseReturn!.orderStatus);
  }

  void onPurchaseReturnClear() {
    this.purchaseReturn = null;
    this.purchaseReturnGoods = null;
  }

  StoreParam onStoreParam(GroupSaomaDataItem item) {
    return StoreParam(purchaseReturn!.id!, StoreGoods.PurchaseOut, item.sn,
        number: item.num);
  }

  // 扫码时创建商品
  void onProduct(String val, CreateProductCallback callback) {
    getPurchaseReturnGoodsOne(this.purchaseReturn!.id!, val).then((value) {
      if (value != null) {
        if (value.code == 1) {
          if (value.data!.state! == 5) {
            showToast("该商品已经入库完成");
          } else {
            var waitNum = value.data!.returnNum! - value.data!.returnOutNum!;
            callback.call(GroupSaomaDataItem(value.data!.name!, val,
                allNum: value.data!.returnNum!, surplusNum: waitNum));
          }
        } else {
          showToast(value.msg!);
        }
      } else {
        showToast("没有发现该商品");
      }
    });
  }

  Future<PurchaseReturnGoodsOneResponse> getPurchaseReturnGoodsOne(
      int id, String sn) async {
    DataResult dataResult =
        await PurchaseReturnDao.getPurchaseReturnGoodsOneScan(id, sn);
    return dataResult.data;
  }

  @override
  Widget build(BuildContext context) {
    return StorePage(
      title: Text("采购退货单"),
      storeTitle: Text("退货"),
      saomaReadOnly: this.purchaseReturnReadOnly,
      saomaController: this._purchaseReturnController!,
      onSaomaClear: this.onPurchaseReturnClear,
      onStore: this.onPurchaseReturnOut,
      onStoreShow: this.onStoreShow,
      onStoreParam: this.onStoreParam,
      onProduct: this.onProduct,
      child: purchaseReturn != null
          ? PurchaseReturnWidght(
              this.purchaseReturn!, this.purchaseReturnGoods, this.page,
              (page) {
              setState(() {
                this.page = page;
                getPurchaseReturnGoods(purchaseReturn!.id!);
              });
            })
          : Center(),
    );
  }
}
