import 'package:flutter/material.dart';

InputDecorationTheme InputTheme(BuildContext context) {
  return InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
    prefixStyle: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor),
    hintStyle: TextStyle(fontSize: 12, color: Theme.of(context).hintColor),
    border: OutlineInputBorder(
      ///设置边框四个角的弧度
      borderRadius: BorderRadius.all(Radius.circular(3)),

      ///用来配置边框的样式
      borderSide: BorderSide(
        ///设置边框的颜色
        color: Colors.grey,

        ///设置边框的粗细
        width: 1.0,
      ),
    ),

    ///设置输入框可编辑时的边框样式
    enabledBorder: OutlineInputBorder(
      ///设置边框四个角的弧度
      borderRadius: BorderRadius.all(Radius.circular(3)),

      ///用来配置边框的样式
      borderSide: BorderSide(
        ///设置边框的颜色
        color: Colors.grey,

        ///设置边框的粗细
        width: 1.0,
      ),
    ),
    disabledBorder: OutlineInputBorder(
      ///设置边框四个角的弧度
      borderRadius: BorderRadius.all(Radius.circular(3)),

      ///用来配置边框的样式
      borderSide: BorderSide(
        ///设置边框的颜色
        color: Colors.grey,

        ///设置边框的粗细
        width: 1.0,
      ),
    ),

    ///用来配置输入框获取焦点时的颜色
    focusedBorder: OutlineInputBorder(
      ///设置边框四个角的弧度
      borderRadius: BorderRadius.all(Radius.circular(3)),

      ///用来配置边框的样式
      borderSide: BorderSide(
        ///设置边框的颜色
        color: Colors.blue,

        ///设置边框的粗细
        width: 1.0,
      ),
    ),
  );
}
