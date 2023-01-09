import 'package:flutter/material.dart';
import 'package:flutter_app/model/purchase_goods_response.g.dart';
import 'package:flutter_app/model/purchase_response.g.dart';
import 'package:flutter_app/utils/date.dart';
import 'package:flutter_app/utils/page_util.dart';
import 'package:flutter_app/utils/status.dart';

class PurchaseWidght extends StatelessWidget {
  int page;
  PurchaseResponseData purchase;
  PurchaseGoodsResponse? purchaseGoods;
  ValueChanged<int> onPageChanged;

  PurchaseWidght(
    this.purchase,
    this.purchaseGoods,
    this.page,
    this.onPageChanged,
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      PageUtil.buildListItem(
          "订单状态",
          Text(
            Status.order(purchase.orderStatus),
            style: TextStyle(fontSize: 12),
          ),
          context),
      PageUtil.buildListItem(
          "物流状态",
          Text(
            Status.storage(purchase.storageStatus),
            style: TextStyle(fontSize: 12),
          ),
          context),
      PageUtil.buildListItem(
          "总数量",
          Text(
            purchase.totalNum.toString(),
            style: TextStyle(fontSize: 12),
          ),
          context),
      PageUtil.buildListItem(
          "已入库",
          Text(
            purchase.inNum.toString(),
            style: TextStyle(fontSize: 12),
          ),
          context),
      PageUtil.buildListItem(
          "开单时间",
          Text(
            timeToDateFormat(purchase.createTime),
            style: TextStyle(fontSize: 12),
          ),
          context),
      this.purchaseGoods != null
          ? PaginatedDataTable(
              rowsPerPage: 10,
              onPageChanged: this.onPageChanged,
              columns: [
                DataColumn(
                  label: Text(
                    '状态',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                DataColumn(
                    label: Text(
                  '数量',
                  style: TextStyle(fontSize: 12),
                )),
                DataColumn(
                    label: Text(
                  '入库数',
                  style: TextStyle(fontSize: 12),
                )),
                DataColumn(
                    label: Text(
                  '型号',
                  style: TextStyle(fontSize: 12),
                )),
                DataColumn(
                    label: Text(
                  '类别',
                  style: TextStyle(fontSize: 12),
                )),
              ],
              source: PurchaseGoodsResponseDataTableSource(
                  this.purchaseGoods, page),
            )
          : Center(
              child: Text(
                "订单商品为空！",
                style: TextStyle(fontSize: 12),
              ),
            ),
    ]));
  }
}

class PurchaseGoodsResponseDataTableSource extends DataTableSource {
  PurchaseGoodsResponseDataTableSource(this.purchaseGoods, this.page);
  final PurchaseGoodsResponse? purchaseGoods;
  final int page;

  @override
  DataRow getRow(int index) {
    List<PurchaseGoodsResponseDataItem> data = purchaseGoods!.data!;
    return data.length > index - page
        ? DataRow(cells: [
            DataCell(Text(
              '${Status.storage(data[index - page].state)}',
              style: TextStyle(fontSize: 12),
            )),
            DataCell(Text(
              '${data[index - page].theNum}',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            )),
            DataCell(Text(
              '${data[index - page].inNum}',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            )),
            DataCell(Text(
              '${data[index - page].name}',
              style: TextStyle(fontSize: 12),
            )),
            DataCell(Text(
              '${data[index - page].theClass}',
              style: TextStyle(fontSize: 12),
            )),
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
    return purchaseGoods!.count!;
  }
}
