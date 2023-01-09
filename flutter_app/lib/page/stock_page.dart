import 'package:flutter/material.dart';

// 仓库管理
class StockPage extends StatefulWidget {
  static const String routeName = '/stock';

  @override
  State<StatefulWidget> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
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
        title: Text("仓库管理"),
      ),
      body: Center(),
    );
  }
}
