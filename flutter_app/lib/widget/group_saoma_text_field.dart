import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/utils/code.dart';
import 'package:flutter_app/widget/saoma_text_field.dart';

typedef ProductCallback = void Function(String data);
typedef PressedCallback = void Function(GroupSaomaDataItem data);
typedef ChangeCallback = void Function(GroupSaomaDataItem data);

// ignore: must_be_immutable
class GroupSaomaTextField extends StatefulWidget {
  List<GroupSaomaDataItem> datas = [];
  final String prefix;
  final String hitText;
  final ProductCallback onProduct;
  final ChangeCallback onChange;
  final PressedCallback? onDelete;
  final PressedCallback? onTap;
  final EdgeInsetsGeometry? padding;

  GroupSaomaTextField(
    this.datas,
    this.onProduct,
    this.onChange, {
    this.prefix = "",
    this.hitText = "",
    this.onDelete,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
  });

  @override
  State<StatefulWidget> createState() {
    return _GroupSaomaTextFieldState();
  }
}

class _GroupSaomaTextFieldState extends State<GroupSaomaTextField> {
  late TextEditingController _saomaController;
  final double height = 1.0;

  String sn = "";

  @override
  void initState() {
    _saomaController =
        TextEditingController.fromValue(TextEditingValue(text: sn));
    _saomaController.addListener(() {
      setState(() {
        sn = _saomaController.text.toUpperCase();
      });

      CodeType type = analysisCode(sn);
      if (type == CodeType.product_instance) {
        this.widget.onProduct(sn);

        sn = "";
        _saomaController.clear();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: this.widget.padding,
        child: Column(children: [
          SaomaTextField(
            _saomaController,
            this.widget.prefix,
            hintText: this.widget.hitText,
          ),
          Container(
            padding: EdgeInsets.zero,
            height: this.widget.datas.length * 50 + 3,
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemExtent: 50,
                itemBuilder: (BuildContext context, int index) => Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 0),
                      height: 50,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: Container(
                                padding: EdgeInsets.zero,
                                height: 35.0,
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      this.widget.datas[index].name,
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Text(
                                      this.widget.datas[index].sn,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 11),
                                    ),
                                  ],
                                )),
                            onTap: () => {
                              if (this.widget.onTap != null)
                                this.widget.onTap!(this.widget.datas[index])
                            },
                          ),
                          Container(
                            padding: EdgeInsets.zero,
                            height: 30.0,
                            width: 40.0,
                            child: TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(6),
                              ],
                              autofocus: true,
                              initialValue:
                                  this.widget.datas[index].num.toString(),
                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                if (val == "") {
                                  val = "1";
                                }
                                this.widget.datas[index].num = int.parse(val);
                                this.widget.onChange(this.widget.datas[index]);
                              },
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  ///用来配置边框的样式
                                  borderSide: BorderSide(
                                    ///设置边框的颜色
                                    color: Colors.grey,

                                    ///设置边框的粗细
                                    width: 1.0,
                                  ),
                                ),

                                ///用来配置输入框获取焦点时的颜色
                                focusedBorder: UnderlineInputBorder(
                                  ///用来配置边框的样式
                                  borderSide: BorderSide(
                                    ///设置边框的颜色
                                    color: Colors.blue,

                                    ///设置边框的粗细
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.zero,
                            height: 30.0,
                            child: IconButton(
                              icon: Icon(Icons.close),
                              iconSize: 12,
                              onPressed: () => {
                                if (this.widget.onDelete != null)
                                  {
                                    this
                                        .widget
                                        .onDelete!(this.widget.datas[index])
                                  }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                itemCount: this.widget.datas.length),
          ),
        ]));
  }
}

class GroupSaomaDataItem {
  int num = 1; // 数量
  int allNum = 1; //全部
  int surplusNum = 1;
  String name = ""; // 商品名称
  String sn = ""; // 商品编号
  GroupSaomaDataItem(this.name, this.sn,
      {this.num = 1, this.allNum = 1, this.surplusNum = 1});
}
