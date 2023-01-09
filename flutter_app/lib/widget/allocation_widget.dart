import 'package:flutter/material.dart';
import 'package:flutter_app/model/allocation_goods_response.g.dart';
import 'package:flutter_app/model/allocation_response.g.dart';
import 'package:flutter_app/utils/date.dart';
import 'package:flutter_app/utils/page_util.dart';
import 'package:flutter_app/utils/status.dart';

// ignore: must_be_immutable
class AllocationWidget extends StatelessWidget {
  int page;
  AllocationResponseData allocation;
  AllocationGoodsResponse? allocationGoods;
  ValueChanged<int> onPageChanged;

  AllocationWidget(
      this.allocation, this.allocationGoods, this.page, this.onPageChanged);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      PageUtil.buildListItem(
          "订单状态",
          Text(Status.order(allocation.orderStatus),
              style: TextStyle(
                fontSize: 12,
              )),
          context),
      PageUtil.buildListItem(
          "物流状态",
          Text(Status.storage(allocation.storageStatus),
              style: TextStyle(
                fontSize: 12,
              )),
          context),
      PageUtil.buildListItem(
          "调拨品牌",
          Text(allocation.brand!,
              style: TextStyle(
                fontSize: 12,
              )),
          context),
      PageUtil.buildListItem(
          "开单时间",
          Text(timeToDateFormat(allocation.createTime),
              style: TextStyle(
                fontSize: 12,
              )),
          context),
      ...Status.outShow(allocation.orderStatus)
          ? [
              PageUtil.buildListItem(
                  "总数量",
                  Text(allocation.totalOutNum.toString(),
                      style: TextStyle(
                        fontSize: 12,
                      )),
                  context),
              PageUtil.buildListItem(
                  "已出库数",
                  Text(allocation.outNum.toString(),
                      style: TextStyle(
                        fontSize: 12,
                      )),
                  context),
            ]
          : [],
      ...Status.inShow(allocation.orderStatus)
          ? [
              PageUtil.buildListItem(
                  "总数量",
                  Text(allocation.totalInNum.toString(),
                      style: TextStyle(
                        fontSize: 12,
                      )),
                  context),
              PageUtil.buildListItem(
                  "已入库数",
                  Text(allocation.inNum.toString(),
                      style: TextStyle(
                        fontSize: 12,
                      )),
                  context),
            ]
          : [],
      this.allocationGoods != null
          ? PaginatedDataTable(
              rowsPerPage: 10,
              onPageChanged: this.onPageChanged,
              columns: [
                DataColumn(label: Text('状态')),
                DataColumn(label: Text('品牌')),
                ...Status.outShow(allocation.orderStatus)
                    ? [
                        DataColumn(label: Text('数量')),
                        DataColumn(label: Text('出库数')),
                      ]
                    : [],
                ...Status.inShow(allocation.orderStatus)
                    ? [
                        DataColumn(label: Text('数量')),
                        DataColumn(label: Text('入库数')),
                      ]
                    : [],
                DataColumn(label: Text('型号')),
                DataColumn(label: Text('类别')),
              ],
              source: AllocationGoodsResponseDataTableSource(
                  this.allocationGoods, page, allocation.orderStatus!),
            )
          : Center(
              child: Text("订单商品为空！"),
            ),
    ]));
  }
}

class AllocationGoodsResponseDataTableSource extends DataTableSource {
  AllocationGoodsResponseDataTableSource(
      this.allocationGoods, this.page, this.orderStatus);
  final AllocationGoodsResponse? allocationGoods;
  final int page;
  final int orderStatus;

  @override
  DataRow getRow(int index) {
    List<AllocationGoodsResponseDataItem> data = allocationGoods!.data!;

    return data.length > index - page
        ? DataRow(cells: [
            DataCell(Text('${Status.storage(data[index - page].state)}',
                style: TextStyle(
                  fontSize: 12,
                ))),
            DataCell(Text('${data[index - page].brand}',
                style: TextStyle(
                  fontSize: 12,
                ))),
            ...Status.outShow(orderStatus)
                ? [
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
                  ]
                : [],
            ...Status.inShow(orderStatus)
                ? [
                    DataCell(Text('${data[index - page].theNum}',
                        style: TextStyle(
                          fontSize: 12,
                        ))),
                    DataCell(Text('${data[index - page].inNum}',
                        style: TextStyle(
                          fontSize: 12,
                        ))),
                  ]
                : [],
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
    return allocationGoods!.count!;
  }
}
