import 'package:flutter/material.dart';
import 'package:flutter_app/model/assembly_goods_response.g.dart';
import 'package:flutter_app/model/assembly_response.g.dart';
import 'package:flutter_app/utils/date.dart';
import 'package:flutter_app/utils/page_util.dart';
import 'package:flutter_app/utils/status.dart';

// ignore: must_be_immutable
class AssemblyWidget extends StatelessWidget {
  int page;
  AssemblyResponseData assembly;
  AssemblyGoodsResponse? assemblyGoods;
  ValueChanged<int> onPageChanged;

  AssemblyWidget(
      this.assembly, this.assemblyGoods, this.page, this.onPageChanged);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      PageUtil.buildListItem(
          "订单状态",
          Text(Status.order(assembly.orderStatus),
              style: TextStyle(
                fontSize: 12,
              )),
          context),
      PageUtil.buildListItem(
          "物流状态",
          Text(Status.storage(assembly.storageStatus),
              style: TextStyle(
                fontSize: 12,
              )),
          context),
      PageUtil.buildListItem(
          "产品型号",
          Text(assembly.name!,
              style: TextStyle(
                fontSize: 12,
              )),
          context),
      PageUtil.buildListItem(
          "产品品牌",
          Text(assembly.brand!,
              style: TextStyle(
                fontSize: 12,
              )),
          context),
      PageUtil.buildListItem(
          "产品分类",
          Text(assembly.theClass!,
              style: TextStyle(
                fontSize: 12,
              )),
          context),
      PageUtil.buildListItem(
          "总数量",
          Text(assembly.totalInNum.toString(),
              style: TextStyle(
                fontSize: 12,
              )),
          context),
      PageUtil.buildListItem(
          "已入库数",
          Text(assembly.inNum.toString(),
              style: TextStyle(
                fontSize: 12,
              )),
          context),
      PageUtil.buildListItem(
          "开单时间",
          Text(timeToDateFormat(assembly.createTime),
              style: TextStyle(
                fontSize: 12,
              )),
          context),
      this.assemblyGoods != null
          ? PaginatedDataTable(
              rowsPerPage: 10,
              onPageChanged: this.onPageChanged,
              columns: [
                DataColumn(label: Text('品牌')),
                DataColumn(label: Text('数量')),
                DataColumn(label: Text('出库数')),
                DataColumn(label: Text('型号')),
                DataColumn(label: Text('类别')),
              ],
              source: AssemblyGoodsResponseDataTableSource(
                  this.assemblyGoods, page, assembly.orderStatus!),
            )
          : Center(
              child: Text("订单商品为空！"),
            ),
    ]));
  }
}

class AssemblyGoodsResponseDataTableSource extends DataTableSource {
  AssemblyGoodsResponseDataTableSource(
      this.assemblyGoods, this.page, this.orderStatus);
  final AssemblyGoodsResponse? assemblyGoods;
  final int page;
  final int orderStatus;

  @override
  DataRow getRow(int index) {
    List<AssemblyGoodsResponseDataItem> data = assemblyGoods!.data!;

    return data.length > index - page
        ? DataRow(cells: [
            DataCell(Text('${data[index - page].brand}',
                style: TextStyle(
                  fontSize: 12,
                ))),
            DataCell(Text('${data[index - page].theNum}',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold))),
            DataCell(Text('${data[index - page].outNum}',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                    fontWeight: FontWeight.bold))),
            DataCell(Text('${data[index - page].name}',
                style: TextStyle(
                  fontSize: 12,
                ))),
            DataCell(Text('${data[index - page].theClass}',
                style: TextStyle(
                  fontSize: 12,
                ))),
          ])
        : DataRow(cells: [
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
          ]);
  }

  @override
  int get selectedRowCount {
    return 0;
  }

  @override
  bool get isRowCountApproximate {
    return false;
  }

  @override
  int get rowCount {
    return assemblyGoods!.count!;
  }
}
