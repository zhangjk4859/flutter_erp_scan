import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/dao/data_result.dart';
import 'package:flutter_app/dao/product.dart';
import 'package:flutter_app/model/get_goods_sn_response.g.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/vo/get_googs_sn_param.dart';

class StoreInOutPage extends StatefulWidget {
  static const String routeName = '/store_in_out';

  List<GetGoodsSnParamVo> params;
  int state;

  StoreInOutPage(this.params, this.state);

  @override
  State<StatefulWidget> createState() => _StoreInOutPageState();
}

class GoodsCheck {
  bool checked;
  String goods;
  GoodsCheck(this.goods, {this.checked = true});
}

class _StoreInOutPageState extends State<StoreInOutPage> {
  Map<String, List<GoodsCheck>> list = Map<String, List<GoodsCheck>>();

  void doExpansionChanged(
      bool expansion, String goodsSn, GetGoodsSnParamVo param) {
    if (expansion) {
      doGoodsSn(goodsSn, param.optNum).then((value) => {
            setState(() {
              list[goodsSn] = value;
            })
          });
    }
  }

  Future<List<String>> doGoodsSnAll() async {
    List<String> result = [];
    List<String> goodsSn = [];
    List<String> goodsNum = [];
    List<String> goodsExclude = [];
    list.forEach((key, value) {
      value.where((element) => !element.checked).forEach((element) {
        goodsExclude.add(element.goods);
      });
    });
    this.widget.params.forEach((element) {
      goodsSn.add(element.goodsSn);
      goodsNum.add(element.optNum.toString());
    });
    DataResult dataResult = await ProductDao.postProductGoodsSnAll(
        GetGoodsSnParamAll(goodsSn, goodsNum, goodsExclude,
            state: this.widget.state));

    if (dataResult.data != null) {
      GetGoodsSnResponse response = dataResult.data!;
      if (response.data != null) {
        result.addAll(response.data!);
      }
    }
    return result;
  }

  Future<List<GoodsCheck>> doGoodsSn(String goodsSn, int num) async {
    List<GoodsCheck> result = [];
    DataResult dataResult = await ProductDao.postProductGoodsSn(
        GetGoodsSnParam(goodsSn, num, state: this.widget.state));
    if (dataResult.data != null) {
      GetGoodsSnResponse response = dataResult.data!;
      if (response.data != null) {
        List<String>? datas = response.data!;
        if (datas != null) {
          result.addAll(datas.asMap().entries.map((e) => GoodsCheck(e.value)));
        }
      }
    }
    return result;
  }

  @override
  void initState() {
    super.initState();

    if (this.mounted) {
      setState(() {
        this.widget.params.forEach((element) {
          list[element.goodsSn] = [];
        });
      });
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
              title: Text("出入库确认"),
              actions: [
                IconButton(
                    onPressed: () => {
                          doGoodsSnAll().then((value) {
                            if (value.length == 0) {
                              showToast("没有可用商品！");
                            } else {
                              Navigator.of(context).pop(value);
                            }
                          })
                        },
                    icon: Text("确认"))
              ],
            ),
            body: Container(
                child: ListView.builder(
              itemBuilder: (context, index) {
                return ExpansionTile(
                  title: Row(children: [
                    Text(this.widget.params[index].name),
                    Text(
                      "[${this.widget.params[index].goodsSn}]",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ]),
                  subtitle: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text(
                              "全部",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black87),
                            ),
                            Text(
                              "${this.widget.params[index].num}",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              "可入库数",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black87),
                            ),
                            Text(
                              "${this.widget.params[index].waitNum}",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            Text(
                              "待入库数",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black87),
                            ),
                            Text(
                              "${this.widget.params[index].optNum}",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  onExpansionChanged: (exp) => {
                    doExpansionChanged(exp, this.widget.params[index].goodsSn,
                        this.widget.params[index])
                  },
                  initiallyExpanded: false,
                  children: list[this.widget.params[index].goodsSn]!
                      .map((f) => CheckboxListTile(
                            value: f.checked,
                            title: Text(f.goods),
                            dense: true,
                            onChanged: (bool? value) {
                              setState(() {
                                f.checked = value!;
                              });
                            },
                          ))
                      .toList(),
                );
              },
              itemCount: this.widget.params.length,
            ))));
  }
}
