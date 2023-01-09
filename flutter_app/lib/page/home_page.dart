import 'package:flutter/material.dart';
import 'package:flutter_app/page/goods_index.dart';
import 'package:flutter_app/page/purchase_in_page.dart';
import 'package:flutter_app/page/purchase_out_page.dart';
import 'package:flutter_app/page/sale_in_page.dart';
import 'package:flutter_app/page/sale_out_page.dart';
import 'package:flutter_app/page/saoma_page.dart';
import 'package:flutter_app/page/stock_page.dart';
import 'package:flutter_app/utils/images.dart';

import 'afresh_in_out.dart';
import 'allocation_page.dart';
import 'assembly_in_out.dart';

// 首页页面
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget caigouArea = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconContainer(
            const IconData(FontIcon.caigourukudan, fontFamily: 'iconfont'),
            '采购入库',
            (event) =>
                {Navigator.of(context).pushNamed(PurchaseInPage.routeName)},
            labelColor: Colors.black54,
          ),
          IconContainer(
            const IconData(FontIcon.caigoutuihuodan, fontFamily: 'iconfont'),
            '采购退货',
            (event) =>
                {Navigator.of(context).pushNamed(PurchaseOutPage.routeName)},
            labelColor: Colors.black54,
          ),
        ],
      ),
    );

    Widget xiaoshouArea = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconContainer(
            const IconData(FontIcon.xiaoshouchuku, fontFamily: 'iconfont'),
            '销售出库',
            (event) => {Navigator.of(context).pushNamed(SaleOutPage.routeName)},
            labelColor: Colors.black54,
          ),
          IconContainer(
            const IconData(FontIcon.tuihuo, fontFamily: 'iconfont'),
            '销售退货',
            (event) => {Navigator.of(context).pushNamed(SaleInPage.routeName)},
            labelColor: Colors.black54,
          ),
        ],
      ),
    );

    Widget productionArea = new Container(
      child: new Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        IconContainer(
          const IconData(FontIcon.zujian, fontFamily: 'iconfont'),
          '组装',
          (event) =>
              {Navigator.of(context).pushNamed(AssemblyInOutPage.routeName)},
          labelColor: Colors.black54,
        ),
        IconContainer(
          const IconData(FontIcon.zujian, fontFamily: 'iconfont'),
          '贴牌',
          (event) =>
              {Navigator.of(context).pushNamed(ARefreshInOutPage.routeName)},
          labelColor: Colors.black54,
        )
      ]),
    );

    Widget stockArea = new Container(
      child: new Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        IconContainer(
          const IconData(FontIcon.zujian, fontFamily: 'iconfont'),
          '调拨',
          (event) =>
              {Navigator.of(context).pushNamed(AllocationPage.routeName)},
          labelColor: Colors.black54,
        ),
        IconContainer(
          const IconData(FontIcon.zujian, fontFamily: 'iconfont'),
          '仓库',
          (event) => {Navigator.of(context).pushNamed(StockPage.routeName)},
          labelColor: Colors.black54,
        )
      ]),
    );

    Widget qitaArea = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconContainer(
            const IconData(FontIcon.suyuan, fontFamily: 'iconfont'),
            '商品溯源',
            (event) =>
                {Navigator.of(context).pushNamed(GoodsIndexPage.routeName)},
            labelColor: Colors.black54,
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("施耐克扫码"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(SaomaPage.routeName);
              },
              padding: EdgeInsets.all(3.0),
              icon:
                  Icon(const IconData(FontIcon.saoma, fontFamily: 'iconfont'))),
        ],
      ),
      body: Container(
          margin: EdgeInsets.all(5),
          child: Wrap(
            children: <Widget>[
              LeftIconContainer(
                Icons.label,
                '采购',
                iconColor: Colors.blue,
                labelColor: Colors.black,
              ),
              Divider(),
              caigouArea,
              LeftIconContainer(
                Icons.label,
                '销售',
                iconColor: Colors.blue,
                labelColor: Colors.black,
              ),
              Divider(),
              xiaoshouArea,
              LeftIconContainer(
                Icons.label,
                '生产',
                iconColor: Colors.blue,
                labelColor: Colors.black,
              ),
              Divider(),
              productionArea,
              LeftIconContainer(
                Icons.label,
                '仓库',
                iconColor: Colors.blue,
                labelColor: Colors.black,
              ),
              Divider(),
              stockArea,
              LeftIconContainer(
                Icons.label,
                '其他',
                iconColor: Colors.blue,
                labelColor: Colors.black,
              ),
              Divider(),
              qitaArea,
            ],
          )),
    );
  }
}

class LeftIconContainer extends StatelessWidget {
  double size = 32.0;
  Color iconColor = Colors.red;
  Color labelColor = Colors.red;
  IconData icon;
  String label;

  LeftIconContainer(this.icon, this.label,
      {this.iconColor = Colors.red,
      this.labelColor = Colors.red,
      this.size = 32.0}) {}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Container(
            margin: const EdgeInsets.only(top: 3.0),
            child: new Icon(
              icon,
              color: iconColor,
              size: 15,
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: labelColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class IconContainer extends StatelessWidget {
  double size = 32.0;
  Color iconColor = Colors.red;
  Color labelColor = Colors.red;
  IconData icon;
  String label;

  PointerDownEventListener onTap;

  IconContainer(this.icon, this.label, this.onTap,
      {this.iconColor = Colors.red,
      this.labelColor = Colors.red,
      this.size = 32.0});

  @override
  Widget build(BuildContext context) {
    return Listener(
        child: Container(
          height: 80.0,
          width: 80.0,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Icon(icon, color: iconColor),
                new Container(
                  margin: const EdgeInsets.only(top: 8.0),
                  child: new Text(
                    label,
                    style: new TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: labelColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        onPointerDown: onTap);
  }
}
