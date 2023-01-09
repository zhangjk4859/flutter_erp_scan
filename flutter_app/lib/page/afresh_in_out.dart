import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/dao/allocation.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/model/allocation_goods_response.g.dart';
import 'package:flutter_app/model/allocation_response.g.dart';
import 'package:flutter_app/model/public_response.g.dart';
import 'package:flutter_app/page/store_in_out.dart';
import 'package:flutter_app/page/store_page.dart';
import 'package:flutter_app/utils/code.dart';
import 'package:flutter_app/utils/status.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/vo/common_params.dart';
import 'package:flutter_app/vo/get_googs_sn_param.dart';
import 'package:flutter_app/vo/store_params.dart';
import 'package:flutter_app/widget/allocation_widget.dart';
import 'package:flutter_app/widget/group_saoma_text_field.dart';

class ARefreshInOutPage extends StatefulWidget {
  static const String routeName = '/afresh/in_out';

  @override
  State<StatefulWidget> createState() => _ARefreshInOutPageState();
}

// 调拨
class _ARefreshInOutPageState extends State<ARefreshInOutPage> {
  TextEditingController? _allocationController;
  List<GroupSaomaDataItem> products = [];

  CommonParams? params;
  String allocationSn = "";

  bool allocationReadOnly = false;

  AllocationResponseData? allocation;
  AllocationGoodsResponse? allocationGoods;

  int page = 0;

