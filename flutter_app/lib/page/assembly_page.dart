import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/dao/assembly.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/model/assembly_goods_response.g.dart';
import 'package:flutter_app/model/assembly_response.g.dart';
import 'package:flutter_app/utils/status.dart';
import 'package:flutter_app/widget/assembly_widget.dart';

class AssemblyPage extends StatefulWidget {
  static const String routeName = '/assembly';

  @override
  State<StatefulWidget> createState() {
    return _AssemblyPageState();
  }
}

// 调拨
class _AssemblyPageState extends State<AssemblyPage> {
  AssemblyResponseData? assembly;
  AssemblyGoodsResponse? assemblyGoods;

  String? sn;
  int page = 0;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      var args = ModalRoute.of(context)?.settings.arguments;
      sn = args as String?;
      if (sn != "") {
        getAssembly(sn!);
      }
    });
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
          title: Text("调拨")),
      body: assembly != null
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
          : Center(
              child: Text("调拨单不存在"),
            ),
    );
  }
}
