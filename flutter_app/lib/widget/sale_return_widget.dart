// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_app/model/sale_return_goods_response.g.dart';
import 'package:flutter_app/model/sale_return_response.g.dart';
import 'package:flutter_app/utils/date.dart';
import 'package:flutter_app/utils/page_util.dart';
import 'package:flutter_app/utils/status.dart';

// ignore: must_be_immutable
class SaleReturnWidget extends StatelessWidget {
  int page;
  SaleReturnResponseData saleReturn;
  SaleReturnGoodsResponse? saleReturnGoods;
  ValueChanged<int> onPageChanged;

  SaleReturnWidget(
      this.saleReturn, this.saleReturnGoods, this.page, this.onPageChanged);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      PageUtil.buildListItem(
          "订单状态",
          Text(
            Status.order(saleReturn.orderStatus),
            style: TextStyle(fontSize: 12),
          ),
          context),
      PageUtil.buildListItem(
          "仓库状态",
          Text(
            Status.storage(saleReturn.storageStatus),
            style: TextStyle(fontSize: 12),
          ),
          context),
      PageUtil.buildListItem(
          "客户名称",
          Text(
            saleReturn.buyerName!,
            style: TextStyle(fontSize: 12),
          ),
          context),
      PageUtil.buildListItem(
          "退货数量",
          Text(
            saleReturn.totalReturnNum.toString(),
            style: TextStyle(fontSize: 12),
          ),
          context),
      PageUtil.buildListItem(
          "已退数量",
          Text(
            saleReturn.totalReturnInNum.toString(),
            style: TextStyle(fontSize: 12),
          ),
          context),
      PageUtil.buildListItem(
          "冲红数量",
          Text(
            saleReturn.totalRedNum.toString(),
            style: TextStyle(fontSize: 12),
          ),
          context),
      PageUtil.buildListItem(
          "损毁数量",
          Text(
            saleReturn.totalScrapNum.toString(),
            style: TextStyle(fontSize: 12),
          ),
          context),
      PageUtil.buildListItem(
          "总数量",
          Text(
            saleReturn.totalNum.toString(),
            style: TextStyle(fontSize: 12),
          ),
          context),
      PageUtil.buildListItem(
          "开单时间",
          Text(
            timeToDateFormat(saleReturn.createTime),
            style: TextStyle(fontSize: 12),
          ),
          context),
      this.saleReturnGoods != null
          ? PaginatedDataTable(
              rowsPerPage: 10,
              onPageChanged: this.onPageChanged,
              columns: [
                DataColumn(
                    label: Text(
                  '状态',
                  style: TextStyle(fontSize: 12),
                )),
                DataColumn(
                    label: Text(
                  '退货',
                  style: TextStyle(fontSize: 12),
                )),
                DataColumn(
                    label: Text(
                  '已退',
                  style: TextStyle(fontSize: 12),
                )),
                DataColumn(
                    label: Text(
                  '冲红',
                  style: TextStyle(fontSize: 12),
                )),
                DataColumn(
                    label: Text(
                  '损毁',
                  style: TextStyle(fontSize: 12),
                )),
                DataColumn(
                    label: Text(
                  '总数量',
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
              source: SaleReturnGoodsResponseDataTableSource(
                  this.saleReturnGoods, page),
            )
          : Center(
              child: Text("订单商品为空！"),
            ),
    ]));
  }
}

class SaleReturnGoodsResponseDataTableSource extends DataTableSource {
  SaleReturnGoodsResponseDataTableSource(this.saleReturnGoods, this.page);
  final SaleReturnGoodsResponse? saleReturnGoods;
  final int page;

  @override
  DataRow getRow(int index) {
    List<SaleReturnGoodsResponseDataItem> data = saleReturnGoods!.data!;

    return data.length > index - page
        ? DataRow(cells: [
            DataCell(Text(
              '${Status.storage(data[index - page].state)}',
              style: TextStyle(fontSize: 12),
            )),
            DataCell(Text(
              '${data[index - page].returnNum}',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            )),
            DataCell(Text(
              '${data[index - page].returnInNum}',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.green,
                  fontWeight: FontWeight.bold),
            )),
            DataCell(Text(
              '${data[index - page].redNum}',
              style: TextStyle(fontSize: 12),
            )),
            DataCell(Text(
              '${data[index - page].scrapNum}',
              style: TextStyle(fontSize: 12),
            )),
            DataCell(Text(
              '${data[index - page].theClass}',
              style: TextStyle(fontSize: 12),
            )),
            DataCell(Text(
              '${data[index - page].name}',
              style: TextStyle(fontSize: 12),
            )),
            DataCell(Text(
              '${data[index - page].theClass}',
              style: TextStyle(fontSize: 12),
            ))
          ])
        : DataRow(cells: [
            DataCell(Text('')),
            DataCell(Text('')),
            DataCell(Text('')),
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
    return saleReturnGoods!.count!;
  }
}
