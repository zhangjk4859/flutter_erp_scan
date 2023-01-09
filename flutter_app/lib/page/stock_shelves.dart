import 'package:flutter/material.dart';

// 仓库货架管理
class StockShelvesPage extends StatefulWidget {
  static const String routeName = '/stock_shelves';

  @override
  State<StatefulWidget> createState() => _StockShelvesPageState();
}

class _StockShelvesPageState extends State<StockShelvesPage> {
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
        title: Text("货架管理"),
      ),
      body: Center(),
    );
  }
}
