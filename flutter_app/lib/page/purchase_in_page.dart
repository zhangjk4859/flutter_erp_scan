import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/purchase.dart';
import 'package:flutter_app/model/public_response.g.dart';
import 'package:flutter_app/model/purchase_goods_response.g.dart';
import 'package:flutter_app/model/purchase_response.g.dart';
import 'package:flutter_app/page/store_in_out.dart';
import 'package:flutter_app/page/store_page.dart';
import 'package:flutter_app/utils/code.dart';
import 'package:flutter_app/utils/status.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/vo/common_params.dart';
import 'package:flutter_app/vo/get_googs_sn_param.dart';
import 'package:flutter_app/vo/store_params.dart';
import 'package:flutter_app/widget/group_saoma_text_field.dart';
import 'package:flutter_app/widget/purchase_widget.dart';

class PurchaseInPage extends StatefulWidget {
  static const String routeName = '/purchase_in';

  @override
  State<StatefulWidget> createState() {
    return _PurchaseInPageState();
  }
}

// 采购入库
class _PurchaseInPageState extends State<PurchaseInPage> {
  TextEditingController? _purchaseController;

  CommonParams? params;
  String purchaseSn = "";

  bool purchaseReadOnly = false;

  PurchaseResponseData? purchase;
  PurchaseGoodsResponse? purchaseGoods;

  int page = 0;

  // 初始化
  @override
  void initState() {
    _purchaseController =
        TextEditingController.fromValue(TextEditingValue(text: purchaseSn));
    _purchaseController!.addListener(() {
      setState(() {
        purchaseSn = _purchaseController!.text;
      });
      CodeType type = analysisCode(purchaseSn);
      if (type == CodeType.purchase) {
        getPurchase(purchaseSn);
      }
    });

    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) async {
      var args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        params = (args as CommonParams?)!;
        setState(() {
          purchaseSn = params!.sn;
          _purchaseController!.text = purchaseSn;
          // ignore: unnecessary_null_comparison
          if (params != null) {
            this.purchaseReadOnly = true;
          } else {
            this.purchaseReadOnly = false;
          }
        });
        getPurchase(purchaseSn);
      }
    });
  }

  //采购入库单产品
  void getPurchaseGoods(id) async {
    DataResult dataResult = await PurchaseDao.getPurchaseGoodsDao(id, page);
    if (this.mounted) {
      setState(() {
        purchaseGoods = dataResult.data;
      });
    }
  }

  // 采购入库单信息
  void getPurchase(String sn) async {
    DataResult dataResult = await PurchaseDao.getPurchaseScanDao(sn);

    if (dataResult.result) {
      getPurchaseGoods(dataResult.data!.id!);
      setState(() {
        purchase = dataResult.data;
      });
    } else {
      showToast("采购订单不存在！");
    }
  }

  // 扫码时创建商品
  void onProduct(String val, CreateProductCallback callback) {
    getPurchaseGoodsOne(this.purchase!.id!, val).then((value) {
      if (value != null) {
        if (value.code == 1) {
          if (value.data!.state! == 5) {
            showToast("该商品已经入库完成");
          } else {
            callback.call(GroupSaomaDataItem(value.data!.name!, val,
                allNum: value.data!.theNum!, surplusNum: value.data!.waitNum!));
          }
        } else {
          showToast(value.msg!);
        }
      } else {
        showToast("没有发现该商品");
      }
    });
  }

  Future<PurchaseGoodsOneResponse> getPurchaseGoodsOne(
      int id, String sn) async {
    DataResult dataResult = await PurchaseDao.getPurchaseGoodsOneScan(id, sn);
    return dataResult.data;
  }

  Future<PublicResponse> doConfirm(List<String> goods) async {
    DataResult result = await PurchaseDao.postPurchaseStoreIn(
        StoreGoodsParams(purchase!.id!, goods));
    return result.data!;
  }

  bool checkGoodsSnParam(List<GetGoodsSnParamVo> param) {
    for (int index = 0; index < param.length; index++) {
      if (param[index].optNum <= 0) {
        showToast("${param[index].name} 入库数量不能小于0");
        return false;
      }
      if (param[index].waitNum - param[index].optNum < 0) {
        showToast("${param[index].name} 入库数量不能大于 ${param[index].waitNum}");
        return false;
      }
    }
    return true;
  }

  // 采购入库
  void onPurchaseIn(List<GetGoodsSnParamVo> param) {
    if (!checkGoodsSnParam(param)) {
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return StoreInOutPage(param, 0);
    })).then((list) {
      if (list != null && list.length > 0)
        doConfirm(list).then((value) {
          showToast(value.msg!);
          getPurchase(purchaseSn);
        });
    });
  }

  bool onStoreShow() {
    return purchase != null && Status.inShow(purchase!.orderStatus);
  }

  StoreParam onStoreParam(GroupSaomaDataItem item) {
    return StoreParam(purchase!.id!, StoreGoods.PurchaseIn, item.sn,
        number: item.num);
  }

  void onPurchaseClear() {
    this.purchase = null;
    this.purchaseGoods = null;
  }

  @override
  Widget build(BuildContext context) {
    return StorePage(
      title: Text("采购订单"),
      storeTitle: Text("入库"),
      saomaReadOnly: this.purchaseReadOnly,
      saomaController: this._purchaseController!,
      onSaomaClear: this.onPurchaseClear,
      onStore: this.onPurchaseIn,
      onStoreShow: this.onStoreShow,
      onStoreParam: this.onStoreParam,
      onProduct: this.onProduct,
      child: purchase != null
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
