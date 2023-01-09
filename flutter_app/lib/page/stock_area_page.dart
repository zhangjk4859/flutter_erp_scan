import 'package:flutter/material.dart';

// 库区管理
class StockAreaPage extends StatefulWidget {
  static const String routeName = '/stock_area';

  @override
  State<StatefulWidget> createState() => _StockAreaPageState();
}

class _StockAreaPageState extends State<StockAreaPage> {
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
        title: Text("库区管理"),
      ),
      body: Center(),
    );
  }
}
