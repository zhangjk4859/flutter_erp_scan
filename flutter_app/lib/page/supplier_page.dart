import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/supplier.dart';
import 'package:flutter_app/model/supplier_response.g.dart';
import 'package:flutter_app/utils/page_util.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_tag_layout/flutter_tag_layout.dart';

class SupplierPage extends StatefulWidget {
  static const String routeName = '/supplier';

  @override
  State<StatefulWidget> createState() => _SupplierPageState();
}

// 供应商
class _SupplierPageState extends State<SupplierPage> {
  DataResult? dataResult;
  SupplierResponseData? supplier;
  String? sn;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      var args = ModalRoute.of(context)?.settings.arguments;
      sn = args as String?;
      if (sn != "") {
        getSupplier(sn!);
      }
    });
  }

  void getSupplier(String sn) async {
    dataResult = await SupplierDao.getSupplierScanDao(sn);
    setState(() {
      supplier = dataResult!.data;
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
        title: Text("供应商"),
      ),
      body: supplier != null
          ? Center(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PageUtil.buildListItem("编号", Text(supplier!.sn!), context),
                PageUtil.buildListItem(
                    "状态",
                    supplier!.status! == 1
                        ? TextTagWidget("启用", borderColor: Colors.blue)
                        : TextTagWidget("禁用", borderColor: Colors.grey),
                    context),
                PageUtil.buildListItem("供应商代码", Text(supplier!.code!), context),
                PageUtil.buildListItem("供应商名称", Text(supplier!.name!), context),
                PageUtil.buildListItem(
                    "联系人姓名", Text(supplier!.contactsName!), context),
                PageUtil.buildListItem(
                    "联系人职位", Text(supplier!.contactsPhone!), context),
                PageUtil.buildListItem(
                    "联系人电话", Text(supplier!.contactsPhone!), context),
                PageUtil.buildListItem(
                    "地址",
                    Expanded(
                        child: Text(
                      supplier!.address!,
                      maxLines: 20,
                    )),
                    context),
                PageUtil.buildListItem(
                    "备注",
                    Expanded(
                        child: Text(
                      supplier!.desc!,
                      maxLines: 20,
                    )),
                    context),
              ],
            ))
          : Center(
              child: Text("编码为: $sn 供应商不存在！"),
            ),
    );
  }
}
