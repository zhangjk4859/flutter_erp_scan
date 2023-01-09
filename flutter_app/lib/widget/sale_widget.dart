import 'package:flutter/material.dart';
import 'package:flutter_app/model/sale_goods_response.g.dart';
import 'package:flutter_app/model/sale_response.g.dart';
import 'package:flutter_app/utils/date.dart';
import 'package:flutter_app/utils/page_util.dart';
import 'package:flutter_app/utils/status.dart';

// ignore: must_be_immutable
class SaleWidget extends StatelessWidget {
  int page;
  SaleResponseData sale;
  SaleGoodsResponse? saleGoods;
  ValueChanged<int> onPageChanged;

  SaleWidget(this.sale, this.saleGoods, this.page, this.onPageChanged);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      PageUtil.buildListItem(
          "订单状态",
          Text(
            Status.order(sale.orderStatus),
            style: TextStyle(fontSize: 12),
          ),
          context),
      PageUtil.buildListItem(
          "物流状态",
          Text(
            Status.storage(sale.storageStatus),
            style: TextStyle(fontSize: 12),
          ),
          context),
      PageUtil.buildListItem(
          "总数量",
          Text(
            sale.totalNum.toString(),
            style: TextStyle(fontSize: 12),
          ),
          context),
      PageUtil.buildListItem("已出库", Text(sale.sellerNum.toString()), context),
      PageUtil.buildListItem(
          "开单时间",
          Text(
            timeToDateFormat(sale.createTime),
            style: TextStyle(fontSize: 12),
          ),
          context),
      ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 5),
          title: Text(
            "物流信息",
            style: TextStyle(fontSize: 12),
          ),
          children: [
            PageUtil.buildListItem(
                "联系人姓名",
                Text(
                  sale.consignee!,
                  style: TextStyle(fontSize: 12),
                ),
                context),
            PageUtil.buildListItem(
                "联系人",
                Text(
                  sale.phone!,
                  style: TextStyle(fontSize: 12),
                ),
                context),
            PageUtil.buildListItem(
                "城市",
                Text(
                  sale.region!,
                  style: TextStyle(fontSize: 12),
                ),
                context),
            PageUtil.buildListItem(
                "详细地址",
                Expanded(
                    child: Text(
                  sale.address!,
                  style: TextStyle(fontSize: 12),
                  maxLines: 4,
                )),
                context),
          ]),
      this.saleGoods != null
          ? PaginatedDataTable(
              rowsPerPage: 10,
              onPageChanged: this.onPageChanged,
              columns: [
                DataColumn(label: Text('状态', style: TextStyle(fontSize: 12))),
                DataColumn(label: Text('数量', style: TextStyle(fontSize: 12))),
                DataColumn(label: Text('出库数', style: TextStyle(fontSize: 12))),
                DataColumn(label: Text('型号', style: TextStyle(fontSize: 12))),
                DataColumn(label: Text('类别', style: TextStyle(fontSize: 12))),
              ],
              source: SaleGoodsResponseDataTableSource(this.saleGoods, page),
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

class SaleGoodsResponseDataTableSource extends DataTableSource {
  SaleGoodsResponseDataTableSource(this.saleGoods, this.page);
  final SaleGoodsResponse? saleGoods;
  final int page;

  @override
  DataRow getRow(int index) {
    List<SaleGoodsResponseDataItem> data = saleGoods!.data!;

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
              '${data[index - page].sellerNum}',
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
    return saleGoods!.count!;
  }
}
