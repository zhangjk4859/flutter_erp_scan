import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/toast.dart';
import 'package:flutter_app/vo/get_googs_sn_param.dart';
import 'package:flutter_app/vo/store_params.dart';
import 'package:flutter_app/widget/group_saoma_text_field.dart';
import 'package:flutter_app/widget/saoma_text_field.dart';

import 'goods_page.dart';

typedef CreateProductCallback = void Function(GroupSaomaDataItem);
typedef BoolCallback = bool Function();
typedef StoreParamCallback = StoreParam? Function(GroupSaomaDataItem item);
typedef ProductCallback = void Function(
    String val, CreateProductCallback callback);
typedef StoreCallback = void Function(List<GetGoodsSnParamVo> param);

// ignore: must_be_immutable
class StorePage extends StatefulWidget {
  Widget title;
  Widget storeTitle;
  Widget child;

  TextEditingController saomaController;
  bool saomaReadOnly;
  VoidCallback onSaomaClear;
  StoreCallback onStore;
  BoolCallback onStoreShow;
  BoolCallback? onSaomaShow;
  ProductCallback onProduct;

  StoreParamCallback onStoreParam;
  bool? allowStoreNull;

  StorePage({
    required this.title,
    required this.storeTitle,
    required this.saomaController,
    required this.onSaomaClear,
    required this.onStore,
    required this.onStoreShow,
    required this.onStoreParam,
    required this.onProduct,
    required this.child,
    required this.saomaReadOnly,
    this.allowStoreNull = false,
    this.onSaomaShow,
  });

  @override
  State<StatefulWidget> createState() => _StorePage();
}

// 仓储
class _StorePage extends State<StorePage> {
  List<GroupSaomaDataItem> products = [];

  // 查看商品信息
  void onProductTap(GroupSaomaDataItem val) {
    Navigator.of(context).pushNamed(GoodsPage.routeName,
        arguments: this.widget.onStoreParam(val));
  }

  // 删除批量扫码商品
  void onProductDelete(GroupSaomaDataItem val) {
    setState(
        () => {this.products.removeWhere((element) => val.sn == element.sn)});
  }

  // 商品数量发送变更
  void onProductChanage(GroupSaomaDataItem val) {
    setState(() => {
          this.products.firstWhere((element) => val.sn == element.sn).num =
              val.num
        });
  }

  List<GetGoodsSnParamVo> getGoodsSnParamVo() {
    return products
        .asMap()
        .entries
        .map((e) => GetGoodsSnParamVo(
              e.value.name,
              e.value.sn,
              num: e.value.allNum,
              optNum: e.value.num,
              waitNum: e.value.surplusNum,
            ))
        .toList();
  }

  // 扫码时创建商品
  void onProduct(String val) {
    if (!this.products.any((element) => val == element.sn)) {
      this.widget.onProduct(
          val,
          (data) => {
                setState(() => {this.products.add(data)})
              });
    }
  }

  void onClear() {
    this.products.clear();
    this.widget.onSaomaClear();
  }

  void onStore() {
    if (this.widget.allowStoreNull!) {
      this.widget.onStore(getGoodsSnParamVo());
    } else {
      if (products.length == 0) {
        showToast("请扫描或输入可用商品！");
      } else {
        this.widget.onStore(getGoodsSnParamVo());
      }
    }
  }

  bool onSaomaShow() {
    if (this.widget.onSaomaShow == null) {
      return true;
    } else {
      return this.widget.onSaomaShow!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          this.widget.onStoreShow()
              ? IconButton(
                  onPressed: this.onStore, icon: this.widget.storeTitle)
              : Container()
        ],
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
        title: this.widget.title,
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  child: SaomaTextField(
                    this.widget.saomaController,
                    "",
                    hintText: "请输入订单号或扫码",
                    autofocus: false,
                    readOnly: this.widget.saomaReadOnly,
                    onClear: this.onClear,
                  ),
                ),
                this.widget.onStoreShow() && this.onSaomaShow()
                    ? GroupSaomaTextField(
                        products,
                        onProduct,
                        onProductChanage,
                        onDelete: onProductDelete,
                        onTap: onProductTap,
                        hitText: "请输入订单产品或扫码",
                      )
                    : Container(),
              ],
            )),
            Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.zero,
                  child: this.widget.child,
                ))
          ],
        ),
      ),
    );
  }
}