  @override
  void initState() {
    _allocationController =
        TextEditingController.fromValue(TextEditingValue(text: allocationSn));
    _allocationController!.addListener(() {
      setState(() {
        allocationSn = _allocationController!.text;
      });

      CodeType type = analysisCode(allocationSn);
      if (type == CodeType.allocation) {
        getAllocation(allocationSn);
      }
    });
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      var args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        params = (args as CommonParams?)!;
        setState(() {
          allocationSn = params!.sn;
          _allocationController!.text = allocationSn;
          // ignore: unnecessary_null_comparison
          if (params != null) {
            this.allocationReadOnly = true;
          } else {
            this.allocationReadOnly = false;
          }
        });
        getAllocation(allocationSn);
      }
    });
  }

  void storeResult(int value) {
    if (value == 1) {
      getAllocation(allocationSn);
    }
  }

  void getAllocationGoods(id, orderStatus) async {
    print(id);
    var type = 1;
    if (Status.outShow(orderStatus)) {
      type = 1;
    }
    if (Status.inShow(orderStatus)) {
      type = 2;
    }
    DataResult dataResult =
        await AllocationDao.getAllocationGoodsDao(id, type, page);
    setState(() {
      allocationGoods = dataResult.data;
    });
  }

  void getAllocation(String sn) async {
    DataResult dataResult = await AllocationDao.getAllocationScanDao(sn);
    getAllocationGoods(dataResult.data!.id!, dataResult.data!.orderStatus!);

    setState(() {
      allocation = dataResult.data;
    });
  }

  void onAllocationClear() {
    this.products.clear();
    this.allocation = null;
    this.allocationGoods = null;
  }

  bool checkGoodsSnParam() {
    for (int index = 0; index < products.length; index++) {
      if (products[index].num <= 0) {
        if (Status.outShow(allocation!.orderStatus)) {
          showToast("${products[index].name} 出库数量不能小于0");
        }
        if (Status.inShow(allocation!.orderStatus)) {
          showToast("${products[index].name} 入库数量不能小于0");
        }

        return false;
      }
      if (products[index].surplusNum - products[index].num < 0) {
        if (Status.outShow(allocation!.orderStatus)) {
          showToast(
              "${products[index].name} 出库数量不能大于 ${products[index].surplusNum}");
        }
        if (Status.inShow(allocation!.orderStatus)) {
          showToast(
              "${products[index].name} 入库数量不能大于 ${products[index].surplusNum}");
        }

        return false;
      }
    }
    return true;
  }

  Future<PublicResponse> doConfirmIn(List<String> goods) async {
    DataResult result = await AllocationDao.postAllocationStoreIn(
        StoreGoodsParams(allocation!.id!, goods));
    return result.data!;
  }

  Future<PublicResponse> doConfirmOut(List<String> goods) async {
    DataResult result = await AllocationDao.postAllocationStoreOut(
        StoreGoodsParams(allocation!.id!, goods));
    return result.data!;
  }

  void onAllocationOutIn(List<GetGoodsSnParamVo> param) {
    if (!checkGoodsSnParam()) {
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      if (Status.inShow(allocation!.orderStatus)) {
        return StoreInOutPage(param, 0);
      } else {
        return StoreInOutPage(param, 1);
      }
    })).then((list) {
      if (list != null && list.length > 0) {
        if (Status.outShow(allocation!.orderStatus)) {
          doConfirmOut(list).then((value) {
            showToast(value.msg!);
            getAllocation(allocationSn);
          });
        }

        if (Status.inShow(allocation!.orderStatus)) {
          doConfirmIn(list).then((value) {
            showToast(value.msg!);
            getAllocation(allocationSn);
          });
        }
      }
    });
  }

  bool onSaomaShow() {
    if (allocation != null) {
      return !allocation!.notAuth!;
    }
    return false;
  }

  bool onStoreShow() {
    if (allocation != null) {
      if (Status.outShow(allocation!.orderStatus)) {
        return true;
      }

      if (Status.inShow(allocation!.orderStatus)) {
        return true;
      }
    }

    return false;
  }

  Widget getStoreTitle() {
    if (allocation != null) {
      if (Status.outShow(allocation!.orderStatus)) {
        return Text("出库");
      }
      if (Status.inShow(allocation!.orderStatus)) {
        return Text("入库");
      }
    }
    return Container();
  }

  StoreParam? onStoreParam(GroupSaomaDataItem item) {
    if (allocation != null) {
      if (Status.outShow(allocation!.orderStatus)) {
        return StoreParam(allocation!.id!, StoreGoods.AllocationOut, item.sn,
            number: item.num);
      }
      if (Status.inShow(allocation!.orderStatus)) {
        return StoreParam(allocation!.id!, StoreGoods.AllocationIn, item.sn,
            number: item.num);
      }
    }
  }

  void onProduct(String val, CreateProductCallback callback) {
    getAllocationGoodsOne(this.allocation!.id!, val).then((value) {
      if (value != null) {
        if (value.code == 1) {
          if (value.data!.state! == 5) {
            showToast("该商品已经入库完成");
          } else {
            setState(() {
              int waitNum = 0;
              if (Status.outShow(allocation!.orderStatus)) {
                waitNum = value.data!.theNum! - value.data!.outNum!;
              }
              if (Status.inShow(allocation!.orderStatus)) {
                waitNum = value.data!.theNum! - value.data!.inNum!;
              }

              callback.call(GroupSaomaDataItem(value.data!.name!, val,
                  allNum: value.data!.theNum!, surplusNum: waitNum));
            });
          }
        } else {
          showToast(value.msg!);
        }
      } else {
        showToast("没有发现该商品");
      }
    });
  }

  Future<AllocationGoodsOneResponse> getAllocationGoodsOne(
      int id, String sn) async {
    var type = 1;
    if (Status.outShow(allocation!.orderStatus)) {
      type = 1;
    }
    if (Status.inShow(allocation!.orderStatus)) {
      type = 2;
    }
    DataResult dataResult =
        await AllocationDao.getAllocationGoodsOneScan(id, type, sn);
    return dataResult.data;
  }

  @override
  Widget build(BuildContext context) {
    return StorePage(
      title: Text("贴牌"),
      storeTitle: getStoreTitle(),
      saomaReadOnly: this.allocationReadOnly,
      saomaController: this._allocationController!,
      onSaomaClear: this.onAllocationClear,
      onStore: this.onAllocationOutIn,
      onStoreShow: this.onStoreShow,
      onStoreParam: this.onStoreParam,
      onProduct: this.onProduct,
      child: allocation != null
          ? AllocationWidget(
              this.allocation!,
              this.allocationGoods,
              this.page,
              (page) => {
                    setState(() {
                      this.page = page;
                      getAllocationGoods(
                          allocation!.id!, allocation!.orderStatus!);
                    })
                  })
          : Center(),
    );
  }
}
