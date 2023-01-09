import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/dao/assembly.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/model/assembly_goods_response.g.dart';
import 'package:flutter_app/model/assembly_response.g.dart';
import 'package:flutter_app/model/public_response.g.dart';
import 'package:flutter_app/page/store_in_out.dart';
import 'package:flutter_app/page/store_page.dart';
import 'package:flutter_app/utils/code.dart';
import 'package:flutter_app/utils/status.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/vo/common_params.dart';
import 'package:flutter_app/vo/get_googs_sn_param.dart';
import 'package:flutter_app/vo/store_params.dart';
import 'package:flutter_app/widget/assembly_widget.dart';
import 'package:flutter_app/widget/group_saoma_text_field.dart';

class AssemblyInOutPage extends StatefulWidget {
  static const String routeName = '/assembly/in_out';

  @override
  State<StatefulWidget> createState() => _AssemblyInOutPageState();
}

// 调拨
class _AssemblyInOutPageState extends State<AssemblyInOutPage> {
  TextEditingController? _assemblyController;

  CommonParams? params;
  String assemblySn = "";

  bool assemblyReadOnly = false;

  AssemblyResponseData? assembly;
  AssemblyGoodsResponse? assemblyGoods;

  int page = 0;

  @override
  void initState() {
    _assemblyController =
        TextEditingController.fromValue(TextEditingValue(text: assemblySn));
    _assemblyController!.addListener(() {
      setState(() {
        assemblySn = _assemblyController!.text;
      });

      CodeType type = analysisCode(assemblySn);
      print(type);
      print(assemblySn);
      if (type == CodeType.assembly_task) {
        getAssembly(assemblySn);
      }
    });
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      var args = ModalRoute.of(context)?.settings.arguments;
      if (args != null) {
        params = (args as CommonParams?)!;
        setState(() {
          assemblySn = params!.sn;
          _assemblyController!.text = assemblySn;
          // ignore: unnecessary_null_comparison
          if (params != null) {
            this.assemblyReadOnly = true;
          } else {
            this.assemblyReadOnly = false;
          }
        });
        getAssembly(assemblySn);
      }
    });
  }

  void storeResult(int value) {
    if (value == 1) {
      getAssembly(assemblySn);
    }
  }

  void getAssemblyGoods(id) async {
    var type = 1;
    if (Status.outShow(assembly!.orderStatus)) {
      type = 1;
    }
    if (Status.inShow(assembly!.orderStatus)) {
      type = 2;
    }
    DataResult dataResult =
        await AssemblyDao.getAssemblyGoodsDao(id, type, page);
    setState(() {
      assemblyGoods = dataResult.data;
    });
  }

  void getAssembly(String sn) async {
    DataResult dataResult = await AssemblyDao.getAssemblyScanDao(sn);
    getAssemblyGoods(dataResult.data!.id!);

    setState(() {
      assembly = dataResult.data;
    });
  }

  void onAssemblyClear() {
    this.assembly = null;
    this.assemblyGoods = null;
  }

  bool checkGoodsSnParam(List<GetGoodsSnParamVo> param) {
    for (int index = 0; index < param.length; index++) {
      if (param[index].optNum <= 0) {
        if (Status.outShow(assembly!.orderStatus)) {
          showToast("${param[index].name} 出库数量不能小于0");
        }
        if (Status.inShow(assembly!.orderStatus)) {
          showToast("${param[index].name} 入库数量不能小于0");
        }

        return false;
      }
      if (param[index].waitNum - param[index].optNum < 0) {
        if (Status.outShow(assembly!.orderStatus)) {
          showToast("${param[index].name} 出库数量不能大于 ${param[index].waitNum}");
        }
        if (Status.inShow(assembly!.orderStatus)) {
          showToast("${param[index].name} 入库数量不能大于 ${param[index].waitNum}");
        }

        return false;
      }
    }
    return true;
  }

  Future<PublicResponse> doConfirmIn(List<String> goods) async {
    DataResult result = await AssemblyDao.postAssemblyStoreIn(
        StoreGoodsParams(assembly!.id!, goods));
    return result.data!;
  }

  Future<PublicResponse> doConfirmOut(List<String> goods) async {
    DataResult result = await AssemblyDao.postAssemblyStoreOut(
        StoreGoodsParams(assembly!.id!, goods));
    return result.data!;
  }

  void onAssemblyOutIn(List<GetGoodsSnParamVo> param) {
    if (!checkGoodsSnParam(param)) {
      return;
    }

    if (Status.outShow(assembly!.orderStatus)) {
      doConfirmOut([]).then((value) {
        showToast(value.msg!);
        getAssembly(assemblySn);
      });
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return StoreInOutPage(param, 0);
      })).then((list) {
        if (list != null && list.length > 0) {
          doConfirmIn(list).then((value) {
            showToast(value.msg!);
            getAssembly(assemblySn);
          });
        }
      });
    }
  }

  bool onSaomaShow() {
    if (assembly != null) {
      if (Status.inShow(assembly!.orderStatus)) {
        return true;
      }
    }
    return false;
  }

  bool onStoreShow() {
    if (assembly != null) {
      if (Status.outShow(assembly!.orderStatus)) {
        return true;
      }

      if (Status.inShow(assembly!.orderStatus)) {
        return true;
      }
    }

    return false;
  }

  Widget getStoreTitle() {
    if (assembly != null) {
      if (Status.outShow(assembly!.orderStatus)) {
        return Text("出库");
      }
      if (Status.inShow(assembly!.orderStatus)) {
        return Text("入库");
      }
    }
    return Container();
  }

  StoreParam? onStoreParam(GroupSaomaDataItem item) {
    if (assembly != null) {
      if (Status.outShow(assembly!.orderStatus)) {
        return StoreParam(assembly!.id!, StoreGoods.AssemblyOut, item.sn,
            number: item.num);
      }
      if (Status.inShow(assembly!.orderStatus)) {
        return StoreParam(assembly!.id!, StoreGoods.AssemblyIn, item.sn,
            number: item.num);
      }
    }
  }

  void onProduct(String val, CreateProductCallback callback) {
    getAssemblyGoodsOne(this.assembly!.id!, val).then((value) {
      if (value != null) {
        if (value.code == 1) {
          int waitNum = 0;
          if (Status.inShow(assembly!.orderStatus)) {
            waitNum = value.data!.theNum! - value.data!.inNum!;
          }

          callback.call(GroupSaomaDataItem(value.data!.name!, val,
              allNum: value.data!.theNum!, surplusNum: waitNum));
        } else {
          showToast(value.msg!);
        }
      } else {
        showToast("没有发现该商品");
      }
    });
  }

  Future<AssemblyGoodsOneResponse> getAssemblyGoodsOne(
      int id, String sn) async {
    var type = 1;
    if (Status.outShow(assembly!.orderStatus)) {
      type = 1;
    }
    if (Status.inShow(assembly!.orderStatus)) {
      type = 2;
    }
    DataResult dataResult =
        await AssemblyDao.getAssemblyGoodsOneScan(id, type, sn);
    return dataResult.data;
  }

  @override
  Widget build(BuildContext context) {
    return StorePage(
      title: Text("组装"),
      storeTitle: getStoreTitle(),
      saomaReadOnly: this.assemblyReadOnly,
      saomaController: this._assemblyController!,
      allowStoreNull: true,
      onSaomaClear: this.onAssemblyClear,
      onSaomaShow: this.onSaomaShow,
      onStore: this.onAssemblyOutIn,
      onStoreShow: this.onStoreShow,
      onStoreParam: this.onStoreParam,
      onProduct: this.onProduct,
      child: assembly != null
          ? AssemblyWidget(
              this.assembly!,
              this.assemblyGoods,
              this.page,
              (page) => {
                    setState(() {
                      this.page = page;
                      getAssemblyGoods(assembly!.id!);
                    })
                  })
          : Center(),
    );
  }
}
