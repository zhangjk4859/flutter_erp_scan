import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page/scanner_page.dart';
import 'package:flutter_app/utils/images.dart';
import 'package:ai_barcode/ai_barcode.dart';

// ignore: must_be_immutable
class SaomaTextField extends StatelessWidget {
  FocusNode? focusNode;
  TextEditingController codeController;
  String prefix;
  bool readOnly;
  bool clear;
  String hintText;
  bool autofocus;
  VoidCallback? onClear;

  SaomaTextField(this.codeController, this.prefix,
      {this.focusNode,
      this.readOnly = false,
      this.clear = true,
      this.hintText = "请输入编码",
      this.autofocus = false,
      this.onClear});

  void onPressedClear() {
    codeController.clear();
    if (this.onClear != null) this.onClear!();
  }

  void onPressedScanner(BuildContext context) {
    Navigator.of(context)
        .pushNamed(ScannerPage.routeName)
        .then((value) => {codeController.text = value as String});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 35,
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            Expanded(
                child: Container(
                    child: TextField(
              controller: codeController,
              readOnly: readOnly,
              minLines: 1,
              style: TextStyle(
                fontSize: 12,
                textBaseline: TextBaseline.ideographic,
              ),

              ///焦点获取
              focusNode: focusNode,
              autofocus: autofocus,

              ///用来配置 TextField 的样式风格
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 0),

                  ///设置输入文本框的提示文字
                  ///输入框获取焦点时 并且没有输入文字时
                  hintText: this.hintText,

                  ///输入框获取焦点时才会显示出来 输入文本的前面
                  prefixText: prefix,

                  ///输入文字后面的小图标
                  suffixIcon: this.clear && !this.readOnly
                      ? IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 20,
                          ),
                          onPressed: onPressedClear,
                        )
                      : null),
            ))),
            Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  const IconData(FontIcon.saoma, fontFamily: 'iconfont'),
                  color: !this.readOnly ? Colors.blue : Colors.grey,
                  size: 35,
                ),
                onPressed:
                    !this.readOnly ? () => {onPressedScanner(context)} : null,
              ),
            )
          ],
        ));
  }
}
