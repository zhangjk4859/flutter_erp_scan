import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/sale.dart';
import 'package:flutter_app/model/public_response.g.dart';
import 'package:flutter_app/model/sale_goods_response.g.dart';
import 'package:flutter_app/model/sale_response.g.dart';
import 'package:flutter_app/page/store_in_out.dart';
import 'package:flutter_app/page/store_page.dart';
import 'package:flutter_app/utils/code.dart';
import 'package:flutter_app/utils/status.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/vo/common_params.dart';
import 'package:flutter_app/vo/get_googs_sn_param.dart';
import 'package:flutter_app/vo/store_params.dart';
import 'package:flutter_app/widget/group_saoma_text_field.dart';
import 'package:flutter_app/widget/sale_widget.dart';

// 销售出库
class SaleOutPage extends StatefulWidget {
  static const String routeName = '/sale_out';

  @override
  State<StatefulWidget> createState() {
    return _SaleOutPageSate();
  }
}

class _SaleOutPageSate extends State<SaleOutPage> {
  TextEditingController? _saleController;

  CommonParams? params;
  String saleSn = "";

  bool saleReadOnly = false;

  SaleResponseData? sale;
  SaleGoodsResponse? saleGoods;

  int page = 0;

  @override
  void initState() {
    _saleController =
        TextEditingController.fromValue(TextEditingValue(text: saleSn));
    _saleController!.addListener(() {
      setState(() {
        saleSn = _saleController!.text;
      });
      CodeType type = analysisCode(saleSn);
      if (type == CodeType.sale) {
        getSale(saleSn);
      }
    });
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      var args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        params = (args as CommonParams?)!;
        setState(() {
          saleSn = params!.sn;
          _saleController!.text = saleSn;
          // ignore: unnecessary_null_comparison
          if (params != null) {
            this.saleReadOnly = true;
          } else {
            this.saleReadOnly = false;
          }
        });
        getSale(saleSn);
      }
    });
  }

  void getSaleGoods(id) async {
    DataResult dataResult = await SaleDao.getSaleGoodsDao(id, page);
    setState(() {
      saleGoods = dataResult.data;
    });
  }

  void getSale(String sn) async {
    DataResult dataResult = await SaleDao.getSaleScanDao(sn);
    getSaleGoods(dataResult.data!.id!);

    setState(() {
      sale = dataResult.data;
    });
  }

  void onProduct(String val, CreateProductCallback callback) {
    getSaleGoodsOne(this.sale!.id!, val).then((value) {
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

  Future<SaleGoodsOneResponse> getSaleGoodsOne(int id, String sn) async {
    DataResult dataResult = await SaleDao.getSaleGoodsOneScan(id, sn);
    return dataResult.data;
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
    DataResult result =
        await SaleDao.postSaleStoreOut(StoreGoodsParams(sale!.id!, goods));
    return result.data!;
  }

  void onSaleOut(List<GetGoodsSnParamVo> param) {
    if (!checkGoodsSnParam(param)) {
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return StoreInOutPage(param, 1);
    })).then((list) {
      if (list != null && list.length > 0)
        doConfirm(list).then((value) {
          showToast(value.msg!);
          getSale(saleSn);
        });
    });
  }

  bool onStoreShow() {
    return sale != null && Status.outShow(sale!.orderStatus);
  }

  StoreParam onStoreParam(GroupSaomaDataItem item) {
    return StoreParam(sale!.id!, StoreGoods.SaleOut, item.sn, number: item.num);
  }

  void onSaleClear() {
    this.sale = null;
    this.saleGoods = null;
  }

  @override
  Widget build(BuildContext context) {
    return StorePage(
      title: Text("销售出库"),
      storeTitle: Text("出库"),
      saomaReadOnly: this.saleReadOnly,
      saomaController: this._saleController!,
      onSaomaClear: this.onSaleClear,
      onStore: this.onSaleOut,
      onStoreShow: this.onStoreShow,
      onStoreParam: this.onStoreParam,
      onProduct: this.onProduct,
      child: sale != null
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
