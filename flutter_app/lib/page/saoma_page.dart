import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/utils/code.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/widget/saoma_text_field.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class SaomaPage extends StatefulWidget {
  static const String routeName = '/saoma';
  CodeType codeType;
  SaomaPage({this.codeType = CodeType.none});

  @override
  State<StatefulWidget> createState() => _SaomaPageState();
}

class _SaomaPageState extends State<SaomaPage> {
  FocusNode focusNode = new FocusNode();
  var _codeController;

  List<String> _tags = [];
  String _choice = "";
  String prefix = "全部";
  String code = "";
  CodeType type = CodeType.none;

  @override
  void initState() {
    if (focusNode.hasFocus) {
      focusNode.nextFocus();
    }

    getCodes().then((value) => {
          // ignore: unnecessary_null_comparison
          if (value != null)
            {
              setState(() => {_tags = value})
            }
        });

    _codeController =
        TextEditingController.fromValue(TextEditingValue(text: code));
    _codeController.addListener(() {
      code = _codeController.text;
      setState(() {
        prefix = analysisName(code);
      });
      type = analysisCode(code);
      if (type != CodeType.none) {
        var element = getServicesItem(type);
        // ignore: unnecessary_null_comparison
        if (element != null) {
          Navigator.of(context).pushNamed(element.route, arguments: code);
          code = "";
          _codeController.clear();
        } else {
          showToast("编码错误！");
        }
      }
    });

    super.initState();
  }

  Widget _buildSelectButton() {
    if (type == CodeType.none) {
      return TextButton(
        child: Text('选择业务类型'),
        onPressed: () => {_openModalBottomSheet()},
      );
    } else {
      return Container();
    }
  }

  Widget _buildTextInput() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SaomaTextField(this._codeController, this.prefix,
              focusNode: this.focusNode),
          _buildSelectButton()
        ],
      ),
    );
  }

  Widget _buildCodeLayer() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Wrap(
            spacing: 8.0,
            children: _tags.map((tag) {
              return ChoiceChip(
                label: Text(tag),
                selectedColor: Colors.black,
                selected: _choice == tag,
                onSelected: (value) {
                  setState(() {
                    _choice = tag;
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Future _openModalBottomSheet() async {
    final option = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200.0,
            child: ListView(
                children: ServicesCode.map((e) {
              return ListTile(
                title: Text(e.name, textAlign: TextAlign.center),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.of(context).pushNamed(e.route, arguments: code);
                  code = "";
                  _codeController.clear();
                },
              );
            }).toList()),
          );
        });

    print(option);
  }

  // 设置历史编码
  setCodes(List<String> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("code_type", json.encode(data));
  }

  // 获取历史编码
  Future<List<String>> getCodes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getString("code_type");
    // ignore: unnecessary_null_comparison
    if (data == null) {
      return [];
    } else {
      return json.decode(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
            title: Text("扫码"),
          ),
          body: Container(
              child: ListView(
            children: <Widget>[
              _buildTextInput(),
              _buildCodeLayer(),
            ],
          ))),
    );
  }
}
