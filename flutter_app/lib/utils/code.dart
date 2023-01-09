import 'package:flutter_app/page/allocation_page.dart';
import 'package:flutter_app/page/assembly_page.dart';
import 'package:flutter_app/page/product_page.dart';
import 'package:flutter_app/page/purchase_return_page.dart';
import 'package:flutter_app/page/purchase_page.dart';
import 'package:flutter_app/page/sale_page.dart';
import 'package:flutter_app/page/sale_return_page.dart';
import 'package:flutter_app/page/supplier_page.dart';

/**
 *  供应商	1	B	固定	6	000001-999999	序号							7	B000001
 *  门店	  1	M	固定	6	000001-999999	序号							7	B000001
 * 
    产品	  1	P	固定	8	00000001-99999999	序号							9	P00000001

    采购订单	1	C	固定	6	供应商	引用	6	000001-999999	序列号				13	C00000010000001
    采购退货	1	T	固定	6	供应商	引用	6	000001-999999	序列号				13	T00000010000001

    销售订单	2	MC	固定	6 门店编号	引用	6	000001-999999	序列号				13	MC00000010000001
    销售退货	2	MT	固定	6	门店编号	引用	6	000001-999999	序列号				13	MT00000010000001

    调拨	1	D	固定	8	20210101	时间	6	000001-999999	序列号				13	D202101010000001
    组装	1	A	固定	8	20210101	时间	6	000001-999999	序列号				13	A202101010000001

    单个产品	1	G	固定	6	供应商	引用	8	产品	引用	6	000001-999999	序列号	23	G0000001000000001000001
 */

enum CodeType {
  none, //未知
  supplier, // 供应商
  product, // 产品
  purchase, // 采购订单
  purchase_return, //采购退货
  //purchase_compensation, //采购索赔
  sale, // 销售订单
  sale_return, //销售退货
  //sale_compensation, // 销售索赔
  allocation, //调拨
  assembly_task, //组装任务
  assembly_instance, //实例组件
  product_instance, //实例产品
}

class ServicesItem {
  String name;
  String prefix;
  String reg;
  CodeType code;
  String route;
  ServicesItem(this.prefix, this.name, this.reg, this.code, this.route);
}

List<ServicesItem> ServicesCode = [
  ServicesItem(
      "B", "供应商", r"^B([0-9]{6})$", CodeType.supplier, SupplierPage.routeName),
  ServicesItem(
      "P", "商品/组件", r"^P([0-9]{8})$", CodeType.product, ProductPage.routeName),
  ServicesItem("C", "采购订单", r"^C([0-9]{6})([0-9]{6})$", CodeType.purchase,
      PurchasePage.routeName),
  ServicesItem("T", "采购退货", r"^T([0-9]{6})([0-9]{6})$",
      CodeType.purchase_return, PurchaseReturnPage.routeName),
  /*ServicesItem(
      "采购索赔", r"^S([0-9]{6})([0-9]{6})$", CodeType.purchase_compensation, "/"),*/
  ServicesItem("MC", "销售订单", r"^MC([0-9]{6})([0-9]{6})$", CodeType.sale,
      SalePage.routeName),
  ServicesItem("MT", "销售退货", r"^MT([0-9]{6})([0-9]{6})$", CodeType.sale_return,
      SaleReturnPage.routeName),
  /*ServicesItem(
      "门店索赔", r"^MS([0-9]{6})([0-9]{6})$", CodeType.sale_compensation, "/"),*/
  ServicesItem("D", "调拨", r"^D([0-9]{8})([0-9]{6})$", CodeType.allocation,
      AllocationPage.routeName),
  ServicesItem("A", "组件任务", r"^A([0-9]{8})([0-9]{6})$", CodeType.assembly_task,
      AssemblyPage.routeName),
  /* ServicesItem("单个组件", r"^A([0-9]{14})([0-9]{8})$", CodeType.assembly_instance,
      ProductPage.routeName),*/
  ServicesItem("G", "单个产品", r"^G([0-9]{6})([0-9]{8})([0-9]{6})$",
      CodeType.product_instance, ProductPage.routeName),
];

ServicesItem getServicesItem(CodeType type) {
  var result;
  ServicesCode.forEach((element) {
    // ignore: unrelated_type_equality_checks
    if (element.code == type) {
      result = element;
      return;
    }
  });
  return result;
}

String analysisName(String code) {
  var result = "全部";
  ServicesCode.forEach((element) {
    if (code.indexOf(element.prefix) == 0) {
      result = element.name;
      return;
    }
  });
  return result;
}

CodeType analysisCode(String code) {
  var result = CodeType.none;
  ServicesCode.forEach((element) {
    RegExp regExpStr = new RegExp(element.reg);
    if (regExpStr.hasMatch(code)) {
      result = element.code;
      return;
    }
  });
  return result;
}
